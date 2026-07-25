#### pnpm / bun / Node Development
alias pd='pnpm run dev'                                                # Dev server
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
