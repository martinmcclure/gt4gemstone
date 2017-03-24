#! /usr/bin/env bash

theArgs="$*"

if [ "${GT4GEMSTONE}x" = "x" ] ; then
  localDir="`dirname \"$0\"`"              # relative
  export GT4GEMSTONE="`( cd \"${localDir}/..\" && pwd )`"  # absolutized and normalized
  if [ -z "$GT4GEMSTONE" ] ; then
    # error; for some reason, the path is not accessible
    exit 1  # fail
  fi
fi

source ${GT4GEMSTONE}/bin/private/shFeedback.sh
start_banner
echo "[Info] GT4GEMSTONE=${GT4GEMSTONE}"

export GT4GEMSTONE_STON_REPO="${GT4GEMSTONE}/external/ston/repository/"
export GT4GEMSTONE_REPO="${GT4GEMSTONE}/src/"

externalResourcesDir="${GT4GEMSTONE}/external"
internalScripts="${GT4GEMSTONE}/scripts/gs_3.4.0"
externalScripts="${externalResourcesDir}/scripts/gs_3.4.0"
cypressDir="${GS_HOME}/shared/repos/CypressReferenceImplementation"
cypressRepo="https://github.com/dalehenrich/CypressReferenceImplementation.git"
stonDir="${GS_HOME}/shared/repos/ston"
stonRepo="https://github.com/GsDevKit/ston.git"


if [ ! -d "$externalResourcesDir" ]; then
  mkdir $externalResourcesDir
fi

echo "[Info] Configuring scripts"

if [ ! -d "$externalScripts" ]; then
mkdir -p "$externalScripts"
else
echo "[Info] Recreate $externalScripts"
rm -rf "$externalScripts"
mkdir -p "$externalScripts"
fi


#echo "cp ${internalScripts} ${externalScripts}"
cp ${internalScripts}/*.gs ${externalScripts}/

_GT4GEMSTONE="${GT4GEMSTONE}"
__GT4GEMSTONE="${_GT4GEMSTONE//\//\\/}"
scriptsUsingGt4Gemstone=("load_core_extensions.topaz" "load_dependencies.topaz" "load_full.topaz")
echo $_GT4GEMSTONE
for script in "${scriptsUsingGt4Gemstone[@]}"
do
  echo "$script"
  echo "sed -e 's/\$GT4GEMSTONE/${__GT4GEMSTONE}/g' $internalScripts/$script > $externalScripts/$script"
  sed -e s/\$GT4GEMSTONE/"${__GT4GEMSTONE}\\/external"/g $internalScripts/$script > $externalScripts/$script
done

sed -e s/\$GT4GEMSTONE/"${__GT4GEMSTONE}"/g "$internalScripts/bootstrap_cypress.topaz" > "$externalScripts/bootstrap_cypress.topaz"

_GT4GEMSTONE_STON_REPO="${GT4GEMSTONE_STON_REPO//\//\\/}"
sed -e s/"System performOnServer: 'echo \$GT4GEMSTONE_STON_REPO'"/"'${_GT4GEMSTONE_STON_REPO}'"/g $internalScripts/load_ston.topaz > $externalScripts/load_ston.topaz

_GT4GEMSTONE_REPO="${GT4GEMSTONE_REPO//\//\\/}"
sed -e s/"System performOnServer: 'echo \$GT4GEMSTONE_REPO'"/"'${_GT4GEMSTONE_REPO}'"/g $internalScripts/load_gt4gemstone.topaz > $externalScripts/load_gt4gemstone.topaz


exit_0_banner



# scp -r . gsadmin@192.168.4.114:/gemstone/gt4gemstone



# input /home/andrei/feenk/scripts/symbolExtensions.gs
# input /home/andrei/feenk/scripts/objectExtensions.gs
# input /home/andrei/feenk/scripts/stringExtensions.gs

# input /home/andrei/feenk/scripts/bootstrapSton.topaz
# input /home/andrei/feenk/scripts/loadGt4GemStone.topaz
# STON fromString: '[1,0,-1,true,false,nil]'
# STON fromString: (STON toString: DateAndTime now).

# Object gtGsInspectorPresentationsIn: GtGsGlmCompositePresentation new inContext: nil 
# STON fromString: ((GtGsInspectorProxy forObject: Object new) asTopazSerializedString)
