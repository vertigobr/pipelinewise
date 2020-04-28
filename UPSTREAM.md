# Updating from upstream 

```sh
# Add the remote, call it "upstream":
git remote add upstream git@github.com:transferwise/pipelinewise.git
# Fetch all the branches of that remote into remote-tracking branches,
# such as upstream/master:
git fetch upstream
# Make sure that you're on your master branch:
git checkout master
# merge changes
git merge upstream/master
```