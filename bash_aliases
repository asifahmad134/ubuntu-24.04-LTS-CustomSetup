#### Enhanced Directory Listing with lsd


# Tree views with increasing depth and common ignores
alias l1='lsd --tree --depth 1'
alias l2='lsd --tree --depth 2'
alias l3='lsd --tree --depth 3 --git -I node_modules -I public'
alias l4='lsd --tree --depth 4 --git -I node_modules -I public -I ui'
alias l5='lsd --tree --depth 5 --git -I node_modules -I public -I ui -I dist -I build'

# Full tree (use sparingly!)
alias treeall='lsd --tree --git -I node_modules -I public -I ui -I dist -I build'

# Quick listings
alias lf='lsd -AF'                                                          # Classified (trailing /, *, etc.)
alias la='lsd -A'                                                           # Almost all (no . and ..)
alias ll='lsd -l'                                                           # Long format

# Detailed listings with size and sorting
alias lls='lsd -lF --total-size --group-directories-first'                  # Size summary
alias lg='lsd -lFS --total-size --git --group-directories-first'            # Sorted by size + git info

# Bonus: Human-readable sizes + icons
alias lsh='lsd -lhF --total-size --group-directories-first'


#### pnpm / bun / Node Development


alias pd='pnpm run dev'                                                     # Dev server
alias bd='bun dev'                                                     # Dev server

#### Git Aliases


# Pretty log views
alias gl='git log --oneline --graph --decorate=full --all'                  # Compact graph with all branches
alias gla='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias glg='git log --graph --oneline --decorate --all'                      # Even more compact graph

# Status & changes
alias gss='git status -s'                                                   # Short status
alias gd='git diff'                                                         # Diff working tree
alias gdc='git diff --cached'                                               # Diff staged
alias gdw='git diff --word-diff --color-words'                              # Word-level diff (great for prose)

# Branch & remote
alias gb='git branch -vv'                                                   # List branches with upstream info
alias gba='git branch -a -vv'                                               # All branches (local + remote)
alias gr='git remote -v'                                                    # Show remotes

# Commit & staging
alias gc='git commit -v'                                                    # Commit with verbose diff in editor
alias gca='git commit -v -a'                                                # Commit all changes
alias gamend='git commit --amend --no-edit'                                 # Quick amend last commit
alias gundo='git reset --soft HEAD~1'                                       # Undo last commit, keep changes staged
alias gcf='git commit -m "fixes"'

# Stash
alias gst='git stash push -m'                                               # Stash with message: gst "wip"
alias gsta='git stash apply'
alias gstl='git stash list'
alias gstd='git stash drop'

# Fetch/Pull/Push
alias gf='git fetch --prune'                                                # Fetch and remove gone branches
alias gp='git pull --ff-only'                                               # Safe pull
alias gpush='git push'
alias gpushf='git push --force-with-lease'                                  # Safer force push
