package com.zhrz.flex.ui.core.managers
{
	import mx.collections.ArrayCollection;

	public class ViewInitClientManager
	{
		private static var instance:ViewInitClientManager =  new ViewInitClientManager(); ;
		
		public static function getInstance():ViewInitClientManager{
			return instance;
		}
		
		private var views:ArrayCollection;
		
		public function addViewClient(client:IViewInitClient):void{
			if(views == null){
				views = new ArrayCollection();
			}
			views.addItem(client);
		}
		
		public function notify():void{
			for each(var viewclient:IViewInitClient in views){
				viewclient.onAllInitViewCreateCompleted();
			}
		}
		
		public function clean():void{
			views = null;
		}
	}
}