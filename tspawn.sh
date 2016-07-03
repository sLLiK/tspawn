#!/bin/bash
: '
  See ~/.config/tspawn/doc/README for details
'

### Config

  session=$1
  BASE=~/.config/tspawn
  config="${BASE}/cfg/${session}.xml"
  OLDIFS=$IFS
  IFS=$'\n'

  if `xmllint --noout --dtdvalid ${BASE}/cfg/tspawn.dtd ${config}`; then  

      detach=`xmlstarlet sel -t -v "/session/@detach" ${config} | grep -v "%"`
      winnames=`xmlstarlet sel -t -v "/session/window/@name" ${config} | grep -v "%"`
      window=0
    
      if `tmux has-session -t ${session} 2> /dev/null`; then
          if [ $detach == "yes" ]; then
              tmux -2 attach -d -t ${session}
          else
              tmux -2 attach -t ${session}
          fi
      else
    
          tmux -2 new-session -d -s ${session}

    ### Spawn loop
    
          . $BASE/lib/windows.sh
    
    ### Final prep
    
          tmux -2 select-window  -n
          tmux -2 attach-session -t ${session}
          IFS=$OLDIFS
      fi
  else
      IFS=$OLDIFS
      exit
  fi
