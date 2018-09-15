---
title: "Auto-deploy blog to GitHub Pages with static site generator and CI"
date: 2018-02-01T19:24:46-06:00
---

A couple weeks ago, I migrated my blog from Tumblr to a static site generator. (I ended up settling on [Hugo](https://gohugo.io/), but my choice of tool is irrelevant for this post.) When it came to deployment, I decided to have the generated HTML live on GitHub Pages since it's free, easy to set up, and my source code (content, theme, and configuration) were going to live there anyway.

The easiest way to accomplish this with minimal setup is just to have your site generator output your built site in a folder called `/docs`. Rebuild your site after any change you make, push to `master`, and you're good to go.

This solution was fine at first, but it got a little annoying having to manually re-build my site and commit the output of that build on every change. Not to mention the fact that committing build artifacts to version control broke my heart a little. I wanted a way to keep _only_ my source chances in my git history (with the build folder in `.gitignore`), and have the build and deployment process happen automatically when I pushed my source code to GitHub.

Here's the process I settled on: **CircleCI kicks off a new build when I push to `master`. This runs a simple bash script that builds my site, commits the result to the `gh-pages` branch, and pushes that branch back to GitHub.** Now I can just push my source changes to `master`, and the rest happens automatically within seconds. As a plus, this script re-writes the history of `gh-pages` to a single commit on each deploy so that branch doesn't get littered with "auto-deploy" commits.

**If you just want to see the code that makes this run, take a look at [the repository for this blog](https://github.com/seangransee/blog) and take note of the `deploy.sh` file.** I should note that this was heavily inspired by the [script](https://github.com/graphql/graphql.github.io/blob/source/resources/publish.sh) that deploys changes to [GraphQL.org](http://graphql.org/). Here's a rundown of how you can set up a similar solution:

_Note: I used Hugo and CircleCI, but this should work with any static site generator (Jenkins, etc) and CI system (Travis, etc)._

### Add your build folder to .gitignore

When I build my site with Hugo, it dumps my built site in a `/public` folder. The name of this folder will vary depending on which static site generator you're using, and should be configurable. Whatever this folder happens to be, add this to your `.gitignore` so you don't end up committing build artifacts to your repository.

### Create a deploy script

The deploy script will need to do the following things:

1. Build your static site
2. Create a CNAME file that will go in your `gh-pages` branch. (You can skip this if you aren't using a custom domain.)
3. Push your build folder (along with the CNAME file) to the root directory of the `gh-pages` branch of your repository on GitHub.

To clarify, your `master` branch will _only_ contain the source files needed to build your site, and your auto-deployed `gh-pages` branch will _only_ contain the generated output. This provides a nice separation of source files and build artifacts.

Here's what my script looks like:

```bash
hugo -v # command to build your site
cd public # cd into folder containing your built site

git init
git config user.name "Sean Gransee"
git config user.email "sean.gransee@gmail.com"

echo "blog.seangransee.com" > CNAME # domain your site will live at
git add .
git commit -m "Deploy from CircleCI" # this will always be the only commit in your gh-pages branch

# use --quiet to avoid printing token in build logs
git push --force --quiet "https://${GH_TOKEN}@github.com/seangransee/blog.git" master:gh-pages # path to your repo on GitHub, using token for authentication
```

You'll notice that I'm using an environment variable to store my GitHub token to avoid having it publicly available in my repository.

### Set up CI

I used CircleCI because it's what I'm most familiar with, but I've also had good luck with Travis in the past. They're both free for open-source repositories, which makes either service perfect for auto-deploying a blog or static site.

Configure CI to run your deploy script when you push to `master`. I won't go through the details of setting that up, but here's my configuration file using CircleCI and Hugo:

```yaml
version: 2
jobs:
  build:
    docker:
      - image: publysher/hugo
    steps:
      - checkout
      - run: ./deploy.sh
    branches:
      only:
        - master
```

### Set up a GitHub access token

You'll need to generate a token that will allow your script to push to your branch on GitHub. Go to https://github.com/settings/tokens/ to generate a token, or read [GitHub's instructions](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) if you need more help. You'll need to give your token **repo** access. Save this token as an environment variable called `GH_TOKEN` on CI.

### Enable `gh-pages`

[GitHub has instructions for configuring your repository to use `gh-pages`.](https://help.github.com/articles/configuring-a-publishing-source-for-github-pages/#enabling-github-pages-to-publish-your-site-from-master-or-gh-pages) If you're using a custom domain, you'll also need to [set that up](https://help.github.com/articles/quick-start-setting-up-a-custom-domain/). If you enable a custom domain through the GitHub web interface, it'll automatically create a CNAME file for you. However, this file will get wiped out by the deploy script above unless the script takes care of re-generating the CNAME file on each deploy. I had forgotten to have my script do this at first, and was banging my head against the wall trying to figure out why my custom domain had stopped working each time I deployed.

### That's it!

Your static site should be automatically built and deployed within seconds of every push to `master`. No more mixing source files and build artifacts! Have a muffin to celebrate.

Again, feel free to look at [this blog's repository](https://github.com/seangransee/blog) if you want to see it all working together, and don't hesitate to leave a comment or [contact me](mailto:sean.gransee@gmail.com) if you need help.
