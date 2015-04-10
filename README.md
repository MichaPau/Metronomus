This is metronome application.

For a first Haxe application I wanted to do something I use myself.
There are already thousands of metronomes available on the web but every I tried had stuff I didn't needed or stuff missing I wanted to have.
So as a first Haxe app I wrote my own one, inspired by the good old Weird Metronome for Windows.

I just added some functionality like change the speed after some pattern turnarounds (measures) or mute some measures etc. 
No fancy programming stuff here. (Most of the code is in the Main class)

C++, Neko and Flash target should work.
Mobile targets are not tested and HTML5 target needs some fixes (switch the sound assets to ogg etc.)

For the UI it uses stablexui

Help:
Choose a pattern: 
e.x 
122 which plays a Walz pattern with sound 1 selected as the upbeat.
1 which play the same sound
  
Speed is beats per minute
In the 2 sound options you can select between some different beats.

Checkbox for changing the speed to xx after xx measures.
Checkbox for muting the metronome from measure xx to measure xx included (for training if you can hold the rhythm)
Checkbox to countIn 

Save the settings
Load saved settings

On the top: 
change the visual (Two simple ones are included - a pulsing circle and a scaling bar)
change the color of the visual and a percent value for sound1 or/and sound2 (alpha for one visual, size for the other)
 

