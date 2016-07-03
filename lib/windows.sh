  for winname in $winnames; do
      pane=0
      windowid=$((window+1))
      layout=`xmlstarlet sel -t -v "/session/window[${windowid}]/@layout" ${config} | grep -v "%"`
      panenames=`xmlstarlet sel -t -v "/session/window[${windowid}]/pane" ${config} | grep -v "%"`
  
      if [ $window == 0 ]; then
          tmux -2 rename-window  -t ${session}:${window} ${winname}
      else
          tmux -2 new-window     -t ${session}:${window} -n ${winname}
      fi
  
      . $BASE/lib/panes.sh
  
      tmux -2 select-layout ${layout}
  
      window=$((window+1))
  done
  wait
