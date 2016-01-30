# !/bin/bash
# last updated:<2016/01/30 11:50:44 from SURFACE-3 by stick>

echo 'cp dotzshrc ~/.zshrc'
cp ~/.files/dotzshrc ~/.zshrc

echo 'cp -fR dotemacs.d ~/.emacs.d'
cp -fr ~/.files/dotemacs.d ~/.emacs.d

echo 'cp dotgitconfig ~/.gitconfig'
cp ~/.files/dotgitconfig ~/.gitconfig

echo 'cp dotgitignore_global ~/.gitignore_global'
cp ~/.files/dotgitignore_global ~/.gitignore_global

echo 'cp dotlatexmkrc ~/.latexmkrc'
cp ~/.files/dotlatexmkrc ~/.latexmkrc

echo 'cp dottmux.conf ~/.tmux.conf'
cp ~/.files/dottmux.conf ~/.tmux.conf

echo 'cp dotpythonstartup.py ~/.pythonstartup.py'
cp ~/.files/dotpythonstartup.py ~/.pythonstartup.py
