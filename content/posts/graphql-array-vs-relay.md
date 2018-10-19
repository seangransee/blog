---
title: "Returning Arrays in GraphQL - Simple Lists vs Relay-style pagination"
date: 2018-10-18T19:52:14-05:00
---

_This is part of a series about [decisions my team made with our GraphQL schema]({{< relref "graphql-decisions.md" >}}). Check out that post for context, or to read about other decisions we made._

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

This quickly became a huge pain in the ass. We added flexibility at the expense of increased verbosity. The increased complexity of this solution made our queries more difficult to write and our responses more difficult to parse. What used to be a simple `map()` now required delving into two additional levels of nesting to pull out the data. Any time I _didn't_ want to paginate my results (which was the vast majority of the time), I found myself thinking **"I just want a simple array, dammit!"**

Our solution? Implement both patterns, as needed. For fields that will never return a huge set of data, we use the [simple array pattern](https://graphql.org/learn/pagination/#plurals). For fields that will always return a huge set of data, we use the [Relay connection pattern](https://graphql.org/learn/pagination/#complete-connection-model) and suffix the field name with "Connection". (For example, `usersConnection`.) For fields that are ambiguous, we provide both in our API. This leaves us with something like this, where we can query for all users at once, or just a certain chunk:

### Schema

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

### Request

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

### Response

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

I used to look at this and fret about making my schema too big, but then I came to the realization that it doesn't really matter. Nobody is going to read your schema top-to-bottom. Your server-side GraphQL library probably has an abstraction that generates all these Connection types for you and handles the pagination logic so you don't have to reinvent the wheel. (We use Ruby's `graphql` gem, which [handles this perfectly](http://graphql-ruby.org/relay/connections.html).) Our schema file is currently 938 lines, and the size of our schema hasn't been a problem whatsoever.

It's okay to provide both a simple _and_ and a flexible way of requesting the same set of data. You can have the best of both worlds with a minimal cost.
