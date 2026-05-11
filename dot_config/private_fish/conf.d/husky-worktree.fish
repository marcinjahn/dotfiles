function __husky_worktree_toggle --on-variable PWD
    if string match -q "$HOME/code/worktrees/*" -- $PWD
        set -gx HUSKY 0
    else
        set -e HUSKY
    end
end

__husky_worktree_toggle
