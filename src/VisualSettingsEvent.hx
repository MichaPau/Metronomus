package;

import openfl.events.Event;

/**
 * ...
 * @author MichaPooh
 */
class VisualSettingsEvent extends Event
{
	
	public var color:Int;
	public var beatSize:Int;
	public var upbeatSize:Int;
	
	public static inline var UPDATE:String = "VisualSettingsEvent_update";
	
	public function new(type:String, bubbles:Bool=false, cancelable:Bool=false) 
	{
		super(type, bubbles, cancelable);
		
	}
	
}