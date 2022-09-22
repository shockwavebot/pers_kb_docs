
# get commit hash 
git rev-parse HEAD 

# show file at certain commit 
git show ${COMMIT_HASH}:path/to/file

# find/search for commit with message 
git log --grep="search_string"
git log --grep="search_string" --pretty=format:"%H" # display only full commit hash 

# find changed files in last number of days 
git log --since="7 day ago" --name-only --pretty=format: |grep "path"|sort|uniq

# list all commits that change one file 
git log --follow -- file/path/file.name

# list only changed files in a commit 
git show --pretty="" --name-only c3b2d788

# installing git pkg
zypper in -y git-core

# setting up local user account and git:
git config --global user.name stanojlovic.marko@gmail.com
git config --global user.email stanojlovic.marko@gmail.com
git config --global credential.helper cache
git config --global credential.helper store
git config --global color.ui auto
git config --list
echo "alias gs='git status'" >> ~/.bashrc

# working with releases/tags 
git tag -l  # 2019.123.123
git checkout tags/2019.123.123
# delete remote tag 
git push --delete origin tagname
# delete local tag 
git tag -d tagname


# error: SSL certificate problem: unable to get local issuer certificate
git config --system http.sslCAPath /absolute/path/to/git/certificates
git config --global http.sslVerify false # WORKING

# directory to ignore from commits
.git/info/exclude
# to exclude dir and subir in thre tree structure
**/dir_name/*

# update credentials
git credential reject
git credential fill

# ==================
# create github repo from local dir
# 1. create repo @github
# 2. git init @local dir (optional: edit exclude list @.git/info/exclude)
# 3. git add .
# 4. git remote add origin https://github.com/markostanojlovic/ceph_suse_bld_vld.git
# 5. git push origin master
# ==================

# remving a file: remove it from working directory rm file_name; then git rm
git rm file_name
# to bring back removed file
git reset HEAD file_name
git checkout -- file_name

# keep the file locally, but do not track it, and it's not in gitignore list
git rm --cached file_name

# to revert to a specific commit:
git log
git reset --hard commit_hash

# skipping stagin area - only for already tracked files
git commit -a -m 'message'

# renaming a file
git mv _oldname_ _newname_

# commit history
git log -p -2 # last 2 commits and see the changes
git log --stat
git log --pretty=oneline
git log --pretty=format:"%h - %an, %ar : %s"
git log --since=2.weeks
git log -S change_string # only shows commits which have change_string as a change that is commited

# UNDO

# undo last commit
git reset HEAD~

# correct undo last commit, rename commit, edit commit 
# rename a commit
git commit --amend
# to unstage a file
git reset HEAD file_name
# Unmodifying a Modified File
git checkout -- file_name
git checkout -- . # for all files, reset all files, bring back deleted files 

# REMOTES
git clone https://github.com/schacon/ticgit
git remote -v
git remote add name https://github.com/name
git fetch name
git push origin master
git remote show origin
git remote rename pb paul
git remote rm paul

# TAGing
git tag
git tag -l 'v1.8.5*'
git tag -a v1.4 -m 'my version 1.4'
git show v1.4

# BRANCHING
# create a new branch
git branch testing
# switch to branch
git checkout testing
# to list all branches
git branch -a

# delete a branch (can't be checked in into the branch that you delete)
git branch -d the_local_branch 			# local
git push origin :the_remote_branch 		# remote

# MERGING
git checkout master
git merge iss53
# git mergetool - not really working

# last commit on each branch
git branch -v

# to check which branches are merged into current branch
git branch --merged

# merge remote branch to local one: (after git fetch origin)
git merge origin/serverfix
# base local branch off remote branch: git checkout -b [branch] [remotename]/[branch]
git checkout -b serverfix origin/serverfix
git checkout -b ds_deploy_custom_ceph_conf SUSE/wip-qa-stage3

# to check tracking (upstream) branches
git branch -vv

# REBASE - same effect as MERGE, but cleaner history
git checkout experiment
git rebase master

# checkout client branch, figure out the patches from the common ancestor of the client
# and server branches, and then replay them onto master
git rebase --onto master server client
# fast forward the master branch
git checkout master
git merge client

# rebase the topic branch onto the master
git rebase master topic

#############################################################################
# RULE TO FOLLOW: Do not rebase commits that exist outside your repository. #
#############################################################################

# 1. @github: fork the master branch to your profile
# 2. git clone https://github.com/markostanojlovic/DeepSea ~/DeepSea
# 3. modifications
# 4. commit to the master
git status
git add -A
git commit -m "NFS ganesha HA test - DS suite v1 16.8.2017."
git pull origin master
git push origin master

git branch -m qa_nfs_ganesha_ha
git push -u origin qa_nfs_ganesha_ha
git remote -v
git remote add suse https://github.com/SUSE/DeepSea
# git remote add smithfarm https://github.com/smithfarm/DeepSea.git # another example
git fetch suse
git rebase suse/master

# 5. pull request to the upstream

# delete a commit

# create a new branch
git checkout -b amend-my-name
# rename a branch
git branch -m _oldname_ _newname_

# useful commands:
git log
git show
git cherry-pick b2e876fec8330e7d271c43833f655b8f28abac66

# how to merge branch with master
git checkout master
git pull origin master
git merge branch_to_merge
git push origin master

git diff HEAD

# see differences between 2 branches
git fetch
git branch -a
git diff aarch64_thunderx9 remotes/origin/thunderx9
git log remotes/origin/thunderx9
git cherry-pick f6c56268bfbcddf158e4fa7943a753604e413e09

# compare differences before commit
git diff myfile.txt


# to clean up my fork and sync with upstream
git fetch upstream
git checkout master
git reset --hard upstream/master
# sync/reset my local branch with remote - force pull remote 
git checkout <branch_name>
git fetch --all 
git reset --hard origin/<branch_name>

#########################################
# fetch the remote upstream
git remote -v
# mstan	https://github.com/markostanojlovic/DeepSea (fetch)
# mstan	https://github.com/markostanojlovic/DeepSea (push)
# origin	https://github.com/markostanojlovic/DeepSea (fetch)
# origin	https://github.com/markostanojlovic/DeepSea (push)
# smithfarm	https://github.com/smithfarm/DeepSea.git (fetch)
# smithfarm	https://github.com/smithfarm/DeepSea.git (push)
# suse	https://github.com/SUSE/DeepSea (fetch)
# suse	https://github.com/SUSE/DeepSea (push)

git checkout master # *** THIS IS IMPORTANT! TO BRANCH FROM MASTER! ***

git fetch suse
git rebase suse/master

# set traching of the branch
git push -u origin qa-nfs_ha
git status

# squash all commits, in my case 3
git log --oneline --decorate
git rebase -i HEAD~3
git log --oneline --decorate
git show

# edit commit comment
git commit --amend -s

# push the commit to remote
git push --force origin qa-nfs_ha

# changing commit comment after commit
git commit --amend
git push -f

ab1442ff (HEAD -> qa-rgw_2_zones) qa test: rgw with 2 zones config
8e68e410 Signed-off-by: Marko Stanojlovic <mstanojlovic@suse.com>
eb253b92 Merge pull request #980 from smithfarm/wip-refresh-loop
2197dc26 (origin/qa-rgw_2_zones) Signed-off-by: Marko Stanojlovic <mstanojlovic@suse.com>
f44d1790 qa rgw 2 zones test - initial commit

# remote branch got detached
git reset --hard suse/ses6

# to set branch to track remote upstream branch
git branch -u upstream/foo
git branch --set-upstream-to=upstream/foo foo # if foo is not current branch

# git clone only one branches
git clone -b wip-qa-repl_to_ec_2 --single-branch https://github.com/markostanojlovic/ceph.git


# save current work for later, revert to some commit from the past and apply new work
git stash
git reset --hard 30fa8247b3914a6920bc4dbe7383de5de7527d20
git stash pop

# cleaning mess
git gc --prune=now
git update-ref -d refs/heads/origin/branch

# git pull scenario where remote branch has diverged - new commits pushed and some of it squashed 
# pull w/o creating new commits 
#
# A---B---C---D local
#     |
#     +---C (squashed and hash changed) master
# 
git pull --ff-only     # >>> fatal: Not possible to fast-forward, aborting. <<< 
# other options are merge (--no-rebase) or rebase (--rebse) and both those option will create new commits 
# the best way is to reset 
git reset --hard origin/branch-name 


