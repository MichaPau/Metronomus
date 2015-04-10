package;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.core.Root;
import openfl.display.Sprite;
import haxe.ui.toolkit.events.UIEvent;

/**
 * ...
 * @author MichaPooh
 */
class BeatGUI extends Sprite
{

	var w:Float;
	var h:Float;
	var start_btn:Sprite;
	var beatModel:BeatModel;
	
	public function new(_model:BeatModel, _w:Float, _h:Float) {
		super();
		w = _w;
		h = _h;
		
		
		
	}
	
}