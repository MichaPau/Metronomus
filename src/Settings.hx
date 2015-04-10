package;
import flash.net.SharedObject;
import haxe.Json;

/**
 * ...
 * @author MichaPooh
 */
class Settings
{

	private static var defaultJson:Dynamic = {
		"saves": [
			{
				"name": "Simple Tick 80",
				"pattern": "1",
				"speed": "80",
				"changeSpeedFlag": false,
				"changeSpeed": "0",
				"changeMeasures": "0",
				"countInFlag": false,
				"sound1Name": "hihat01.ogg",
				"sound2Name": "hihat01.ogg"
			},
			{
				"name": "3/4 104",
				"pattern": "122",
				"speed": "104",
				"changeSpeedFlag": false,
				"changeSpeed": "0",
				"changeMeasures": "0",
				"countInFlag": false,
				"sound1Name": "clav01.ogg",
				"sound2Name": "metronome01.ogg"
			}],
			
			"visualSettings": {
				"color": 0xFF0000,
				"upbeatSize": 100,
				"beatSize": 50
			}
	};
	public static var jsonObject:Dynamic;
	public static var beatOptions:Array<Array<Dynamic>>;
	public static var visualSettingsVO:VisualSettingsVO;
	
	private function new() 
	{
		
	}
	
	public static function loadData():Array<Array<Dynamic>> {
		
		var so:SharedObject = SharedObject.getLocal("userBeatData");
		//trace(so.data.jsonString);
		if(so.data.jsonString == null) {
			
			trace("no data in so");
			var jStr:String = Json.stringify(Settings.defaultJson);
			so.data.jsonString = jStr;
			so.flush();
			Settings.jsonObject = Json.parse(jStr);
		} else {
			trace(so.data.jsonString);
			Settings.jsonObject = Json.parse(so.data.jsonString);
			
		}
		
		beatOptions = Settings.makeOptions();
		
		visualSettingsVO = new VisualSettingsVO();
		visualSettingsVO.color = Settings.jsonObject.visualSettings.color;
		visualSettingsVO.upbeatSize = Settings.jsonObject.visualSettings.upbeatSize;
		visualSettingsVO.beatSize = Settings.jsonObject.visualSettings.beatSize;
		
		//return Settings.makeOptions();
		return null;
		
	}
	
	public static function saveVisualSettings(vo:VisualSettingsVO):Void {
		
		Settings.jsonObject.visualSettings.color = vo.color;
		Settings.jsonObject.visualSettings.upbeatSize = vo.upbeatSize;
		Settings.jsonObject.visualSettings.beatSize = vo.beatSize;
		
		Settings.flushData();
	}
	public static function addItem(item:Dynamic):Array<Array<Dynamic>> { 
		
		var found:Bool = false;
		for(i in 0...Settings.jsonObject.saves.length) {
			
			if(Settings.jsonObject.saves[i].name == item.name) {
				Settings.jsonObject.saves[i] = item;
				found = true;
				break;
				
			}
		}
		if(!found)
			Settings.jsonObject.saves.push(item);
		
		Settings.flushData();
		
		beatOptions = Settings.makeOptions();
		
		return null;
		//return Settings.makeOptions();
	}
	
	private static function makeOptions():Array<Array<Dynamic>> {
		var ret:Array<Array<Dynamic>> = new Array();
		
		for(i in 0...Settings.jsonObject.saves.length) {
			
			ret.push([Settings.jsonObject.saves[i].name, Settings.jsonObject.saves[i].name]);
		}
		 return ret;
		
	}
	private static function flushData():Void {
		var so:SharedObject = SharedObject.getLocal("userBeatData");
		so.data.jsonString = Json.stringify(Settings.jsonObject);
		so.flush();
		
	}
	public static function deleteItem(name:String):Array<Array<Dynamic>> {
		
		for(i in 0...Settings.jsonObject.saves.length) {
			
			if(Settings.jsonObject.saves[i].name == name) {
				Settings.jsonObject.saves.splice(i, 1);
				break;
				
			}
		}
		Settings.flushData();
		
		beatOptions = Settings.makeOptions();
		//return Settings.makeOptions();
		return null;
	}
	
	public static function getItemForName(name:String):Dynamic {
		
		if (Settings.jsonObject.saves != null) {
			for (i in 0...Settings.jsonObject.saves.length) {
				if(Settings.jsonObject.saves[i].name == name) {
					
					return Settings.jsonObject.saves[i];
				}
			}
		}
		return null;
	}
	
}