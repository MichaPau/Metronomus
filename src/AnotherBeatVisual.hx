package;

import openfl.display.Sprite;
import motion.Actuate;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;
/**
 * ...
 * @author MichaPooh
 */
class AnotherBeatVisual extends AbstractVisual implements IBeatVisual
{

	var beatModel:BeatModel;
	//var visual:Sprite;
	//var countInText:TextField;
	//var textSprite:Sprite;
	//var w:Float;
	//var h:Float;
	public function new(_model:BeatModel, _w:Float, _h:Float) {
		super();
		beatModel = _model;
		w = _w;
		h = _h;
	}
	
	override public function resize(_w:Float, _h:Float):Void {
		super.resize(_w, _h);
		//w = _w;
		//h = _h;
		//show();
	}
	override public function show():Void {
		
		/*if (visual != null)
			removeChild(visual);
		*/	
		visual = new Sprite();
		visual.cacheAsBitmap = true;
		visual.graphics.beginFill(visualColor);
		//visual.graphics.drawRect( -(w * 0.75) / 2, -(h * 0.15) / 2, (w * 0.75), (h * 0.15));
		visual.graphics.drawRoundRect( -(w * 0.75) / 2, -(h * 0.15) / 2, (w * 0.75), (h * 0.15), (h * 0.15), (h * 0.15));
		visual.graphics.endFill();
		
		visual.x = w / 2;
		visual.y = h / 2;
		
		//visual.scaleX = 0;
		this.addChild(visual);
		
		super.show();
		/*var tF:TextFormat = new TextFormat("Arial", 99, 0xFFFFFF, true);
		countInText = new TextField();
		
		
		countInText.alpha = 0;
		countInText.border = false;
		
		countInText.autoSize = TextFieldAutoSize.LEFT;
		countInText.borderColor = 0xFFFFFF;
		countInText.defaultTextFormat = tF;
		
		this.addChild(countInText);*/
		
		
	}
	
	override public function redraw():Void {
		
		trace("AnotherBeatVisual::redraw");
		visual.graphics.clear();
		visual.graphics.beginFill(visualColor);
		visual.graphics.drawRoundRect( -(w * 0.75) / 2, -(h * 0.15) / 2, (w * 0.75), (h * 0.15), (h * 0.15), (h * 0.15));
		visual.graphics.endFill();
		
		visual.x = w / 2;
		visual.y = h / 2;
	}
	override public function upBeat():Void {
		visual.scaleX = 0;
		Actuate.tween(visual, 0.2, { scaleX: visualUpbeatSize/100 } ).reverse(true);
		
	}
	override public function beat():Void {
		//trace("SimpleBeatVisual::beat");
		visual.scaleX = 0;
		Actuate.tween(visual, 0.2, { scaleX: visualBeatSize/100 } ).reverse(true);
	}
	/*override public function countIn(value:Int):Void {
		
		visual.alpha = 0;
		
		countInText.text = Std.string(value);
		countInText.x = w / 2 - countInText.textWidth / 2;
		countInText.y = h / 2 - countInText.textHeight / 2;
		countInText.alpha = 0;
		Actuate.tween(countInText, 0.2, { alpha:1 } ).reverse(true);
	}*/
	
}