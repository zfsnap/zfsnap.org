#!/bin/sh
# use travis-encrypted GitHub token and git user for updating output/
# whenever the master branch is updated.

# It assumes that `make all` was performed beforehand and thus output/ is
# up-to-date.

git --version

# set up git and GitHub access
git config user.name 'AutoBuild'
git config user.email 'blackhole@zfsnap.org'
git config credential.helper 'store --file=.git/credentials'
printf 'https://%s:x-oauth-basic@github.com\n' "$GH_TOKEN" > .git/credentials

# switch to branch gh-pages and get the fresh build
git remote set-branches --add origin gh-pages
git fetch origin
git branch -a
git checkout origin/gh-pages
rsync -r output/ .

# commit new docs folder and push
git add .
git commit -m "Automatically updated GitHub pages"
git push origin HEAD:gh-pages

rm .git/credentials
