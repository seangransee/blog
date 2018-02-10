---
title: "What is the halting problem?"
date: 2012-10-16T14:31:09-06:00
---

_This post is from an old blog I had called Software Cake, where I explained technical terms by talking about cake._

***

Consider the following situation:

> There is a delicious cake. Chuck Norris* must jump up and down until the cake is not delicious anymore.

Will Chuck Norris ever stop jumping? Let’s look at a few scenarios:

1. The cake is outdoors. It gets rained on and becomes soggy, therefore it is not delicious anymore. Chuck Norris stops jumping.
2. Chuck Norris realizes how stupid this situation is and stops jumping of his own accord because Chuck Norris does what he wants.
3. The cake stays delicious forever. Chuck Norris is compliant and continues to jump for all eternity.

We only looked at three scenarios, but there are an infinite amount of things that can happen. As you can see, whether or not Chuck Norris stops jumping relies on a number of different factors. The only way for him to keep jumping forever is if he remains compliant and the cake never stops being delicious. Even though this seems to be a simple situation, it’s actually very complex because there are millions of factors in the world that could make the cake not be delicious anymore. Or Chuck Norris could decide not to comply, causing an _error_.

So let’s revisit the question: _Will Chuck Norris ever stop jumping?_ The only way to find out is to watch and see for yourself. There’s no way to tell ahead of time whether he’ll ever stop. If you watch him for 51 hours and he continues to jump, can you tell if he will ever stop in the future? No, you can’t.

Translate this situation into a computer program, and our question is a variation of the [halting problem](https://en.wikipedia.org/wiki/Halting_problem): _Given a description of an arbitrary computer program, decide whether the program finishes running or continues to run forever._

This problem is significant because it cannot be solved. There are many programs where, when given a description of the program, there is no way to determine whether it will ever stop or whether it will run forever. The Chuck Norris/cake example is one such program. Given that situation, you can’t always tell ahead of time whether his jumping will ever cease.

_* Chuck Norris was used in this example because he does not need to eat or sleep, and he has enough willpower to not immediately eat the cake._
