if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -g EDITOR nvim
set -g VISUAL nvim
set -g LANG en_US.UTF-8 
function freehome --description "Show free space for / and ~"
    # Get filesystem device names
    set root_dev (df / | awk 'NR==2 {print $1}')
    set home_dev (df ~ | awk 'NR==2 {print $1}')

    # Get free space and percentage for /
    set root_free     (df -h / | awk 'NR==2 {print $4}')
    set root_used_pct (df -h / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')
    set root_free_pct (math 100 - $root_used_pct)

    # Get the same info for ~
    set home_free     (df -h ~ | awk 'NR==2 {print $4}')
    set home_used_pct (df -h ~ | awk 'NR==2 {gsub(/%/, "", $5); print $5}')
    set home_free_pct (math 100 - $home_used_pct)
    set home_mount    (df ~ | awk 'NR==2 {print $6}')

    if test "$root_dev" = "$home_dev"
        echo "$root_free free - $root_free_pct% available"
    else
        echo "/ : $root_free free — $root_free_pct% available"
        echo "~ : $home_free free — $home_free_pct% available"
    end
end
function fish_greeting
    w
    freehome
end
