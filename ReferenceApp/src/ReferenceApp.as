package
{
	import com.renaun.core.StarlingMobileMainSprite;
	
	import app.controller.MainDispCtrl;
	
	
	[SWF(width="640",height="1136",frameRate="60",backgroundColor="#424254")]
	public class ReferenceApp  extends StarlingMobileMainSprite
	{
		public function ReferenceApp()
		{
			super(MainDispCtrl);
		}
	}
}