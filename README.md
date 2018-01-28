Site generator for [http://blog.seangransee.com](http://blog.seangransee.com), powered by [Hugo](https://gohugo.io/).

## Run locally

```bash
hugo server # hide drafts, just like in production
hugo server --buildDrafts # show drafts
```

Open http://localhost:1313/ in your browser.

## Start new post

```bash
hugo new posts/post-name.md
```

## Deploy

Push to `master`. CircleCI will automatically commit the built site to `gh-pages`.
