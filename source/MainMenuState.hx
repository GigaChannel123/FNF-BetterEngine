package;

import editors.WeekEditorState.WeekEditorFreeplayState;
#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.ui.FlxButtonPlus;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.ui.FlxButton;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var betterEngineVersion:String = '0.2.1 Demo'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	public static var correct:String = 'correct engine - pass';
	public static var incorrect:String = 'bitch why you using zoros engine';

	var menuItems:FlxTypedGroup<FlxSprite>;
	var menuItemss:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'',
		'story_mode',
		'freeplay',
		#if MODS_ALLOWED 'mods' #end
	];

	var optionShitt:Array<String> = [
		'credits',
		#if ACHIEVEMENTS_ALLOWED 'awards', #end
		#if !switch 'donate', #end
		'options'
	];

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Main Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175*scaleRatio ));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175*scaleRatio ));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		menuItemss = new FlxTypedGroup<FlxSprite>();
		add(menuItemss);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/
		var startX:Int = 15;

			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem = new FlxButton(0, (0 * 140), "Story Mode", function() {
				if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);
				MusicBeatState.switchState(new StoryMenuState());
				FlxG.mouse.visible = false;
			});
			menuItem.setGraphicSize(80, 50);
			menuItem.updateHitbox();
			menuItem.label.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.BLACK, CENTER);
			add(menuItem);
			menuItem.scale.x = 3;
			menuItem.scale.y = 3;
			menuItem.x = 200;
			menuItem.y = 150;
			menuItem.ID = 0;
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
				menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();

			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem = new FlxButton(0, (1 * 140), "Freeplay", function() {
				MusicBeatState.switchState(new FreeplayState());
				FlxG.mouse.visible = false;
			});
			menuItem.setGraphicSize(80, 50);
			menuItem.updateHitbox();
			menuItem.label.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.BLACK, CENTER);
			add(menuItem);
			menuItem.scale.x = 3;
			menuItem.scale.y = 3;
			menuItem.x = 200;
			menuItem.y = 300;
			menuItem.ID = 1;
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
				menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();

			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem = new FlxButton(0, (2 * 140), "Mods", function() {
				#if MODS_ALLOWED
				MusicBeatState.switchState(new ModsMenuState());
				#end
				FlxG.mouse.visible = false;
			});
			menuItem.setGraphicSize(80, 50);
			menuItem.updateHitbox();
			menuItem.label.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.BLACK, CENTER);
			add(menuItem);
			menuItem.scale.x = 3;
			menuItem.scale.y = 3;
			menuItem.y = 450;
			menuItem.x = 200;
			menuItem.ID = 2;
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
				menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();

			var offset:Float = 108 - (Math.max(optionShitt.length, 4) - 4) * 80;
			var menuItems = new FlxButton(0, (3 * 140), "Credits", function() {
				MusicBeatState.switchState(new CreditsState());
				FlxG.mouse.visible = false;
			});
			menuItems.setGraphicSize(80, 50);
			menuItems.updateHitbox();
			menuItems.label.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.BLACK, CENTER);
			add(menuItems);
			menuItems.scale.x = 3;
			menuItems.scale.y = 3;
			menuItems.x = 500;
			menuItems.y = 300;
			menuItems.ID = 3;
			menuItemss.add(menuItems);
			var scr:Float = (optionShitt.length - 4) * 0.135;
			if(optionShitt.length < 6) scr = 0;
				menuItems.scrollFactor.set(0, scr);
			menuItems.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItems.updateHitbox();

			var offset:Float = 108 - (Math.max(optionShitt.length, 4) - 4) * 80;
			var menuItems = new FlxButton(0, (0 * 140), "Awards", function() {
				MusicBeatState.switchState(new AchievementsMenuState());
				FlxG.mouse.visible = false;
			});
			menuItems.setGraphicSize(80, 50);
			menuItems.updateHitbox();
			menuItems.label.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.BLACK, CENTER);
			add(menuItems);
			menuItems.scale.x = 3;
			menuItems.scale.y = 3;
			menuItems.x = 800;
			menuItems.y = 300;
			menuItems.ID = 0;
			menuItemss.add(menuItems);
			var scr:Float = (optionShitt.length - 4) * 0.135;
			if(optionShitt.length < 6) scr = 0;
				menuItems.scrollFactor.set(0, scr);
			menuItems.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItems.updateHitbox();

			var offset:Float = 108 - (Math.max(optionShitt.length, 4) - 4) * 80;
			var menuItems = new FlxButton(0, (2 * 140), "Donate", function() {
				CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
			});
			menuItems.setGraphicSize(80, 50);
			menuItems.updateHitbox();
			menuItems.label.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.BLACK, CENTER);
			add(menuItems);
			menuItems.scale.x = 3;
			menuItems.scale.y = 3;
			menuItems.x = 800;
			menuItems.y = 150;
			menuItems.ID = 2;
			menuItemss.add(menuItems);
			var scr:Float = (optionShitt.length - 4) * 0.135;
			if(optionShitt.length < 6) scr = 0;
				menuItems.scrollFactor.set(0, scr);
			menuItems.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItems.updateHitbox();

			var offset:Float = 108 - (Math.max(optionShitt.length, 4) - 4) * 80;
			var menuItems = new FlxButton(0, (3 * 140), "Options", function() {
				MusicBeatState.switchState(new options.OptionsState());
				FlxG.mouse.visible = false;
			});
			menuItems.setGraphicSize(80, 50);
			menuItems.updateHitbox();
			menuItems.label.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.BLACK, CENTER);
			add(menuItems);
			menuItems.scale.x = 3;
			menuItems.scale.y = 3;
			menuItems.x = 800;
			menuItem.y = 450;
			menuItems.ID = 3;
			menuItemss.add(menuItems);
			var scr:Float = (optionShitt.length - 4) * 0.135;
			if(optionShitt.length < 6) scr = 0;
				menuItems.scrollFactor.set(0, scr);
			menuItems.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItems.updateHitbox();

		FlxG.mouse.visible = true;
		//FlxG.camera.follow(camFollowPos, null, 1);

		var versionShit:FlxText = new FlxText(12, ClientPrefs.getResolution()[1] - 44, 0, "Better Engine v" + betterEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, ClientPrefs.getResolution()[1] - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			/*if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}*/

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			/*if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									#if MODS_ALLOWED
									case 'mods':
										MusicBeatState.switchState(new ModsMenuState());
									#end
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										MusicBeatState.switchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}*/
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			//spr.screenCenter(X);
		});

		menuItemss.forEach(function(spr:FlxSprite)
		{
			//spr.screenCenter(X);
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
			}
		});
	}
}
