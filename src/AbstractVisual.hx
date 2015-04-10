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
class AbstractVisual extends Sprite implements IBeatVisual
{

	public var visual:Sprite;
	public var countInText:TextField;
	public var textSprite:Sprite;
	public var visualColor:Int = 0xFF0000;
	public var visualBeatSize:Int = 50;
	public var visualUpbeatSize:Int = 100;
	public var w:Float;
	public var h:Float;
	private function new() { 
		
		super();
	}
	public function show():Void { 
		
		var tF:TextFormat = new TextFormat("Arial", 99, 0xFFFFFF, true);
		countInText = new TextField();
		
		
		countInText.alpha = 0;
		countInText.border = false;
		
		countInText.autoSize = TextFieldAutoSize.LEFT;
		countInText.borderColor = 0xFFFFFF;
		countInText.defaultTextFormat = tF;
		
		
		
		//textSprite.addChild(countInText);
		this.addChild(countInText);
	}
	public function beat():Void { }
	public function upBeat():Void { }
	public function redraw():Void { }
	public function countIn(value:Int):Void {
		
		//visual.alpha = 0;
		
		countInText.text = Std.string(value);
		countInText.x = w / 2 - countInText.textWidth / 2;
		countInText.y = h / 2 - countInText.textHeight / 2;
		countInText.alpha = 0;
		Actuate.tween(countInText, 0.2, { alpha:1 } ).reverse(true);
	}
	
	public function resize(_w:Float, _h:Float):Void {
		
		w = _w;
		h = _h;
		//show();
		redraw();
	}
	public function setVisual(settings:VisualSettingsVO):Void {
		
		visualColor = settings.color;
		visualBeatSize = settings.beatSize;
		visualUpbeatSize = settings.upbeatSize;
	}
	
	
}