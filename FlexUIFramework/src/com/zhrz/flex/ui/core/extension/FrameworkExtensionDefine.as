package com.zhrz.flex.ui.core.extension
{
	public class FrameworkExtensionDefine
	{
		
		private static const PREFX:String = '<plugin id="'+WORKBENCH_PLUGIN_ID+'" name="eclipsePlugin" version="1.0">';	
		private static const SUFFIX:String = "</plugin>";
		private static const PLUGIN_CONTENT:XML = null;

		public static const WORKBENCH_PLUGIN_ID:String = "com.zhrz.eclipse.workbench.plugin";
		
		public static function getWorkbenchPluginConfigXml():String{
			var workbenchExtensionPoints:String = ""+FrameworkExtensionPointDefine.DEFAULT_EXTENSION_POINT_DEFINE;
			
			var workbenchExtensions:String = PLUGIN_CONTENT == null?"":PLUGIN_CONTENT.toString();
			
			return PREFX + workbenchExtensionPoints + workbenchExtensions + SUFFIX;
		}

	}
}