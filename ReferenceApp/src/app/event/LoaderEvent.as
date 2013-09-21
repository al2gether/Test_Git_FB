package app.event
{
	import flash.events.Event;
	
	public class LoaderEvent extends Event
	{
		public function LoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}