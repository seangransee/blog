---
title: "Singular and Plural Fields in GraphQL"
date: 2018-10-08T19:50:24-05:00
draft: true
---

_This is part of a series about [decisions my team and I made with our GraphQL schema]({{< relref "graphql-decisions.md" >}}). Check out that post for context, or to read about other decisions we made._

Pretty much every API needs to support an access pattern where you need to be able to query for a single **user**, and you also need to query for multiple **users**. (Replace "user" with any type of data your application models.) I played around with a few ways to handle this, and ended up putting both a singluar and a plural field of the same type at the same level of the schema. The singular field has a required primary key argument and is used to look up a specific record. The plural field returns all records of that type by default, but includes an optional argument that can be used to filter the results. Here's an example with a `User` type:

### Schema

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

### Request

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

### Response

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
