---
title: "Opinions On Opinionated Autoformatters"
date: 2018-09-28T19:11:58-05:00
---

About three years ago, I was involved in the most heated argument I've experienced thus far in my career. I wish I could say it was about something important with long-term consequences, like a decision about which data store or framework to use. Nope. It was about code formatting. Specifically, the argument was about tabs vs spaces in a spectacle that was a little too similar to a [scene from Silicon Valley](https://www.youtube.com/watch?v=SsoOG6ZeyUI).

Everyone I've worked with agrees that code should follow a consistent style. It's easy to set up a linter that will fail your CI build when these styles aren't being followed. But standard linters fail to accomplish two things that I've always viewed as necessary evils when programming with a team: deciding on styles, and following them.

My world was rocked when my team started using [Prettier](https://prettier.io/). Prettier is an **opinionated code formatter**. It automatically formats your code based on styles that the creators of the tool have decided upon.

## Deciding on formatting rules

ESLint has 92 configurable rules for [stylistic issues](https://eslint.org/docs/rules/#stylistic-issues), each with a number of options you can choose from. The number of permutations this provides is an immensely huge number that I don't feel like calculating.

Prettier, on the other hand, tries to ["stop all the on-going debates over styles"](https://prettier.io/docs/en/option-philosophy.html) by making most of these decisions for you. There are still some [configurable options](https://prettier.io/docs/en/options.html), but they're pretty much limited to big decisions that people tend to really care about. It won't stop the tabs vs spaces debate, but it will eliminate a number of petty arguments.

I used to care about which formatting rules my team followed. I've since stopped giving a shit. As long as the whole team is following a consistent style, who the hell cares what that style is? I'd rather spend less time deciding on configuration and more time writing actual code.

## Making code follow the rules

I don't want to know how much time I've spent over the years making my code follow a set of formatting rules. Formatting a block of code is usually quick, but those seconds really add up over time and add a small bit of cognitive load while programming. Some linters have a command that will automatically fix your code, but you still have to remember to run it (or do something like set up a Git hook). I can't tell you how many commits at my last job just read "fucking pylint" and consisted entirely of spacing and indentation changes.

An autoformatter, on the other hand, will integrate with your editor and **format your code when you save it**. Being able to stop thinking about how code is formatted is a breath of fresh air. The feeling of pasting code and watching it instantly get styled is rivaled only by taking that first bite of a burrito with extra guac.

Another underrated benefit of using an autoformatter is that you can tell immediately upon saving whether your code will compile. This is especially nifty when working with JSX. If I've hit CMD+S and don't see anything get reformatted, I know I've probably left off a curly brace somewhere. This is a much more obvious visual than a red squiggly line that may or may not be anywhere near my cursor.

## Other tools

I've mostly been talking about Prettier because it's the first opinionated autoformatter I've used and it supports [a number of languages](https://prettier.io/docs/en/language-support.html). I've tried to embrace similar tools no matter what language I'm using. When I write Python, you bet I'm using [autopep8](https://pypi.org/project/autopep8/)! One of the things I love about Go is that [gofmt](https://golang.org/cmd/gofmt/) is included with the language instead of being a third-party project. Back in 2013, [70% of Go packages were formatted using gofmt's rules](https://blog.golang.org/go-fmt-your-code), and it's probably a higher percentage today. This provides the added advantage of making code more approachable across the Go ecosystem.

Code formatting is something I used to view as a necessary evil, but now it's something I rarely think about. I wonder what other tasks we spend our time on every day that will fade into the background in a few years.

_Note: This post applies only to **stylistic** issues that don't affect the abstract syntax tree. Most linters have rules that deal with AST changes (for example, scoping issues or unused variables), and I think it's great to keep a linter around to catch these types of things that can't automatically be fixed._
