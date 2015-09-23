package com.zhrz.flex.ui.core.extension
{
	import mx.collections.ArrayCollection;

	public class ExtensionPointManager
	{
		private static var instance:ExtensionPointManager;
		
		public static function getInstance():ExtensionPointManager{
			if(instance == null){
				instance = new ExtensionPointManager();
			}
			return instance;
		}
		
		private var allExtensionPoint:ArrayCollection = new ArrayCollection();
		private var extensionPointMap:Object = new Object();
		
		public function addExtensionPoint(vo:ExtensionPointVo):void{
			if(!isExist(vo)){
				allExtensionPoint.addItem(vo);
				extensionPointMap[vo.id] = vo;
			}
		}
		
		public function addExtension(extension:ExtensionVo,extensionPointId:String):void{
			var extensionPoint:ExtensionPointVo = extensionPointMap[extensionPointId] as ExtensionPointVo;
			if(extensionPoint){
				extensionPoint.extensions.addItem(extension);
			}
			else{
				throw new Error("扩展点 【 "+extension.extensionPointId+"】 没有注册");
			}
		}
		
		public function getAllExtensionByExtensionId(extensionId:String):ArrayCollection{
			var extensionPoint:ExtensionPointVo = extensionPointMap[extensionId] as ExtensionPointVo;
			if(extensionPoint) return extensionPoint.extensions;
			else{
				throw new Error("扩展点 【 "+extensionId+"】 没有注册");
			}
		}
		
		private function isExist(vo:ExtensionPointVo):Boolean{
			if(extensionPointMap[vo.id] != null) return true;
			else return false;
		}
		
	}
}