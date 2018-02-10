---
title: "What are APIs and why are they important? "
date: 2012-08-08T00:04:31-06:00
---

_This post is from an old blog I had called Software Cake, where I explained technical terms by talking about cake._

***

You like cake, right? Of course you do. But you’re not good at making cake.

Your friend (let’s call him the cakemaster) teaches you how to bake the perfect cake. You learn which store to go to, which shelf each ingredient is on, and how to follow the recipe. You now know how to bake the perfect cake.

You start baking yourself a yummy cake every week. One day your friend, the cakemaster, gets eaten by lions. Doesn’t matter though, because your cake is so damn delicious that nothing can bother you. You continue to bake yourself a cake every week for the next few months.

Then one day the store closes. Oh shit! The cakemaster isn’t around to teach you how to bake a cake with ingredients from another store. You can’t make cake any more, and your existence is meaningless.

**Now let’s look at another scenario…**

You like cake, and your friend is very good at making cake. Every week you ask him for a cake, and he delivers.

Then one day, the store closes down. Not a problem, because your friend is so good at making cake that he can adapt. So he goes to a new store, uses a different recipe with different ingredients, and gives you the same delicious cake.

However, you have no idea that any of this is going on. You just know that every time you ask your friend for a cake, he gives you a cake. You don’t need to know anything about the process of baking a cake, you just need to ask for cake to receive cake.

**Let’s put this into technical terms…**

You are the user-facing interface for an application. Your friend is the API. The store is the database.

If you’re a mobile app, your code is on a device until a user manually updates you. You can’t simply change on the fly. That’s why you need to be able to just make a request (“I want cake!”) and receive a response (a delicious cake) without any knowledge of how the process works. Databases can change shape, process can be rewritten, and the user-facing part of the app continues to run smoothly.

Even if your code can change on the fly, it’s much easier for a frontend developer to make something happen when he needs no knowledge about how the backend works.

If you want outside developers to be able to integrate your service (think Facebook, Twitter, Instagram, etc.) into theirs, they can safely do so by using your API without needing direct access to your database or any of the inner workings of your system.

_And that’s why good APIs are important._
