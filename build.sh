#!/bin/sh

MUSICFILE="22_SHINKIRO"
MUSICURL="https://www.youtube.com/watch?v=JO4l3Tuy0mQ"

WAD="TouhouDoomAdvancePack.wad"

ACCURL="https://github.com/rheit/acc"
WTURL="https://github.com/makise-homura/wadtools"

usage()
{
	echo "Build script for $WAD."
	echo
	echo "Usage: $0 [-h|--usage|--help|-c]"
	echo "    -c : Clean everything instead of building WAD file."
	echo "   --usage ,"
	echo "   --help ,"
	echo "    -h : This help."
	exit 5
}

error_exit()
{
	RV=$1; shift; echo; echo $@; exit $RV
}

deliver_wadbuild()
{
	echo
	echo "-- None found, but we will download and compile it now..."
	[ -z "$CC" ] && CC=gcc
	PWD=`pwd`
	CC=`which $CC`
	GIT=`which git`
	[ -x "$GIT" ] || error_exit 3 "No git tool found. Clone git repository $WTURL to $PWD/wadtools manually."
	[ -x "$CC" ] || error_exit 3 "No $CC compiler found. Specify CC=your_c_compiler or install gcc."
	$GIT clone $WTURL || error_exit 1 "Unable to clone git repository $WTURL. Clone it to $PWD/wadtools manually."
	cd wadtools && $CC wadbuild.c -o wadbuild || error_exit 1 "Unable to build wadbuild."
	cd ..
}

deliver_acc()
{
	echo
	echo "-- None found, but we will download and compile it now..."
	PWD=`pwd`
	GIT=`which git`
	[ -x "$GIT" ] || error_exit 3 "No git tool found. Clone git repository $ACCURL to $PWD/acc manually and build acc binary inside $PWD/acc/build directory."
	rm -rf $PWD/acc
	$GIT clone $ACCURL || error_exit 1 "Unable to clone git repository $ACCURL. Clone it to $PWD/acc manually and build acc binary inside $PWD/acc/build directory.."
	cd acc && mkdir build && cd build && cmake .. && make || error_exit 1 "Unable to build acc. Build it yourself inside $PWD/acc/build directory."
	cd ../..
}

deliver_music()
{
	echo
	echo "-- None found, but we will download it now..."
	YDL=`which youtube-dl`
	[ -x "$YDL" ] || error_exit 3 "No youtube-dl tool found. You may acquire it by executing \`pip install youtube-dl' as root."
	echo
	echo "-- Downloading $MUSICFILE.wav from $MUSICURL..."
	$YDL -x --audio-format=wav -o "$MUSICFILE.%(ext)s" $MUSICURL || error_exit 1 "Unable to download $MUSICFILE.wav. Is youtube-dl not functioning? Try updating it with -U."
}

clean_all()
{
	echo "Cleaning."
	rm -rf acc
	rm -rf wadtools
	rm $MUSICFILE.wav
	rm 13_TOUHOU2.o
	rm 18_BEHAVIOR.o
	rm $WAD
	echo "Clean complete."
	exit 0
}

[ "$1" == "--help" ]  && usage
[ "$1" == "-h" ]      && usage
[ "$1" == "--usage" ] && usage

[ "$1" == "-c" ]      && clean_all

echo "*** Building $WAD. ***"

echo
echo "-- Checking for acc..."
[ -x "./acc/build/acc" ] || deliver_acc

echo
echo "-- Checking for wadbuild..."
[ -x "./wadtools/wadbuild" ] || deliver_wadbuild

echo
echo "-- Checking for $MUSICFILE.wav..."
[ -e "$MUSICFILE.wav" ] || deliver_music

echo
echo "-- Compiling TOUHOU2..."
./acc/build/acc -i ./acc 15_TOUHOU2.acs 13_TOUHOU2.o || error_exit 1 "Unable to compile TOUHOU2."

echo
echo "-- Compiling STATMAP/SCRIPTS..."
./acc/build/acc -i ./acc 19_SCRIPTS.acs 18_BEHAVIOR.o || error_exit 1 "Unable to compile STATMAP/SCRIPTS."

echo
echo "-- Compiling $WAD..."
CMD="./wadtools/wadbuild $WAD"
for FILE in ??_*; do LUMP=`echo $FILE | sed 's/^[0-9][0-9]_//g;s/\..*//'`; CMD="$CMD $FILE $LUMP"; done

echo
echo "-- Running: $CMD"
echo
eval $CMD

echo
echo "*** $WAD has been built successfully. ***"
exit 0
