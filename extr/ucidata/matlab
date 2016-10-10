#! /bin/sh
#
# Execute a Matlab script.  This is a wrapper around Matlab that makes
# it easier to run Matlab in batch mode and log the output of scripts.
# Used with Matlab 2009B.  
#
# PARAMETERS
# 	$1	    	The Matlab program (with or without .m; may contain directory) 
# 	$jvm_enable	Enable the JVM; the JVM is disabled by default
#	$verbose	When set, enable verbose mode (mainly for debugging)
#	$MATLAB_PARAMS	Space-separated list of environment variables
#			that are passed to the Matlab script, and
#			whose values should be integrated into the
#			logfile name, such that multiple instances can
#			run in parallel. 
# 
# FILES
#	error.log	Errors from all runs of this script are logged
#			in this file  
#
# EXAMPLE
#
#	to run m/map.m, use ./matlab m/map.m 
#
# Matlab scripts run using this method usually don't use command line
# arguments.  Instead, environment variables are passed.  
#

#
# Setup files 
#

# Verbose output
[ $verbose ] && exec 4>&2 || exec 4>/dev/null 

# Error log
exec 6>>error.log

#
# Matlab configuration
#

# The command to use
MATLAB=matlab

# The options to use for Matlab 
MATLAB_OPTIONS="-nodesktop -nosplash"
if [ -z "$jvm_enable" ] ; then
	MATLAB_OPTIONS="$MATLAB_OPTIONS -nojvm"
fi

# Prefix
[ "$PREFIX" ] && PREFIX=.$PREFIX
export PREFIX

# The name of script within Matlab
SCRIPT="$1"
export MATLAB_NAME="$(basename $SCRIPT | sed -E -e 's,\.m$,,')"
echo >&4 "MATLAB_NAME=«$MATLAB_NAME»"

# Check that the file exists
FILENAME="$SCRIPT"
if echo "$FILENAME" | grep -qvE '\.m$' ; then
	FILENAME="$FILENAME.m"
	if ! [ -r "$FILENAME" ] ; then
		echo >&2 "*** No such file:  $FILENAME"
		exit 1
	fi
fi

#
# Logging
#

LOGNAME=$USER.$MATLAB_NAME
# This is a list of variable we want to be used in the log filename to
# make it unique.
[ "$type"    ]     	&& LOGNAME=$LOGNAME.$type
[ "$name"   ]      	&& LOGNAME=$LOGNAME.$name
[ "$decomposition" ]	&& LOGNAME=$LOGNAME.$decomposition
[ "$statistic" ]	&& LOGNAME=$LOGNAME.$statistic
[ "$method" ]		&& LOGNAME=$LOGNAME.$method 
[ "$kind"   ]      	&& LOGNAME=$LOGNAME.$kind
[ "$class"   ]      	&& LOGNAME=$LOGNAME.$class
[ "$group"   ]      	&& LOGNAME=$LOGNAME.$group
[ "$year"   ]      	&& LOGNAME=$LOGNAME.$year
[ "$network" ]		&& LOGNAME=$LOGNAME."`basename "$network"`"

for PARAM in $MATLAB_PARAMS
do
	eval [ "\$$PARAM"   ]   	&& eval LOGNAME=\$LOGNAME.\$$PARAM
done

echo >&4 "LOGNAME=«$LOGNAME»"

export LOGNAME

export TMP_BASE=${TMPDIR-/tmp}/m.$LOGNAME$PREFIX
echo >&2 "   $TMP_BASE"
echo >&4 "TMP_BASE=«$TMP_BASE»"

export LOGFILE=$TMP_BASE.log

#
# Other configurations
#

DISPLAY=

# By default, glibc errors are written to the terminal directly.  This
# will send them to stderr.  (Matlab has been known to trigger such errors.)  
export LIBC_FATAL_STDERR_=1

DIR_SCRIPT="$(dirname $SCRIPT)"
if echo "$DIR_SCRIPT" | grep -vq '^/' ; then
	DIR_SCRIPT="$PWD/$DIR_SCRIPT"
fi
export MATLABPATH="$DIR_SCRIPT:$MATLABPATH"
echo >&4 MATLABPATH=«$MATLABPATH»

# We have to use <<EOF or else Matlab will read its standard input and hang.
$MATLAB -logfile $LOGFILE -r "$MATLAB_NAME" $MATLAB_OPTIONS  \
	>$TMP_BASE.out 2>&1 <<EOF  ||
EOF
{ 
	# Note: Matlab normally always exists with exit code 0, so if we
	# are here Matlab probably crashed. 
	echo >&2 "*** error in $TMP_BASE.log"
	echo >&6 "*** error in $TMP_BASE.log"
	exit 1
}


# Matlab does not exit(!=0) on error but prints ???. 
grep -qE '(\?\?\?|^\*\*\* )' $TMP_BASE.log && 
{
	echo "*** error in $TMP_BASE.log"
	echo >&6 "*** error in $TMP_BASE.log"
	<$TMP_BASE.log >&2 sed -E -e '
		# Matlab output actually contains { and } sequences. 
		s,.,,g
		/\?\?\?|\*\*\*|[Ee]rror/!d
		s,^(|\?\?\? )Error (in|using) ==> ([^ ]+) at ([0-9]+)$,\3.m:\4: ,
		T
		N
		s,\n,,
	'
	exit 1
}

echo >>$TMP_BASE.log '=== FINISHED ==='

exit 0
