# !/bin/zsh
# last updated:<2015/03/30 18:23:01 from WatanabeYoshito-no-iMac.local by yoshito>
for f in $@
do         
    filename_with_extension=${f##*/}
    filename=${filename_with_extension%.*}
    convert "$filename_with_extension" -flatten -density 144 "${filename}.eps"
done

