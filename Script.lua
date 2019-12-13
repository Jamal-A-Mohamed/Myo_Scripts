 scriptId = 'co.project.powerpoint'

centerYaw = 0
centerPitch = 0
center = 0 



PI = math.pi
TWOPI = PI * 2 
YAW_DEADZONE = .5
ROLL_DEADZONE = .6
pitch_DEADZONE = .4
lastTimeRightSlide = myo.getTimeMilliseconds() -- for given enough  time between inputs 
lastTimeLeftSlide = myo.getTimeMilliseconds() -- for given enough  time between inputs 
lastTimeEnterSlide = myo.getTimeMilliseconds() -- for given enough  time between inputs 
rightSlide = true -- for preventing the unnecessary inputs 
leftSlide = true -- for preventing the unnecessary inputs 
enterSlideShow = true -- for preventing the unnecessary inputs 
exitSlideShow = false  --- for preventing uncessary inputs 

pause = true 


function onForegroundWindowChange(app, title)
	center()
	myo.setLockingPolicy("none")

return app == "com.microsoft.Powerpoint"

--return true
end







--- this call to center the radials to the current position.
function center()  
	myo.debug("Centred")
	centerYaw = myo.getYaw()
	centerRoll = myo.getRoll()
	centerPitch = myo.getPitch()
	pause = true 
	myo.vibrate("short")
end






	function onPeriodic()   --- this is a native call back function tha executes every milliseconds
		if (centerYaw == 0 or centerPitch == 0 or centerRoll == 0  ) then
			--- go back becuase we haven't done anything 
            return
        end
		local currentYaw = myo.getYaw()
		local currentRoll = myo.getRoll()
		local currentPitch = myo.getPitch()
		local deltaYaw = calculateDeltaRadians(currentYaw, centerYaw)
		local deltaRoll = calculateDeltaRadians(currentRoll,centerRoll)
		local deltaPitch = calculateDeltaRadians(currentPitch,centerPitch)

        if (deltaYaw > YAW_DEADZONE) then
		
			rightSlide()
		

        elseif (deltaYaw < -YAW_DEADZONE) then
			leftSlide()
		

		end

		if (math.abs(  deltaRoll ) > ROLL_DEADZONE) then
			pauseResume()

		 end

		if(deltaPitch > pitch_DEADZONE ) then 
			exitSlideShowfunc()

		elseif (deltaPitch < -pitch_DEADZONE) then 
			enterSlideShowfunc()

		end
  
    end

    

---functions for manipulating slideshow 

function rightSlide()
	local now = myo.getTimeMilliseconds()
	if ( now - lastTimeRightSlide > 1000) then 
	myo.debug("Going to the next slide")
	myo.keyboard("right_arrow","press")
	lastTimeRightSlide = myo.getTimeMilliseconds()
	local timegain = myo.getTimeMilliseconds()
	if (timegain - now > 300) then --- trying to center again
		myo.debug("centering again")

		center()
	end
	else 
		myo.debug("too soon to go the next slide  ")
		return 

	end 
end

function leftSlide()
	local now = myo.getTimeMilliseconds()
	
	if(  now - lastTimeLeftSlide  > 2000  ) then 
		myo.debug("Going to the previous slide")
	myo.keyboard("left_arrow","press")
	lastTimeLeftSlide = myo.getTimeMilliseconds()
	local timegain = myo.getTimeMilliseconds()
	if (timegain - now > 300) then --trying to center again
		myo.debug("centering again")
		center()
	end
	else 
		myo.debug("too soon, to go the the previous Slide  ")
		return
	end 
end



function enterSlideShowfunc()
	if(enterSlideShow) then 
	local now = myo.getTimeMilliseconds()

	myo.debug("Entering SlideShow slide")
	myo.keyboard("return","press","command")
	lastTimeEnterSlide = myo.getTimeMilliseconds()

	exitSlideShow = true 
	enterSlideShow = false 
	local timegain = myo.getTimeMilliseconds()
	if (timegain - now > 1000) then --trying to center again
		myo.debug("centering again")
		center()
	end

else 
	myo.debug("slide show can't be entered, it's already engaged")
	return
	end 

	 
end

function exitSlideShowfunc()
	local now = myo.getTimeMilliseconds()
if (now - lastTimeEnterSlide > 1000) then 
	if(exitSlideShow) then 
		myo.debug("exiting SlideShow ")
	myo.keyboard("escape","press")
	exitSlideShow = false 
	enterSlideShow = true  
	local timegain = myo.getTimeMilliseconds()

	if (timegain - now > 1000) then --trying to center again
		myo.debug("centering again")
		center()
	end
	end 
	else 
		myo.debug("Slide show can't be exited, because it's too soon ")
		return 
	end
end


function pauseResume() 
	local now = myo.getTimeMilliseconds()
	if(pause) then 
		myo.keyboard("w","press")
		local timegain = myo.getTimeMilliseconds()
		pause = false 
	if (now - timegain > 1000) then --trying to center again
		myo.debug("centering again")
		center()
	end
	else 
		myo.debug("powerPoint slide not active so can't resume")
		return 
	
	end
end 


--- this is the function  I found online that calculated  the delta or the change to the Yaw axis but I implemented for the all AXises

function calculateDeltaRadians(currentRad, centerRad)  
	local deltaRad = currentRad - centerRad

	if (deltaRad > math.pi) then
		deltRad = deltaRad - TWOPI
	elseif(centerRad < -math.pi) then
		deltaRad = delta + TWOPI
	end
	return deltaRad
end  
