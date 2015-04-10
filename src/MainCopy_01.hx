package;

import flash.text.TextField;
import ru.stablex.ui.widgets.Slider;

import openfl.Assets;

import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.media.Sound;
import openfl.utils.Timer;

import ru.stablex.ui.events.WidgetEvent;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Checkbox;
import ru.stablex.ui.widgets.InputText;
import ru.stablex.ui.widgets.Options;
import ru.stablex.ui.widgets.Widget;

import ru.stablex.ui.UIBuilder;




/**
 * ...
 * @author MichaPooh
 */

class Main extends Sprite 
{

	var inited:Bool = false;
	var mTimer:Timer;
	var startTime:Int;
	var upbeat:Sound;
	var beat:Sound;
	var measureRoll:Array<Int>;
	var measureIndex:Int = 0;
	var playing:Bool = false;
	var beatModel:BeatModel;
	var beatVisual:AbstractVisual;
	var soundList:Array<String>;
	var soundOptions:Array<Array<Dynamic>>;
	var loadOptions_a:Array<Array<Dynamic>>;
	var countIn:Int;
	var changeSpeedFlag:Bool;
	var changeSpeedCount:Int;
	var measureCount:Int;
	
	var restartTimerOnNextTick:Bool;
	
	//Stablexui
	var widgetRoot:Widget;
	var speed_inp:InputText;
	var speed2_inp:InputText;
	var speedChange_inp:InputText;
	var measure_inp:InputText;
	var toogleButton:Button;
	var sound1Options:Options;
	var sound2Options:Options;
	var speedToogle_chk:Checkbox;
	var countIn_chk:Checkbox;
	var saveButton:Button;
	var save_inp:InputText;
	var loadOptions:Options;
	var deleteButton:Button;
	var speedSlider:Slider;
	
	public function new() {
		
		super();
		trace("Main::new");
		addEventListener(Event.ADDED_TO_STAGE, addedToStage);
	}
	
	function init() {
		trace("Main::init");
		if (inited) return;
			inited = true;
		
		loadOptions_a = Settings.loadData();
		
		beatModel = new BeatModel();
		
		soundList = Assets.list(AssetType.SOUND);
		
		soundOptions = new Array();
		
		for (i in 0...soundList.length) {
			var value:String = soundList[i];
			var label:String = value.substring(value.lastIndexOf("/") + 1);
			soundOptions.push([label, value]);
		}
		
		beatVisual = new SimpleBeatVisual(beatModel, stage.stageWidth, stage.stageHeight * 0.4);
		beatVisual.x = 0;
		beatVisual.y = 0;
		this.addChild(beatVisual);
		
		cast(beatVisual, SimpleBeatVisual).show();
		
		createGUI3();
		
		measureRoll = [1, 2, 2, 2];
		upbeat = Assets.getSound("assets/sound/snare01.wav");
		beat = Assets.getSound("assets/sound/clav01.wav");
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	function onKeyDown(e:KeyboardEvent):Void {
		
		trace("Main::onKeyDown");
		//trace("stage.focus:" + stage.focus);
		if(e.keyCode == 32 && stage.focus != save_inp.label) {
			
			toogleMetronome();
		}
		
		
	}
	function startMetronome():Void { 
		
		stage.focus = toogleButton;
		
		var lastItem:Dynamic = getSelectedBeatValues();
		lastItem.name = "Last setting";
		
		Settings.addItem(lastItem);
		
		upbeat = Assets.getSound(sound1Options.value);
		beat = Assets.getSound(sound2Options.value);
		
		restartTimerOnNextTick = false;
		
		measureRoll = new Array();
		for (i in 0...measure_inp.text.length) {
			measureRoll.push(Std.parseInt(measure_inp.text.charAt(i)));
			
		}
		
		if(countIn_chk.selected) {
			countIn = measureRoll.length;
		} else {
			countIn = 0;
		}
		
		changeSpeedFlag = speedToogle_chk.selected;
		
		if (changeSpeedFlag)
			changeSpeedCount = Std.parseInt(speedChange_inp.text);
		
		measureCount = 0;
		var timerSpeed:Int = Std.int(60000/Std.parseInt(speed_inp.text));
		trace("interval:" + timerSpeed);
		
		mTimer = new Timer(timerSpeed);
		mTimer.addEventListener("timer", onTimer);
		
		startTime = Lib.getTimer();
		mTimer.start();
	}
	function stopMetronome():Void {
		
		mTimer.stop();
		measureIndex = 0;
	}
	
	function toogleMetronome():Void {
		if (!playing) {
				
				startMetronome();
				toogleButton.text = "Stop";
				
			} else {
				stopMetronome();
				toogleButton.text = "Start";
			}
			playing = !playing;
		
	}
	function onTimer(e) {
		
		
		//trace("Main::onTimer:" + (Lib.getTimer() - startTime));
		
		if(restartTimerOnNextTick) {
			
			mTimer.stop();
			var timerSpeed:Int = Std.int(60000/Std.parseInt(speed2_inp.text));
			
			mTimer = new Timer(timerSpeed);
			mTimer.addEventListener("timer", onTimer);
			
			restartTimerOnNextTick = false;
			mTimer.start();
		}
		var measureBeat:Int = measureRoll[measureIndex];
		
		switch (measureBeat) {
			
			case 1:
				upbeat.play();
			case 2:
				beat.play();
		}
		
		if (measureIndex >= measureRoll.length -1) {
			measureIndex = 0;
			
		} else {
			measureIndex++;
		}
		
		if (countIn > 0) {
			beatVisual.countIn(countIn);
			countIn--;
			
		} else {
			beatVisual.beat();
			
			if(changeSpeedFlag) {
				
				if(measureIndex == 0) {
					changeSpeedCount--;
					if (changeSpeedCount == 0) {
						
						changeSpeedFlag = false;
						restartTimerOnNextTick = true;
						
					}
					
				}
			}
		}
	}
	
	
	function createGUI3():Void {
		
		UIBuilder.setTheme('ru.stablex.ui.themes.android4');
		UIBuilder.init();
		
		widgetRoot = UIBuilder.buildFn('assets/gui/beatGUI.xml')();
		widgetRoot.cacheAsBitmap = true;
		
		flash.Lib.current.addChild(widgetRoot);
		
		speed_inp = UIBuilder.getAs('speed_inp', InputText);
		speed_inp.label.addEventListener("change", function (e:Event) {
			textRestrict("[0-9]", speed_inp.label);
			beatModel.timerSpeed = Std.int(60000/Std.parseInt(speed_inp.text));
			
		});
		measure_inp = UIBuilder.getAs('measure_inp', InputText);
		measure_inp.label.addEventListener("change", function (e:Event) {
			textRestrict("[012]", measure_inp.label);
		});
		toogleButton = UIBuilder.getAs('toogleButton', Button);
		
		sound1Options = UIBuilder.getAs('options1', Options);
		sound2Options = UIBuilder.getAs('options2', Options);
		
		speed2_inp = UIBuilder.getAs('speed2_inp', InputText);
		speed2_inp.label.addEventListener("change", function (e:Event) {
			textRestrict("[0-9]", speed2_inp.label);
		});
		speedChange_inp = UIBuilder.getAs('speedChange_inp', InputText);
		speedChange_inp.label.addEventListener("change", function (e:Event) {
			textRestrict("[0-9]", speedChange_inp.label);
		});
		
		speedToogle_chk = UIBuilder.getAs('speedToogle_chk', Checkbox);
		countIn_chk = UIBuilder.getAs('countIn_chk', Checkbox);
		
		sound1Options.options = soundOptions;
		sound2Options.options = soundOptions;
		toogleButton.onRelease = onClick;
	
		saveButton = UIBuilder.getAs('save_btn', Button);
		saveButton.onRelease = onSave;
		
		save_inp = UIBuilder.getAs('saveName_inp', InputText);
		
		loadOptions = UIBuilder.getAs('loadOptions', Options);
		loadOptions.options = loadOptions_a;
		loadOptions.addEventListener(WidgetEvent.CHANGE, onChange);
		
		loadOptions.value = "Last setting";
		
		deleteButton = UIBuilder.getAs('delete_btn', Button);
		deleteButton.onRelease = onDelete;
		
		speedSlider = UIBuilder.getAs('speed_slider', Slider);
		speedSlider.addEventListener(WidgetEvent.CHANGE, function (e:WidgetEvent) {
			
			speed_inp.label.text = Std.string(Math.round(speedSlider.value));
		});
	}
	
	function onChange(e:Event):Void {
		trace("Options change:");
		var selectedItem:Dynamic = Settings.getItemForName(loadOptions.value);
		
		trace("selectedItem:" + selectedItem);
		if(selectedItem != null) {
			
			measure_inp.text = selectedItem.pattern;
			speed_inp.text = selectedItem.speed;
			
			selectOptionFromLabel(selectedItem.sound1Name, sound1Options);
			selectOptionFromLabel(selectedItem.sound2Name, sound2Options);
			
			speed2_inp.text = selectedItem.changeSpeed;
			speedChange_inp.text = selectedItem.changeMeasures;
			speedToogle_chk.selected = selectedItem.changeSpeedFlag;
			countIn_chk.selected = selectedItem.countInFlag;
		}
		
	}
	function onSave(e:MouseEvent):Void {
		trace("Main::onSave:" + sound2Options.label);
		if(save_inp.text != "") {
			var newItem:Dynamic = getSelectedBeatValues();
			
			loadOptions_a = Settings.addItem(newItem);
			var saveValue:Dynamic = newItem.name;
			loadOptions.options = loadOptions_a;
			loadOptions.value = saveValue;
			
			save_inp.text = "";
		}
		
	}
	
	function onDelete(e:MouseEvent):Void {
		
		if(loadOptions_a.length > 1) {
			loadOptions_a = Settings.deleteItem(getLabelFromOptionValue(loadOptions.value, loadOptions));
			var selectedValue:Dynamic = "Last setting";
			loadOptions.options = loadOptions_a;
			loadOptions.value = selectedValue;
		}
	}
	function onClick(e:MouseEvent):Void {
		
		toogleMetronome();
		
	}
	function resize(e) {
		trace("Main::resize");
		widgetRoot.w = stage.stageWidth;
		widgetRoot.h = stage.stageHeight*0.6; 
		widgetRoot.y = stage.stageHeight * 0.4;
		
		beatVisual.resize(stage.stageWidth, stage.stageHeight * 0.4);
	}
	function addedToStage(e)  {
		trace("Main::addedToStage");
		removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		
		stage.addEventListener(Event.RESIZE, resize);
		
		#if ios
			haxe.Timer.delay(init, 100); // iOS 6
		#else
			init();
		#end
	}
	
	function getSelectedBeatValues():Dynamic {
		
		var saveItem:Dynamic = {
					"name": save_inp.text,
					"pattern": measure_inp.text,
					"speed": speed_inp.text,
					"changeSpeedFlag": speedToogle_chk.selected,
					"changeSpeed": speed2_inp.text,
					"changeMeasures": speedChange_inp.text,
					"countInFlag": countIn_chk.selected,
					"sound1Name": getLabelFromOptionValue(sound1Options.value, sound1Options),
					"sound2Name": getLabelFromOptionValue(sound2Options.value, sound2Options)
			}
			
			return saveItem;
	}
	
	//Native no restrict implementation workaround
	function textRestrict(pattern:String, _textField:TextField):Void {
		
		var r = new EReg("^"+pattern+"*$", "i");
		var checkedString:String = "";

		for(i in 0 ... _textField.text.length){
			var char:String = _textField.text.charAt(i);
			if(r.match(char)){
				checkedString += char;
			}
		}

		_textField.text = checkedString;
		
	}
	function getLabelFromOptionValue(value:Dynamic, optionsList:Options):String {
		for(i in 0...optionsList.options.length) {
			
			if(optionsList.options[i][1] == value) {
				return optionsList.options[i][0];
				break;
			}
		}
		
		return optionsList.options[0][0];
	}
	function selectOptionFromLabel(label:String, optionsList:Options):Void {
		for(i in 0...optionsList.options.length) {
			
			if(optionsList.options[i][0] == label) {
				optionsList.value = optionsList.options[i][1];
				break;
			}
		}
		
	}
	
	public static function main() {
		// static entry point
		trace("Main::main");
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
		
		
		//
	}
}
