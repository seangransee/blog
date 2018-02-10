---
title: "What is a linked list?"
date: 2012-08-09T09:25:27-06:00
---

_This post is from an old blog I had called Software Cake, where I explained technical terms by talking about cake._

***

Your city has just begun its annual Cake Tour Extravaganza. As a die-hard cake lover, you couldn’t be more excited for today.

The concept is simple. You can walk into any participating bakery in the city and try some cake. Afterwards, the bakery directs you to the location of another bakery. You can keep following this chain until you get to the end, and hope you don’t get diabetes along the way.

The city doesn’t release the names or locations of any participating bakeries except for one. If you want to go on this cake tour and you don’t have inside information about the participating bakeries, you need to start at the beginning and follow the chain until you’re satisfied.

**Let’s put this into technical terms…**

A linked list is essentially just a location in the computer’s memory, just like the location of the first bakery. At this location, you have the first item in the list. Right next to it, you have a pointer to the location of the second item. When you follow this pointer you arrive at the second item, and right next to it there is a pointer to the third item. At the very end of the list there is a _terminator_, which tells the computer that it has reached the end of the list. Fortunately, a computer can move to another location much faster than you can move to another bakery.

**Why not just use an array?**

That’s a good question. With an array, you can instantly jump to any point in the list. You don’t need to start at the beginning and go through them all, so isn’t that better? Depends on the situation. In an array, all the items are right next to each other in the computer’s memory. That would be like putting 30 bakeries right next to each other on one city block. It’s possible if there is a large vacant piece of real estate, but it’s not always guaranteed that this will be the case. Also, what if you want to put a new bakery in the middle? When they’re all adjacent with each other, you can’t stick a new bakery in the middle. But with the first example, you can instruct the bakery owners to direct customers to a different location if a new bakery joins the party.

Now go out and eat some cake! Did I mention that it’s free today?
