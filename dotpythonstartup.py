# -*- encoding: utf-8 -*-
# Python startup
import readline
import rlcompleter
import atexit
import os
# Tab補完
readline.parse_and_bind('tab: complete')
# ヒストリーファイル
histfile = os.path.join(os.environ['HOME'], '.pythonhistory')
try:
    readline.read_history_file(histfile)
except IOError:
    pass
atexit.register(readline.write_history_file, histfile)
del os, histfile, readline, rlcompleter, atexit
    
