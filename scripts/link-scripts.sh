#!/usr/bin/bash
for f in $HOME/.local/src/scripts/*; do
    file=${f##*/}
    ln -s $f $HOME/.local/bin/${file%%.sh}
done
