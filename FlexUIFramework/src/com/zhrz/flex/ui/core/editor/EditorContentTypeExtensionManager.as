package com.zhrz.flex.ui.core.editor
{
	public class EditorContentTypeExtensionManager
	{
		private static var instance:EditorContentTypeExtensionManager;
		
		public static function getInstance():EditorContentTypeExtensionManager{
			if(instance == null){
				instance = new EditorContentTypeExtensionManager();
			}
			
			return instance;
		}
		
		private var extension:EditorContentTypeExtension;
		
		public function getExtension():EditorContentTypeExtension{
			if(extension == null){
				extension = new EditorContentTypeExtension();
				extension.beginParse();
			}
			return extension;
		}
	}
}