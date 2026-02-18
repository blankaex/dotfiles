#
# Executes commands at logout.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

function typewriter {
    text="$1"
    delay="$2"

    for i in $(seq 0 $(expr length "${text}")) ; do
        echo -n "${text:$i:1}"
        sleep ${delay}
    done
}

# Execute code only if STDERR is bound to a TTY.
[[ -o INTERACTIVE && -t 2 ]] && {

clear
typewriter "Peaceful days are over" 0.1
sleep 1
echo
typewriter "Let's survive" 0.1
typewriter "..." 0.5
sleep 1
echo

} >&2
