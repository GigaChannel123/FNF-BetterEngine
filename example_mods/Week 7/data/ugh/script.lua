local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
		setProperty('inCutscene', true);
		startVideo('ughCutscene');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end
function onUpdate()
      if getProperty('dad.curCharacter') == 'tankman' then
		if getProperty('dad.animation.curAnim.name') == 'UGH' then
			setProperty('dad.holdTimer', 0); --Ugh!
		end
	end
end