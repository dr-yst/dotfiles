# !/bin/bash
# last updated:<2013/08/05 11:52:26 from yoshitos-mac-mini.local by yoshito>
/usr/bin/find /Users/yoshito/Downloads -mtime +14 -print0 | xargs -0 -I{} /bin/mv -f {} /Users/yoshito/.Trash/
