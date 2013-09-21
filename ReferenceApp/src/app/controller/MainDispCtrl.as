package app.controller
{
	import com.renaun.controls.RelativePositionLayoutManager;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import app.theme.SerendipiTheme;
	
	import feathers.core.FeathersControl;
	import feathers.data.ListCollection;
	import feathers.motion.transitions.OldFadeNewSlideTransitionManager;
	
	import starling.events.Event;
	
	public class MainDispCtrl extends FeathersControl
	{
		private var _theme:SerendipiTheme;
		private var _meetingDataList:ListCollection;
		private var _positionManager:RelativePositionLayoutManager;		
		private var _transitionManager:OldFadeNewSlideTransitionManager;
		//private var loader:Loader;
		private var loader:URLLoader;
		
		
		
		public function MainDispCtrl()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler():void
		{
			_theme = new SerendipiTheme();	
			_positionManager = new RelativePositionLayoutManager(this);		
			initializeData();
						
		}
		
		private function addChildToStage():void
		{
			trace(_meetingDataList);
			if (_meetingDataList){
				for each (var item:Object in _meetingDataList){
					createRenderItem(item);
				}			
			}
			/*var container:ScrollContainer = new ScrollContainer();
			this.addChild( container );
			
			var button:Button = new Button();
			button.label = "Anchored Button";
			container.addChild( button );
			
			container.layout = new VerticalLayout();
			
			var quad:Quad = new Quad(100, 100, 0x1E7FCB);
			quad.alpha = 0.3;
			this.addChild(quad);
			quad.
			var button:Button = new Button();
			button.label = "Anchored Button";
			quad.addChild( button );
			
			
			var layoutData:AnchorLayoutData = new AnchorLayoutData();
			layoutData.left = 10;
			layoutData.right = 10;
			layoutData.bottom = 10;
			button.layoutData = layoutData;
			
			var button2:Button = new Button();
			button2.label = "Another Button";
			container.addChild( button2 );
			
			var layoutData2:AnchorLayoutData = new AnchorLayoutData();
			layoutData2.left = 10;
			layoutData2.right = 10;
			layoutData2.bottom = 10;
			layoutData2.bottomAnchorDisplayObject = button;
			layoutData2.top = 10;
			button2.layoutData = layoutData2;
			*/
		}
		
		private function createRenderItem(meeting:Object):void
		{
			trace(meeting);
		}
		
		private function initializeData():void
		{
			loader = new URLLoader();	
			
			///configureListeners(loader.contentLoaderInfo);
			configureListeners(loader);
			var request:URLRequest = new URLRequest("/app/model/calline.json");
			try {
				loader.load(request);
			} catch (error:Error) {
				trace("Unable to load requested document.");
			}	
			
		}
		
		private function configureListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(flash.events.Event.COMPLETE, onLoaded,false,0,true);			
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);			
		}	
		
		private function onLoaded(event:flash.events.Event):void
		{
			loader.removeEventListener(flash.events.Event.COMPLETE,onLoaded);
			var obj:Object = JSON.parse(loader.data);			
			_meetingDataList = new ListCollection(obj.meeting);			
			_meetingDataList.addEventListener(starling.events.Event.CHANGE,listChanged);
			addChildToStage();	
		}	
		
		private function listChanged(e:starling.events.Event):void
		{
			dispatchEventWith("listChanged",false,_meetingDataList);			
		}
		
		
		private function progressHandler(event:ProgressEvent):void {
			trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		private function httpStatusHandler(event:HTTPStatusEvent):void {
			trace("httpStatusHandler: " + event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}


	}
}