                                            /home/lev/.gitconfig                                                
[user]
        email = name.surname@mail.com
        name = Name Surname
[alias]
        aa = add -A # add all changes to stage, including untracked
        cm = commit -m # commit all staged changes

# remove all uncommitted changes forever, don't do this!        
        fu = reset --hard 

# one update my clone to the cloned repo e.g. syncing fork with upstream
        pu=!git fetch origin && git fetch upstream && git merge upstream/main 

# active branch and file status in it
        st = status -sb 

# full info from last commit
        last = log -1 HEAD --stat 

        se = !git rev-list --all | xargs git grep -F # identify all commits with word in argument

        gl = config --global -l  # list all aliases to the console
        ec = config --global -e  # edit aliases in default editor

# update main branch via rebase with team work 
        rb = !git checkout main && git pull && git checkout - && git rebase main 

# shortcut for checkout command        
        co = checkout 

# create new branch and checkout to it
        cb = checkout -b 

# git add --all files && commit them in one command        
        ac = !git add -A && git commit -m 

# save all changes in current branch with commit name 'SAVEPOINT'
	save = !git add -A && git commit -m 'SAVEPOINT'

# Use this instead of `git reset HEAD --hard`!!! Run `git reflog` to view savepoints.
	wipe = !git add -A && git commit -qm 'WIPE SAVEPOINT' && git reset HEAD~1 --hard
        
# Resets the previous commit, but keeps all the changes from that commit in the working directory
	undo = reset HEAD~1 --mixed
# update last commit with small fix
        amend = commit -a --amend 

        b = branch  # list all local branches
        br = branch -r # list all remote branches
        ba = branch -a # list all local and remote branches

# list of remotes ( origin e.t.c. )
        rv = remote -v 

# get list of changed files from last commit
        lsch = ls-files -dmo --exclude-standard 

# push new local branch to origin
        po = !git push -u origin $(git describe --contains --all HEAD)

# add all files && commit them && push to origin. All in one command 
        cmp = "!f() { git add -A && git commit -m \"$@\" && git push; }; f" 
        
# remove lokal and remote feature branches
        nuke = !sh -c 'git branch -D $1 && git push origin :$1' -

# drop all unsaved changes from last time
        drop = !git stash save --keep-index --include-untracked && git stash drop 

# Just like 'git show' except shows more lines for context
	sh = show -U40

        lgd = log --oneline --graph --color --decorate # pretty color log with graph
        lgf = log --graph --oneline --decorate --all --name-status # the same log as up above plus with all changed files
        
# Concise tree view of all commits in the ancestry of the current commit
	lg = log --graph --date-order --format=format:'%C(blue)%an%C(reset)%C(cyan)%d %C(reset)%C(white)%s%C(reset) %C(green)(%ar)%C(reset) %C(yellow)%h%C(reset)'

# Concise tree view of all commits in ALL branches
	lga = !git lg --all

# Detailed tree view of all commits in the ancestry of the current commit
	lgg = log --graph --date-order --format=format:'%C(blue)%an%C(reset)%C(cyan)%d %C(reset) %C(green)(%ar)%C(reset) %C(yellow)%h%C(reset)%n%n%B' --name-status

# Detailed tree view of all commits in ALL branches
	lgga = !git lgg --all

# What have I done in the last 12 hours?
	time = log --graph --date-order --all --no-merges --author=bkoren --since='12 hours' --format=format:'%s'
        
# This alias is meant to be run from your default branch and does the cleanup of merged branches.
    	bcleanz = "!f() { git branch --merged ${1-main} | grep -v " ${1-main}$" | xargs -r git branch -d; }; f"
# This will actually fail if there are no branches to clean, a small additional tweak:        
        bcleany = "!f() { branches=$(git branch --merged ${1-main} | grep -v " ${1-main}$"); [ -z \"$branches\" ] || git branch -d $branches; }; f"
# Second version of bclean            
        bcleanx = "!f() { git checkout ${1-main} && git branch --merged ${1-main} | grep -v " ${1-main}$" | xargs -I{} git branch -d {}; }; f"
        
#        Now we can use this in the following aliases. My bdone alias does the following.
#    1. Switches to the default branch (though you can specify a different branch)
#    2. Runs git up to bring the branch up to speed with the origin
#    3. Deletes all branches already merged into the specified branch using another alias, git bclean
        bclean = "!f() { DEFAULT=$(git default); git branch --merged ${1-$DEFAULT} | grep -v " ${1-$DEFAULT}$" | xargs git branch -d; }; f"
        bdone = "!f() { DEFAULT=$(git default); git checkout ${1-$DEFAULT} && git up && git bclean ${1-$DEFAULT}; }; f"

# Pulls changes from the remote. If there are any local commits, it'll rebase them to come after the commits pulled down. The --prune option removes remote-tracking branches that no longer exist on the remote.
# Ideal operation for the start of the day, when you stay on main/develop branch
	up = !git pull --rebase --prune $@ && git submodule update --init --recursive

# it's how to retrieve default branch        
        default = !git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'

# most of info from there: https://haacked.com/archive/2014/07/28/github-flow-aliases/
