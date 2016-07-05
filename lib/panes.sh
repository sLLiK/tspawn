  for panename in ${panenames}; do
     if [ $pane != 0 ]; then
         tmux -2 split-window   -h -l 15
     fi 
   
     paneid=$((pane+1))
     panename=`xmlstarlet sel -t -v "/session/window[${windowid}]/pane[${paneid}]/@name" ${config} | grep -v "%"`
     commands=`xmlstarlet sel -t -v "/session/window[${windowid}]/pane[${paneid}]/command" ${config} | grep -v "%"`
   
     tmux -2 send-keys -t ${session}:${window}.${pane}  "printf '\033]2;%s\033\\' '${panename}'" C-m C-l

     commandid=1
     for command in ${commands}; do
         clearyn=`xmlstarlet sel -t -v "/session/window[${windowid}]/pane[${paneid}]/command[${commandid}]/@clear" ${config} | grep -v "%"`

         if [ "$clearyn" == "yes" ]; then
             tmux -2 send-keys -t ${session}:${window}.${pane} ${command} C-m C-l
         else
             tmux -2 send-keys -t ${session}:${window}.${pane} ${command} C-m
         fi
         commandid=$((commandid+1))
     done
     wait
   
     pane=$((pane+1))
  done
  wait
