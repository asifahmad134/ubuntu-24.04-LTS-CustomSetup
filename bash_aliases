#### pnpm / bun / Node Development
alias pd='pnpm run dev'
alias bd='bun dev'

#### Git Aliases

#### Pretty log views
# Show a compact visual commit graph for all branches
alias gl='git log --oneline --graph --decorate=full --all'
# Show a detailed commit graph with hash, refs, message, relative date, and author
alias gla='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
# Show a very compact graph of all branches with branch/tag names
alias glg='git log --graph --oneline --decorate --all'

#### Status & changes
alias gss='git status -s'                                               # Show a short summary of modified, staged, and untracked files
alias gd='git diff'                                                     # Show changes that have NOT been staged yet
alias gdc='git diff --cached'                                           # Show changes that ARE already staged for commit
alias gdw='git diff --word-diff --color-words'                          # Show changes word-by-word with colors; useful for prose/text files

# Branch & remote
alias gb='git branch -vv'                                               # List local branches and show their upstream/tracking branches
alias gba='git branch -a -vv'                                           # List all local + remote branches with upstream information
alias gr='git remote -v'                                                # Show configured Git remotes and their fetch/push URLs

# Commit & staging
alias gc='git commit -v'                                                # Create a commit; show the staged diff inside the commit editor
alias gca='git commit -v -a'                                            # Commit tracked modified files without manually staging them first
alias gamend='git commit --amend --no-edit'                             # Add changes to the previous commit without changing its message
alias gundo='git reset --soft HEAD~1'                                   # Undo the last commit while keeping all changes staged
alias gcf='git commit -m "fixes"'                                       # Create a commit immediately using the message "fixes"

# Stash
alias gst='git stash push -m'                                           # Temporarily stash changes with a message: gst "wip"
alias gsta='git stash apply'                                            # Restore the most recent stash while keeping it in the stash list
alias gstl='git stash list'                                             # List all saved stashes
alias gstd='git stash drop'                                             # Delete the most recent stash

# Fetch / Pull / Push
alias gf='git fetch --prune'                                            # Download remote updates and remove stale remote-tracking branches
alias gp='git pull --ff-only'                                           # Pull remote changes only when Git can fast-forward safely
alias gpush='git push'                                                  # Push local commits to the configured remote branch
alias gpushf='git push --force-with-lease'                              # Force-push more safely by refusing if the remote changed unexpectedly
