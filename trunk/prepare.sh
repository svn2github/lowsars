#!/bin/bash
# Note: this is only for developers, since this can only work on OSes very similar to mine.
# TODO: (very hard) rewrite it using autoconf/automake

check(){
   echo -n "checking for $1..."
   a=`which $1`
   if [ "$a" != "" ]; then
      echo $a
   else
      echo "no"
      [ "$2" = "" ]&&{
         echo "$1 not found. Please install it."
         exit 1
      }
      [ "$2" = "rec" ]&&{
         echo "$1 not found. $1 is needed to $3. Recommended to install it."
      }
   fi
}
check bash
check mv
check cp
check ls
check echo
check cat
check sleep
check basename
check dirname
check bc
check tee
check msgfmt
check sort
check msgmerge
check fpc rec "compile FreePascal programs"
check gcc rec "compile C programs"
check g++ rec "compile C++ programs"
check xsltproc rec "translate the Cena config file to Lowsars style"
echo "Making i18n files..."
cd po
./gentrans || exit
echo "Done. ./install.sh now."
