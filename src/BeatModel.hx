package;
import openfl.media.Sound;

/**
 * ...
 * @author MichaPooh
 */
class BeatModel
{
	public var speed(default, set):Int;
	public var speed2(default, set):Int;
	public var patternStr:String;
	public var timerSpeed:Int;
	public var countInFlag:Bool;
	public var changeSpeedFlag:Bool;
	public var changeSpeedCount:Int;
	public var timerSpeed2:Int;
	public var upbeat:Sound;
	public var beat:Sound;
	
	public function new() 
	{
		
	}
	
	private function set_speed(value:Int):Int {
		
		timerSpeed = Std.int(60000 / value);
		return speed = value;
	}
	
	private function set_speed2(value:Int):Int {
		
		timerSpeed2 = Std.int(60000 / value);
		return speed2 = value;
	}
	
	
	
}