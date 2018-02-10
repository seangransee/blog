---
title: "What is Git? What is revision/version control? "
date: 2012-08-09T22:23:13-06:00
---

_This post is from an old blog I had called Software Cake, where I explained technical terms by talking about cake._

***

You and your team of oompa loompas are on a mission to create the greatest cake the world has ever tasted. You all have your own specialty. Stroompa is an expert at creating sweet, delicious strawberry toppings. Boompa ain’t messing around when it comes to cake batter. And choompa? Well, let’s just say that chocolate is kinda his thing.

Everyone starts off getting their own boring cake, and they all go off separately to work on their respective parts. They all create something that tastes amazing all by itself. Then, they come together to combine their parts into one cohesive cake. You taste it, and you’re underwhelmed. Turns out, everyone made amazing ingredients, but they didn’t blend well together. The chocolate and the strawberries didn’t balance each other out. The inside wasn’t moist enough to work well with the rest of the cake. Wouldn’t it have been better if everyone worked on the same cake, iterating with each other until they had something that even Chuck Norris couldn’t resist?

**Now let’s look at another scenario…**

Same deal as before. Your team of oompa loompas is creating the world’s greatest cake. This time you start with a magical box that contains a basic cake. When you take the cake out of the box, the cake actually duplicates (just go with it…) and you’re really taking out an exact copy of the cake. When you put a cake into the box, the cake that was already in there combines with the changes you’ve made to the cake.

Everyone works on their respective part of the cake again. But this time, whenever anyone feels satisfied with his progress, he puts his cake in the magical box and takes out a new one. This time around, everyone always has a cake that includes the best of everyone’s work, so they can work together to make the ingredients combine into cakey goodness.

**Let’s put this into technical terms…**

Your individual copy of the cake is your _local repository_. The magical box is called the remote repository. When you put the cake into the box, you push it to the box. When you remove the cake that has everyone’s combined changes, you pull it.

When you’re working with other developers on a software project using Git, you always have a copy of the code on your own computer. When you’ve made changes that you feel satisfied with, you _commit_ them, which is basically saying that you want those changes to go into your local repository. When you want the others to be able to use your code, you push your local repository to the remote repository, which the other developers can then pull from. Now, everyone always has an up-to-date copy of everyone else’s code, so it’s much easier to make all the moving parts work together into one cohesive whole.

Who can give me access to that remote cake repository?
