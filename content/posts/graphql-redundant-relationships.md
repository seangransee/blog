---
title: "Graphql Redundant Relationships"
date: 2018-10-08T19:53:39-05:00
draft: true
---

_This is part of a series about [decisions my team and I made with our GraphQL schema]({{< relref "graphql-decisions.md" >}}). Check out that post for context, or to read about other decisions we made._

Let's say you're modeling the users in a set of companies. Each company has offices scattered across multiple cities, each of which is split into departments that contain a collection of users. It might be tempting to model your schema like this to keep it lean:

### Schema

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

### Request

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

### Response

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

### Schema

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

### Request

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

### Response

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
