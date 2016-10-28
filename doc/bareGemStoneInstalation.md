# gt4gemston sever instalation without GsDevKit

gt4gemstone can also be installed in a GemStone/S 64 stone that was not created using GsDevKit. The following steps describe the inslation process  on a Linux server.

## Downloading the gt4gemstone and its dependencies
```
$ git clone https://github.com/feenkcom/gt4gemstone.git
$ cd gt4gemstone
$ export GT4GEMSTONE=`pwd`
$ ./bin/setupEnvGemstone330Bare.sh
``` 
The script `setupEnvGemstone330Bare.sh` dowloads all required dependencies and sets the environmental variable and configures the instalation scripts.

## Load the code within the stone.

The code should be loaded using Topaz. Topaz can be started using the `topaz` command present in the `bin` folder of a GemStone/S 64 instalation. The `login` command will promt for a password.
```
topaz> set gemstone <stone_name>
topaz> set username <user_name>
topaz> login
```

On a server where the the stone is named `gt4gemstone` and the user is SystemUser these commands would be:
```
topaz> set gemstone gt4gemstone
topaz> set username SystemUser
topaz> login
```

Next run the instalation script, verify if there are errors and commit the session.
```
topaz 1> input <PATH_TO_GT4GEMSTONE>/external/scripts/gs_3.3.0/load_full.topaz
topaz 1> errorCount
topaz 1> commit
```
If there are no errors the `errorCount` command will return `0`.

## Connecting to this server

To connect to a stone that does not use GsDevKit one needs to use the client `GtGsBareClient`.
```
gtClient := GtGsBareClient forSessionDescriptionNamed: 'gt4gemstone'.
gtClient performStringRemotelyAndInspect: 'Object'.
gtClient performStringRemotelyAndInspect: 'Dictionary new add: (1->2); yourself'.
gtClient performStringRemotelyAndInspect: 'System stoneName asString.'.

gtClient openGemstonePlayground. 
gtClient openGemstonePlaygroundWithContents: 'ABAddressBook 
		reset; 
		loadDefaultData.
ABAddressBook default.'.

gtClient logout
```