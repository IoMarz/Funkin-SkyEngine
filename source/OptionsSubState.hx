package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionsSubState extends MusicBeatSubstate
{
	var textMenuItems:Array<String> = ['Return to Main Menu', 'Input System', 'UI', 'Character AA'];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<FlxText>;

	var inputTypeSelected:FlxText;
	var inputSelectedText:String;
	
	var uiTypeSelected:FlxText;
	var uiTypeText:String;

	var aaTypeSelected:FlxText;
	var aaTypeText:String;

	public function new()
	{
		super();

		grpOptionsTexts = new FlxTypedGroup<FlxText>();
		add(grpOptionsTexts);

		selector = new FlxSprite().makeGraphic(5, 5, FlxColor.RED);
		add(selector);

		inputSelectedText = "New Inputs";
		uiTypeText = "Enabled";
		aaTypeText = "Enabled";

		inputTypeSelected = new FlxText(20, 400, 0, inputSelectedText, 32);
		add(inputTypeSelected);

		uiTypeSelected = new FlxText(20, 450, 0, uiTypeText, 32);
		add(uiTypeSelected);

		aaTypeSelected = new FlxText(20, 500, 0, uiTypeText, 32);
		add(aaTypeSelected);

		for (i in 0...textMenuItems.length)
		{
			var optionText:FlxText = new FlxText(20, 20 + (i * 50), 0, textMenuItems[i], 32);
			optionText.ID = i;
			grpOptionsTexts.add(optionText);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		inputTypeSelected.text = inputSelectedText;
		uiTypeSelected.text = uiTypeText;
		aaTypeSelected.text = aaTypeText;

		if (controls.UP_P)
			curSelected -= 1;

		if (controls.DOWN_P)
			curSelected += 1;

		if (curSelected < 0)
			curSelected = textMenuItems.length - 1;

		if (curSelected >= textMenuItems.length)
			curSelected = 0;
		
		if (controls.BACK)
			FlxG.switchState(new MainMenuState());

		grpOptionsTexts.forEach(function(txt:FlxText)
		{
			txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		if (controls.ACCEPT)
		{
			switch (textMenuItems[curSelected])
			{
				case "Input System":
					FlxG.sound.play(Paths.sound('confirmMenu'));
					// Old inputs are currently broken :/
					/*
					if (Options.newInput == true)
					{
						inputSelectedText = "Old Inputs";
						Options.newInput = false;	
					} 
					else if (Options.newInput == false) 
					{
						inputSelectedText = "New Inputs";
						Options.newInput = true;
					}
					*/
				case "Return to Main Menu":
					FlxG.switchState(new MainMenuState());
				case "UI":
					if (Options.uiToggle)
					{
						Options.uiToggle = false;
						uiTypeText = "Disabled";
						FlxG.sound.play(Paths.sound('confirmMenu'));
					}
					else
					{
						Options.uiToggle = true;
						uiTypeText = "Enabled";
						FlxG.sound.play(Paths.sound('confirmMenu'));
					}
				case "Character AA":
					if (Options.characterAA)
					{
						Options.characterAA = false;
						aaTypeText = "Disabled";
						FlxG.sound.play(Paths.sound('confirmMenu'));
					}
					else
					{
						Options.characterAA = true;
						aaTypeText = "Enabled";
						FlxG.sound.play(Paths.sound('confirmMenu'));
					}
			}
		}
	}
}
