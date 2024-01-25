 curl -s "wttr.in/?format=%t%c\n" | sed 's/+//g' | sed 's/C/C /g' | sed 's/ //g' 
