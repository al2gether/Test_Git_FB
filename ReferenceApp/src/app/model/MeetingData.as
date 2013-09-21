package app.model
{
	public class MeetingData
	{
		private var _title:String;
		private var _startDate:Date;
		private var _endDate:Date;
		private var _typeEvent:String;
		
				
		public function MeetingData(objMeeting:Object)
		{
			if (objMeeting){
				this._title = objMeeting.title;
				this._startDate = new Date(objMeeting._startDate);
				this._endDate = new Date(objMeeting._endDate);
				this._typeEvent = objMeeting.typeEvent;
 			}
		}
	}
}