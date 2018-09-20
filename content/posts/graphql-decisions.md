---
title: "Decisions We Made With Our GraphQL Schema"
date: 2018-09-19T09:12:02-05:00
draft: true
---

I love GraphQL. Since deploying our initial GraphQL API at [SwipeSense](https://www.swipesense.com/), the speed at which we've been able to add new capabilities to our API and new features to the applications that consume our API has been unparalleled by any REST-based system I've worked with.

If I had to pick a downside of adopting GraphQL, I'd say it's the newness of the whole ecosystem. The [spec](http://facebook.github.io/graphql/June2018/) is very loose (by design), and it hasn't been around long enough for many best practices to emerge. (The [best practices](https://graphql.org/learn/best-practices/) page in the official docs talks about how to serve your API, but doesn't offer much for designing a schema.) When I'm working with other tools and I come across a problem that I feel isn't at all unique to my application, I can usually do 5 minutes of Googling to find a generally accepted way to solve the problem. Not so with GraphQL. I often find myself venturing into seemingly uncharted territory to represent data access patterns that exist in almost all web applications.

Our GraphQL API has been humming along in production for almost a year, servicing about a dozen applications (user-facing web apps, in addition to internal microservices running in AWS Lambda). There was some initial awkwardness, as happens when adopting any new technology, but at this point our API has evolved to the point where I'm pretty happy with it. I wanted to lay out some of the decisions we've settled on regarding our schema, as well as mistakes we've made along the way.

Note that this is a sample size of one, and therefore not a "definitive guide". What works for us may not work for you, but hopefully some of the patterns in this post can be of use to anyone doing the same Google searches that I was doing a year ago.

# Singular and plural fields

Pretty much every API needs to support the access pattern where you need to be able to query for a single **user**, and you also need to query for multiple **users**. (Replace "user" with any type of data your application represents.) I played around with a few ways to handle this, and ended up putting both a singluar and a plural field of the same type at the same level of the schema. The singular field has a required primary key argument and is used to find a specific record. The plural field returns all records of that type by default, but includes an optional argument that can be used to filter the results. Here's an example with a `User` type:

#### Schema

<pre>
<code class="language-graphql">
type User {
  id: ID!
  name: String!
}

type Query {
  # `id` is a required argument for the singular `user` field,
  # used to search for a specific user
  user(id: ID!): User

  # `ids` is an optional array argument for the plural `users` field.
  # Not providing it will make the API return all users
  # to which the requester has access.
  users(ids: [ID!]): [User!]!
}
</code>
</pre>

#### Request

<pre>
<code class="language-graphql">
{
  user(id: 51) {
    id
    name
  }

  # Note that these next two fields are both the same `users` field,
  # and I'm just aliasing them to the names `someUsers` and `allUsers`.
  someUsers: users(ids: [52, 53]) {
    id
    name
  }

  allUsers: users {
    id
    name
  }
}
</code>
</pre>

#### Response

<pre>
<code class="language-json">
{
  "data": {
    "user": {
      "id": "51",
      "name": "Michael Scott"
    },
    "someUsers": [
      {
        "id": "52",
        "name": "Jim Halpert"
      },
      {
        "id": "53",
        "name": "Pam Beesly"
      }
    ],
    "allUsers": [
      {
        "id": "51",
        "name": "Michael Scott"
      },
      {
        "id": "52",
        "name": "Jim Halpert"
      },
      {
        "id": "53",
        "name": "Pam Beesly"
      },
      {
        "id": "54",
        "name": "Dwight Schrute"
      }
    ]
  }
}
</code>
</pre>

# Returning an array vs. a paginated Relay-style connection

For fields that could potentially return a huge set of data, returning the entire result set in an array just doesn't cut it. We have one field that returns time series data scoped to a time range, and that field could potentially return millions of results when scoped to a large enough time range. We definitely didn't want to have our API return _all_ results in this instance, so we needed a way to paginate the results. The GraphQL docs suggest a [way to paginate results](https://graphql.org/learn/pagination/#pagination-and-edges), which seemed perfect for having our application request data in smaller chunks and presenting it with infinite scroll. This type of field is often referred to as a [Relay-style connection](https://facebook.github.io/relay/graphql/connections.htm) and is supported out of the box by a number of GraphQL client and server libraries.

Doing this allowed us to write some queries that look something like this to fetch data 250 records at a time:

<pre>
<code class="language-graphql">
# This query can be used to populate an infinitely scrolling list in a UI
{
  country(name: "United States") {
    cities(first: 250, after: "Y3Vyc29yMQ==") {
      totalCount # Knowing the total count is useful for controlling size of scrollbar
      edges {
        node {
          name
        }
        cursor
      }
      pageInfo {
        endCursor # allows us to query for the next page
        hasNextPage # tells us when to stop making more requests
      }
    }
  }
}
</code>
</pre>

This works great for fields that can return huge result sets.

In order to maintain consistency, we started by making _all_ of our plural fields return a Relay-style connection. With that approach, something that could have been queried like this...

<pre>
<code class="language-graphql">
{
  currentUser {
    friends {
      name
    }
  }
}
</code>
</pre>

... now had to be queried like this ...

<pre>
<code class="language-graphql">
{
  currentUser {
    friends {
      edges {
        node {
          name
        }
      }
    }
  }
}
</code>
</pre>

This quickly became a huge pain in the ass. We added flexibility at the expense of increased verbosity. The increased complexity of this solution made our queries more difficult to write and our responses more difficult to iterate through. What used to be a simple `map()` now required delving into two additional levels of nesting to pull out the data. Any time I _didn't_ want to paginate my results (which was the vast majority of the time), I found myself thinking **"I just want a simple array, dammit!"**

Our solution? Implement both patterns, as needed. For fields that will never return a huge set of data, we use the [simple array pattern](https://graphql.org/learn/pagination/#plurals). For fields that will always return a huge set of data, we use the [Relay connection pattern](https://graphql.org/learn/pagination/#complete-connection-model) and suffix the field name with "Connection". (For example, `usersConnection`.) For fields that are ambiguous, we provide both in our API. This leaves us with something like this, where we can query for all users at once, or just a certain chunk:

#### Schema

<pre>
<code class="language-graphql">
type User {
  id: ID!
  name: String!
}

type UserConnection {
  edges: [UserEdge]
  pageInfo: PageInfo!
  totalCount: Int!
}

type UserEdge {
  cursor: String!
  node: User
}

type PageInfo {
  endCursor: String
  hasNextPage: Boolean!
  hasPreviousPage: Boolean!
  startCursor: String
}

type Query {
  # returns a single User
  user(id: ID!): User

  # returns a simple array of Users
  users(ids: [ID!]): [User!]!

  # returns a connection that you can paginate through
  usersConnection(
    first: Int
    after: String
    last: Int
    before: String
  ): UserConnection!
}
</code>
</pre>

#### Request

<pre>
<code class="language-graphql">
{
  # Get all users
  users {
    name
  }

  # Get only 2 users
  usersConnection(first: 2) {
    edges {
      node {
        name
      }
    }
    pageInfo {
      endCursor # start here when getting next page
    }
  }
}
</code>
</pre>

#### Response

<pre>
<code class="language-json">
{
  "data": {
    "users": [
      {
        "name": "Michael Scott"
      },
      {
        "name": "Jim Halpert"
      },
      {
        "name": "Pam Beesly"
      },
      {
        "name": "Dwight Schrute"
      }
    ],
    "usersConnection": {
      "edges": [
        {
          "node": {
            "name": "Michael Scott"
          }
        },
        {
          "node": {
            "name": "Jim Halpert"
          }
        }
      ],
      "pageInfo": {
        "endCursor": "Y3Vyc29yMQ=="
      }
    }
  }
}
</code>
</pre>

You might look at that schema and think it looks scary. I did too at first! If you have a lot of different types that you want to paginate through, you'll end up with a ton of nearly-identical Connection and Edge types that inflate the size of your schema.

I used to look at this and fret about making my schema too big, but then I came to the realization that it doesn't really matter. Nobody is going to read your schema top-to-bottom. Your server-side GraphQL library probably has an abstraction that generates all these Connection types for you and handles the pagination logic so you don't have to reinvent the wheel. (We use Ruby's `graphql` gem, which [handles this perfectly](http://graphql-ruby.org/relay/connections.html).) Our schema is currently 938 lines, and the size of our schema hasn't been a problem whatsoever.

It's okay to provide both a simple _and_ and a flexible way of requesting the same set of data. You can have the best of both worlds with a minimal cost.

# Including redundant relationships in types

Let's say you're modeling the users in a set of companies. Each company has offices scattered across multiple cities, each of which is split into departments that contain a collection of users. It might be tempting to model your schema like this to keep it lean:

#### Schema

<pre>
<code class="language-graphql">
type User {
  name: String!
  department: Department!
}

type Department {
  name: String!
  office: Office!
}

type Office {
  city: String!
  company: Company!
}

type Company {
  name: String!
}

type Query {
  user(id: ID!): User
}
</code>
</pre>

This schema is nice and small, and doesn't include any redundant ways to access information. It probably maps closely to how your database would be set up in this situation.

Let's look at how we would query for the `Company` a certain user belongs to.

#### Request

<pre>
<code class="language-graphql">
{
  user(id: 51) {
    name
    department {
      office {
        company {
          name
        }
      }
    }
  }
}
</code>
</pre>

#### Response

<pre>
<code class="language-json">
{
  "data": {
    "user": {
      "name": "Michael Scott",
      "department": {
        "office": {
          "company": {
            "name": "Dunder Mifflin"
          }
        }
      }
    }
  }
}
</code>
</pre>

The name of the company this user works for is 7 layers deep in the response! The only time I want seven layers is when I'm eating a Mexican bean dip. It's fine to have a response like this occasionally, but if this is a common access pattern, I'd add a `company` field directly to the `User` type. This looks much better:

#### Schema

<pre>
<code class="language-graphql">
type User {
  name: String!
  department: Department!
  company: Company!
}

# Rest of types unchanged from previous example
</code>
</pre>

#### Request

<pre>
<code class="language-graphql">
{
  user(id: 51) {
    name
    company {
      name
    }
  }
}
</code>
</pre>

#### Response

<pre>
<code class="language-json">
{
  "data": {
    "user": {
      "name": "Michael Scott",
      "company": {
        "name": "Dunder Mifflin"
      }
    }
  }
}
</code>
</pre>

Our API includes these redundant relationships wherever possible. There's a tiny bit of overhead in the server-side codebase to maintain all these relationships, but the ease of being able to go to any relationship in one "hop" more than makes up for it. I'd recommend that anyone building a GraphQL API at least consider this tradeoff and decide for themselves whether it's worth it.

# Make breaking changes when necessary

One of the core promises of GraphQL is that you can build an API [without versioning or breaking changes](https://graphql.org/learn/best-practices/#versioning). Breaking changes occur when a field gets removed or its return type gets modified. In a perfect world, you'd continue adding fields and types as your API evolves without ever needing to remove or modify anything.

In practice, you're going to make mistakes. Your ideas of how you want to use your API will evolve over time, as will the requirements of the applications consuming your data. A decision you made a year ago might not look like such a good idea today.

If you control all the applications that consume your API (i.e. you customers aren't using your API directly to build their own apps), then it's totally possible to make breaking changes to your API without breaking any of your apps.

Here's a simplified example. Let's say your `User` type has a `name` field, but you want to rename it to `fullName`. You have a couple apps that read the `name` field, so deleting that field will break your apps. Follow this three-step process to rename the field without any downtime:

1. Add a _new_ `fullName` field to the API, which resolves to the exact same thing as the `name` field, and deploy to your API server.
2. In any of your applications that consume your API and query the `name` field, replace all those references with `fullName`, and deploy your applications.
3. You can now safely remove the `name` field from your API.

If you don't want to bother with steps 2 and 3, GraphQL provides a way to [deprecate a field](https://facebook.github.io/graphql/draft/#sec-Field-Deprecation) using the `@deprecated` token. This will make the field continue to function, but it will deter further usage of that field because the field won't show up in GraphiQL's autocomplete and will show up in a different section of the documentation.

If your users are directly consuming your API to build their own scripts and applications, it's probably best to avoid breaking changes entirely. That being said, [GitHub sometimes introduces breaking changes](https://developer.github.com/v4/breaking_changes/) to their GraphQL API and they have a process for handling it.

The good:

- Made breaking changes when necessary
- Using through relationships in fields (i.e. user --> facility)
- Singular vs plural
- Array vs connection - using both

The bad:

- Using "floor" as a scalar when we later wanted it to be an object
