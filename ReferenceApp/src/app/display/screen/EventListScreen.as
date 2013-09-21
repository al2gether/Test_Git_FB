package app.display.screen
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.skins.StandardIcons;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class EventListScreen extends Screen
	{
		
		private var _meetingDataList:ListCollection;
		
		
		public function EventListScreen()
		{
			super();
		}
		
		override protected function draw():void
		{
			
		}
		
		override protected function initialize():void
		{			
			
		}
		
		
		
		protected function onLoaded(event:flash.events.Event):void
		{
			var obj:Object = JSON.parse(event.target.data);
			_meetingDataList = new ListCollection(obj.meeting);			
			_meetingDataList.addEventListener(starling.events.Event.CHANGE,listChanged);		
		}		
		
		private function listChanged(e:starling.events.Event):void
		{
			dispatchEventWith("listChanged",false,_meetingDataList);			
		}
	}
}