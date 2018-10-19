---
title: "Decisions My Team Made With Our GraphQL Schema"
date: 2018-10-18T09:12:02-05:00
---

I love GraphQL. Since deploying our initial GraphQL API at [SwipeSense](https://www.swipesense.com/), the speed at which we've been able to build new capabilities into our applications has been unparalleled by any REST-based system I've worked with.

If I had to pick a downside to adopting GraphQL, I'd say it's the newness of the whole ecosystem. The [spec](http://facebook.github.io/graphql/June2018/) is very loose (by design), and it hasn't been around long enough for many best practices to emerge. The [best practices](https://graphql.org/learn/best-practices/) page in the official docs talks about how to serve your API, but doesn't offer much insight into designing a schema. When I'm working with more mature tools and I come across a problem that I feel isn't at all unique to my application, I can usually do 5 minutes of Googling to find a generally accepted way to solve the problem. Not so with GraphQL. I often find myself venturing into seemingly uncharted territory to represent data access patterns that exist in almost all web applications.

Our GraphQL API has been humming along in production for almost a year, servicing about a dozen applications (user-facing web apps, in addition to internal microservices running in AWS Lambda). There was the initial awkwardness that comes with adopting any new technology, but at this point our API has evolved to the point where I'm pretty happy with it. I wanted to lay out some of the decisions we've settled on regarding our schema, as well as mistakes we've made along the way.

Note that this is a sample size of one, and therefore not a "definitive guide". What works for us may not work for you, but hopefully some of the patterns in this post can be of use to anyone doing the same Google searches that I've been doing over the past year.

## The good decisions

Most of this was settled on after quite a bit of iteration.

- [We defined related singular and plural fields at the same level in the schema.]({{< relref "graphql-singular-plural-fields.md" >}})
- [Our schema has options to return an array _or_ a paginated Relay-style connection.]({{< relref "graphql-array-vs-relay.md" >}})
- [We included redundant relationships wherever possible.]({{< relref "graphql-redundant-relationships.md" >}})
- [We make breaking changes when necessary, with a plan for zero downtime.]({{< relref "graphql-breaking-changes.md" >}})

## The bad decision

We're kinda stuck with this one, but we've learned our lesson moving forward.

- [We created a scalar field with a name that wasn't descriptive enough.]({{< relref "graphql-scalar-vs-object.md" >}})
