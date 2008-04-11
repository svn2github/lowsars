#!/bin/bash
# Note: this is only for developers, since this can only work on OSes very similar to mine.
# TODO: (very hard) rewrite it using autoconf/automake

d_share=/usr/share
echo "Copying the share files..."
mkdir -p $d_share/lowsars
cp lib/* $d_share/lowsars/
echo "Copying the i18n files..."
d_locale=/usr/share/locale
langs=`cat po/langs`
f=lowsars
for lang in $langs; do
   mkdir -p $d_locale/$lang/LC_MESSAGES/
   cp po/$lang/$f.mo $d_locale/$lang/LC_MESSAGES/
done
echo "Copying the lowsars-* files..."
d_bin=/usr/bin
mkdir -p $d_bin
binfiles=`ls lowsars*`
for bf in ${binfiles//~/}; do
   cp $bf $d_bin/$bf
done
echo "Copying /bin/bash to /bin/bash_by_lowsars"
echo "If anything goes wrong, try copy a bash from Ubuntu to /bin/bash_by_lowsars"
# cp /bin/bash /bin/bash_by_lowsars
echo "All done."

