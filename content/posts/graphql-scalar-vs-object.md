---
title: "The Issue With GraphQL Field Names That Aren't Descriptive Enough"
date: 2018-10-18T19:58:30-05:00
---

_This is part of a series about [decisions my team made with our GraphQL schema]({{< relref "graphql-decisions.md" >}}). Check out that post for context, or to read about other decisions we made._

One of the bad decisions we made when building our schema was defining a scalar field with a name that would likely be used in the future by a full object.

Let's say you're modeling a `Building` containing multiple `Rooms`, and you start with a schema like this:

<pre>
<code class="language-graphql">
type Room {
  name: String!
  wallColor: String
}

type Building {
  rooms: [Room!]!
}
</code>
</pre>

Let's say you now need to expose which floor each room is on. It may be tempting to do something like this:

<pre>
<code class="language-graphql">
type Room {
  name: String!
  wallColor: String

  floor: String!  # Example values: "Basement", "1", "2", "Penthouse"
}
</code>
</pre>

This works great as long as the _name_ of the floor is the only information you'll ever have about your floor. But what happens when you need something like an image of the floor plan, or an index so you can sort the floors in the order that they'd appear in an elevator? It might get to the point where it makes more sense to have a dedicated `Floor` object type.

But then how do you access that new `Floor` object from your `Room` object? The `floor` field is already taken, and it's just used to display the _name_ of the floor. That field currently returns a string, and you can't define it to return your new `Floor` object type without making a [breaking change]({{< relref "graphql-breaking-changes.md" >}}). You'll have to make a new awkwardly-named field, such as `floorInfo`, and your schema will end up looking like this.

<pre>
<code class="language-graphql">
type Floor {
  name: String!
  index: Int
  floorPlanUrl: String
}

type Room {
  name: String!
  wallColor: String

  floor: String     # Only the floor's name
  floorInfo: Floor  # Relationship to the actual Floor type
}

type Building {
  rooms: [Room!]!
}
</code>
</pre>

This gets the job done, but in hindsight, it would have been better to free up the `floor` field for when we needed it to return a full object type. We could have been more descriptive with the initial name of this field. `floorName` would have been a perfectly good name, and would have left the door open for a relationship to a full `Floor` object type in the future.

Lesson learned: Be descriptive with the field names in your GraphQL schema. If a field's name is too general, you might find yourself wishing that field name was still available when you want to introduce a new object type.
