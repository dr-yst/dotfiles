# !/bin/bash

function cc(){
    echo $#
    arg=("$@")
    command="g++ -g -Wall ${arg[0]} -o ${arg[1]} -lmylib "

    for i in `seq 2 $#`
    do
        command="${command} ${arg[$i]}"
    done

    echo $command
    `$command`
}


