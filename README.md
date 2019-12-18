# Myo_Scripts : 

Myo Armband Alternative Gestures

The Myo Armband is designed to be used in conjunction with arms and hands.  Since the armband has the capability to track movement in a three-dimensional space and their API documentation equates this movement with yaw, roll, and pitch, we decided to model our new alternative gestures on the movement mechanisms of airplanes.  These alternative gestures were designed to be used by an alternative group of people that do not have hands.  

These alternative gestures are:
Pitch Up
Pitch Down
Yaw Left
Yaw Right
Roll Left
Roll Right

Alternative Gestures
Although these gestures can be used with either arm, for the ease of documentation we will explain how to use the gestures if the armband is worn on the right arm.

Terms:
Pitch is movement around (perpendicular to) the x-axis (horizontal axis).  An example of this would be an airplane ascending or descending.
Yaw is the movement around the y-axis (vertical axis.).  An example of this would be an airplane veering to the right or left.
Roll is the movement around the z-axis (front-to-back axis).  An example of this would be an airplane rotating from flying right-side-up to flying upside-down.

Gestures:
Pitch Up – To perform the pitch up gesture, start with your arm resting against your side (pointing toward the ground).  Raise your arm vertically until it is pointing straight out in front of you.

Pitch Down – To perform the pitch down gesture, start with your arm pointing straight out in front of you.  Lower your arm vertically until it is pointing toward the ground.

Yaw Left – To perform the yaw left gesture, start with your arm pointing straight out in front of you.  Move your arm horizontally to the left until your elbow is bent 90 degrees.

Yaw Right – To perform the yaw right gesture, start with your arm pointing straight out in front of you.  Move your arm horizontally to the right until it is pointing away from you.

Roll Left – To perform the roll left gesture, start with your arm pointing straight out in front of you with your bicep pointing toward the sky.  Rotate your arm to the left until your bicep is facing toward you.

Roll Right – To perform the roll right gesture, start with your arm pointing straight out in front of you with your bicep facing toward you.  Rotate your arm to the right until your bicep is pointing toward the sky.


Implementation: 

Language : LUA 
Editor : Visual Studio code 

First I had to download the myo Connect app, and then use the myo armband manager to sync the armband and after having trouble with using the default calibration profile I had to create custom profile to calibrated to my personal arm movements. After getting the default gesturing, I started scripting. there are call back functions that help with flow control, 
such as onPose which detects when pose made which wasn’t useful to my implementation because I wasn’t relying on poses. However, I found on periodic and non Foreground change to be extremely useful in our  case.

I also found a function online to calculate the yaw radial and account for dead zones and the current center, which I then converted to account for those values for all three axises.

After creating the code, I use the MYO application manager to import the script.

I did end up having to adjust values as I went, but I think at the end found working prototype code, that could certainly be refined further but certainly worked.

Code will be attached to the project separately.

Demo : 
https://www.youtube.com/watch?v=-Zqu1F07jvE
