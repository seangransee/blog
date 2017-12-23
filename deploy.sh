#! /bin/bash
set -e # stop at first failing command

hugo -v
cd public

git init
git config user.name "Sean Gransee"
git config user.email "sean.gransee@gmail.com"

echo "blog.seangransee.com" > CNAME
git add .
git commit -m "Deploy from CircleCI"

# use --quiet to avoid printing token in build logs
git push --force --quiet "https://${GH_TOKEN}@github.com/seangransee/blog.git" master:gh-pages