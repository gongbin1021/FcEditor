package com.zhrz.flex.ui.core.layout
{
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.core.Container;
	import mx.core.IVisualElementContainer;

	public class DefaultLayoutStrategy implements ILayoutStrategy
	{
		
		public function getLayoutAreaVos(parentUi:IVisualElementContainer,layoutXml:XML,extensionId:String):ArrayCollection{
			var results:ArrayCollection = new ArrayCollection();
			
			var parentGroup:Container = createGroup(layoutXml,null,results,extensionId);
			iterateCreate(layoutXml,parentGroup,results,extensionId);
			parentUi.addElement(parentGroup);
			
			return results;
		}
		
		private function getLayoutClass(xml:XML):Class{
			if(xml.localName() == "VBox") return VBox;
			if(xml.localName() == "HBox") return HBox;
			
			return Canvas;
		}
		
		private function createGroup(xml:XML,parent:Container,results:ArrayCollection,extensionId:String):Container{
			var GroupClass:Class = getLayoutClass(xml);
			var group:Container = new GroupClass() as Container;
			group.percentHeight = 100;
			group.percentWidth = 100;
			if(parent)
				parent.addElement(group);
			if(xml.@width != null && xml.@width != "100%"){
				group.width = Number(xml.@width);
			}
			if(xml.@height != null && xml.@height != "100%"){
				if((""+xml.@height).indexOf("%") != -1){
					group.percentHeight =parseFloat((""+xml.@height))
				}
				else{
					group.height = Number(xml.@height);
				}
				
			}
			
			if((xml.@styleName).length() != 0){
				group.styleName = ""+xml.@styleName;
			}
			
			var isSuperTab:Boolean = false;
			if((xml.@superTab).length() != 0){
				isSuperTab = true;
			}
			
			
			if((xml.@verticalGap).length() != 0){
				group.setStyle("verticalGap",parseFloat((""+xml.@verticalGap)));
			}
			if((xml.@id).length() != 0){
				var layoutVo:DefaultLayoutAreaVo = new DefaultLayoutAreaVo();
				layoutVo.id = extensionId+"."+xml.@id+"";
				layoutVo.layoutArea = group;
				layoutVo.isTab = ""+xml.@isTab;
				layoutVo.superTab = isSuperTab;
				results.addItem(layoutVo);
			}
			
			
			
			return group;
			
		}
		
		private function iterateCreate(xml:XML,parent:Container,results:ArrayCollection,extensionId:String):void{
			var xmlList:XMLList =  xml.children();
			var count:int = xmlList.length();
			for(var i:int = 0 ; i < count;i++){
				var child:XML = xmlList[i] as XML;
				var parentGroup:Container = createGroup(child,parent,results,extensionId);
				iterateCreate(child,parentGroup,results,extensionId);
			}
		}
		
	}
}