---
title: "Breaking Changes in GraphQL with Zero Downtime"
date: 2018-10-18T19:54:19-05:00
---

_This is part of a series about [decisions my team made with our GraphQL schema]({{< relref "graphql-decisions.md" >}}). Check out that post for context, or to read about other decisions we made._

One of the core promises of GraphQL is that you can build an API [without versioning or breaking changes](https://graphql.org/learn/best-practices/#versioning). Breaking changes occur when a field gets removed or its return type gets modified. In a perfect world, you'd continue adding fields and types as your API evolves without ever needing to remove or modify anything.

In practice, you're going to make mistakes. Your ideas of how you want to use your API will evolve over time, as will the requirements of the applications consuming your data. A decision you made a year ago might not look like such a good idea today.

If you control all the applications that consume your API (i.e. your customers aren't using your API directly to build their own apps), then it's totally possible to make breaking changes to your API without breaking any of your apps.

Here's a simplified example. Let's say your `User` type has a `name` field, but you want to rename it to `fullName`. You have a couple apps that query the `name` field, so deleting that field will break your apps. Follow this three-step process to rename the field without any downtime:

1. Add a _new_ `fullName` field to the API, which resolves to the exact same thing as the `name` field, and deploy to your API server.
2. In any of your applications that consume your API and query the `name` field, replace all those references with `fullName`, and deploy your applications.
3. You can now safely remove the `name` field from your API.

If you don't want to bother with steps 2 and 3, GraphQL provides a way to [deprecate a field](https://facebook.github.io/graphql/draft/#sec-Field-Deprecation) using the `@deprecated` token. This will make the field continue to function, but it will deter further usage of that field because the field won't show up in GraphiQL's autocomplete and will show up in a special "deprecated" section of the documentation.

If your users are directly consuming your API to build their own scripts and applications, it's probably best to avoid breaking changes entirely. That being said, [GitHub sometimes introduces breaking changes](https://developer.github.com/v4/breaking_changes/) to their GraphQL API and they have a process for handling it.
