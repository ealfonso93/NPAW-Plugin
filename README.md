# NPAW Plugin

Test plugin for the NPAW Application

### Installing

Download the libPlugin.a file and the include folder from the release section, place them on the root of the Project.
Go to your application target settings, under Build Phases add “$SOURCE_ROOT/include” 

On the target settings, under Build Phases add a new “binary” on “Link Binary With Libraries” select the libPlugin.a you have on your Project folder

On “Build Settings” look for the “Other linker flags” setting and add type –ObjC

### Available methods

This plugin has basically the following methods:

 **-(void)addPlay**
Used when the user has pressed the play button (it doesn’t matter if it’s the first time or not)

**-(void)addStop;**
Used when the user has pressed the stop button

**-(void)videoFinished;**
Similar to the above method but should only be called when the video has reached the end

