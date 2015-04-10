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
class SimpleBeatVisual extends AbstractVisual implements IBeatVisual
{

	var beatModel:BeatModel;
	//var circle:Sprite;
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
		
		if (visual != null)
			this.removeChild(visual);
		
		visual = new Sprite();
		visual.cacheAsBitmap = true;
		visual.graphics.beginFill(visualColor);
		visual.graphics.drawCircle(0, 0, (h * 0.75)/2);
		visual.graphics.endFill();
		
		visual.x = w / 2;
		visual.y = h / 2;
		
		//circle.alpha = 0;
		this.addChild(visual);
		
		super.show();
		/*var tF:TextFormat = new TextFormat("Arial", 99, 0xFFFFFF, true);
		countInText = new TextField();
		
		
		countInText.alpha = 0;
		countInText.border = false;
		
		countInText.autoSize = TextFieldAutoSize.LEFT;
		countInText.borderColor = 0xFFFFFF;
		countInText.defaultTextFormat = tF;
		
		
		
		//textSprite.addChild(countInText);
		this.addChild(countInText);
		
		*/
	}
	
	override public function redraw():Void {
		
		trace("SimpleBeatVisual::redraw");
		visual.graphics.clear();
		visual.graphics.beginFill(visualColor);
		visual.graphics.drawCircle(0, 0, (h * 0.75)/2);
		visual.graphics.endFill();
		
		visual.x = w / 2;
		visual.y = h / 2;
	}
	override public function upBeat():Void {
		visual.alpha = 0;
		Actuate.tween(visual, 0.2, { alpha: visualUpbeatSize/100 } ).reverse(true);
		
	}
	override public function beat():Void {
		//trace("SimpleBeatVisual::beat");
		visual.alpha = 0;
		Actuate.tween(visual, 0.2, { alpha: visualBeatSize/100 } ).reverse(true);
	}
	override public function countIn(value:Int):Void {
		
		visual.alpha = 0;
		
		countInText.text = Std.string(value);
		countInText.x = w / 2 - countInText.textWidth / 2;
		countInText.y = h / 2 - countInText.textHeight / 2;
		countInText.alpha = 0;
		Actuate.tween(countInText, 0.2, { alpha:1 } ).reverse(true);
	}
	
}