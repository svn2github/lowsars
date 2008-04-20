#!/bin/bash
# Note: this is only for developers, since this can only work on OSes similar to mine.
# TODO: (very hard) rewrite it using autoconf/automake

D_BIN=/usr/bin/
D_SHARE=/usr/share/lowsars/
BINFILES="lowsars lowsars-test lowsars-cena"
#BINFILES="lowsars lowsars-test lowsars-input lowsars-commander lowsars-cena"
LIBFILES="lib/database.sh lib/errorcodes-fp lib/escape.sh lib/cena.xsl"
echo "Copying the share files..."
mkdir -p $D_SHARE
cp $LIBFILES $D_SHARE
echo "Copying the i18n files..."
D_LOCALE=/usr/share/locale
LANGS=zh_CN
POFILE=lowsars
for lang in $LANGS; do
   mkdir -p $D_LOCALE/$lang/LC_MESSAGES/
   cp po/$lang/$POFILE.mo $D_LOCALE/$lang/LC_MESSAGES/
done
echo "Copying the lowsars-* files..."
cp $BINFILES $D_BIN
echo "If anything goes wrong, try copy a bash from Ubuntu to /bin/bash_by_lowsars"
[ -x /bin/bash_by_lowsars ]||{
   echo "Copying /bin/bash to /bin/bash_by_lowsars"
   cp /bin/bash /bin/bash_by_lowsars
}
echo "All done."

