local charting = false
local visible = false

function onSongStart()
	charting = false
end

function onUpdate()

				practice = getPropertyFromClass('ClientPrefs', 'practiceMode')
				hudVisible = getPropertyFromClass('ClientPrefs', 'hideHud')
                Mouse = getPropertyFromClass('flixel.FlxG', 'mouse.visible')
                --getPropertyFromClass('flixel.input', 'FlxKey') --Basically lets the script figure out what button you are pressing.
                chartingMode = getPropertyFromClass('PlayState', 'chartingMode')
        --[[]]--
        if Mouse == true then
                if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.Y') then

                                setPropertyFromClass('flixel.FlxG', 'mouse.visible', false);
                                        debugPrint('Mouse Hidden.')
                end
        end  
                if Mouse == false then
                        if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.Y') then
                        
                                        setPropertyFromClass('flixel.FlxG', 'mouse.visible', true);
                                                debugPrint('Mouse Revealed.')
                        end
                        
                end
			if hudVisible == true then
				if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.H') then
					setPropertyFromClass('ClientPrefs', 'hideHud', false)
					debugPrint('Hud Visible.')
				end
			end
			if hudVisible == false then
				if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.H') then
					setPropertyFromClass('ClientPrefs', 'hideHud', true)
					debugPrint('Hud Hidden.')
				end
			end

				if botPlay == false then
					if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.B') then
						setProperty('cpuControlled', true)
						debugPrint('BOTPLAY Enabled. Taking Control...')
					end
				
				elseif botPlay == true then
					if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.B') then
						setProperty('cpuControlled', false)
						debugPrint('BOTPLAY Disabled. Handing over Control...')
					end
				end

		

			if chartingMode then
				if mouseClicked('left') then
					debugPrint('Camera Pos X: ',cameraX)
				end
				
				if mouseClicked('right') then
					debugPrint('Camera Pos Y: ',cameraY)
				end
			end
				
				
        if not lowQuality then
                if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.L') then
                        setPropertyFromClass('ClientPrefs','lowQuality', true)
                        debugPrint('Low Quality Mode Enabled. Please Restart the Song.')
                end
        end
        if lowQuality then
                if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.L') then
                        setPropertyFromClass('ClientPrefs','lowQuality', false)
                        debugPrint('Low Quality Mode Disabled. Please Restart the Song.')
                end
        end

        if not middlescroll then
                if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.M') then
                        setPropertyFromClass('ClientPrefs', 'middleScroll', true)
                        debugPrint('Middle Scroll Enabled. Please Restart the Song.')
                end
        end
        if middlescroll then
                if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.M') then
                        setPropertyFromClass('ClientPrefs', 'middleScroll', false)
                        debugPrint('Middle Scroll Disabled. Please Restart the Song.')
                end
        end
		if not downscroll  then
			if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.N') then
				setPropertyFromClass('ClientPrefs', 'downScroll', true)
				debugPrint('Down Scroll Enabled. Please Restart the Song.')
			end
		end
		if downscroll then
			if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.N') then
				setPropertyFromClass('ClientPrefs', 'downScroll', false)
				debugPrint('Down Scroll Disabled. Please Restart the Song.')
			end
		end

                getPropertyFromClass('flixel.FlxG', 'keys.justPressed.C') --Basically lets the script figure out what button you are pressing.
            
                if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.C') then --self explanatory 
                        --characterPlayAnim('boyfriend', 'hey', true);
                        triggerEvent('Play Animation', 'hey', 'BF') 
        
                end
				
				if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.V') then
					if charting == false then
						charting = true
						debugPrint('Charting set to true.')
					elseif 	charting == true then
						charting = false
						debugPrint('Charting set to false.')
					end
				end
				
				
                if not chartingMode then
                        if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SHIFT') then --self explanatory 
                        setPropertyFromClass('PlayState', 'chartingMode', true)
                                debugPrint('Charting Mode Enabled.')
                        end
                end
                if chartingMode then
                        if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SHIFT') then --self explanatory 
                        setPropertyFromClass('PlayState', 'chartingMode', false)
                                debugPrint('Charting Mode Disabled.')
                        end
                end
                
                                chartingMode = getPropertyFromClass('PlayState', 'chartingMode')
                stageName = getPropertyFromClass('PlayState', 'SONG.stage')
                G = getPropertyFromClass('flixel.FlxG', 'keys.justPressed.G')
                if chartingMode == true then
                        getPropertyFromClass('flixel.input', 'FlxKey')
                                if G then
                
                        
                                        debugPrint('Week Name: ', week)
                                        debugPrint('Song Name: ', songName,';',' BPM: ', bpm)
                                        debugPrint('Song Length: ', songLength,' Milliseconds;',' Scroll Speed: ', scrollSpeed)
                                        debugPrint('Current Boyfriend: ', boyfriendName)
                                        debugPrint('Current Opponent: ', dadName)
                                        debugPrint('Current Stage: ', stageName)
                                end
                end
end
function onEvent(name,value1,value2)
                chartingMode = getPropertyFromClass('PlayState', 'chartingMode')
                if chartingMode then
                          
                  
                  
                        if name == 'Camera Follow Pos' then
                                        --nothing lol
                                        -- for the scripts that give the camera follow shit when you hit notes, that shit would be printing EVERY FRAME! (ಥ﹏ಥ)
                                        elseif name == 'Add Camera Zoom' then
                                                --non lmao
                                        elseif name == 'Flashing Camera' then
                                                --nada kek
                                        elseif name == 'Cam Speed' then
                                                --void lel
                                        elseif name == 'Zoom' then
                                                --none *trollface*
                                        elseif name == 'Tricky_Static' then
                                                --no
                                        elseif name == 'Screen Shake' then
                                                --lol no printing
										elseif name == 'Alt Idle Animation' and boyfriendName == 'bf-Aloe' then
												--nothing
										elseif name == 'Add Zoom Hard' then
												--nope lol
                                
                
                                else    
                                        debugPrint(name,', ',value1,', ',value2)
                        end
                end
end
function onEndSong()
	if charting == true then
		setPropertyFromClass('PlayState', 'chartingMode', true)
	else
		setPropertyFromClass('PlayState', 'chartingMode', false)
	end
	return Function_Continue;
end
function onDestroy()
	setPropertyFromClass('ClientPrefs', 'hideHud', false)
end
