package;

/**
 * @author MichaPooh
 */

interface IBeatVisual 
{
	function show():Void;
	function beat():Void;
	public function upBeat():Void;
	function countIn(value:Int):Void;
	function resize(_w:Float, _h:Float):Void;
	function setVisual(settings:VisualSettingsVO):Void;
	function redraw():Void;
}