import com.zhrz.flex.ui.core.plugin.PluginXmlVo;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.core.FlexGlobals;
import mx.events.FlexEvent;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.rpc.http.HTTPService;

private var productName:String;
private var httpService:HTTPService;

protected function doInit(event:FlexEvent):void
{
	// TODO Auto-generated method stub
	//Alert.show("fdg胜多负少分数飞");
	
	getPluginInfo();
	
}

private function getPluginInfo():void{
	
	httpService = new HTTPService();
	httpService.addEventListener(ResultEvent.RESULT,onResult);
	httpService.addEventListener(FaultEvent.FAULT,onFault);
	httpService.resultFormat = "xml";
//	httpService.contentType="application/xml";
	httpService.url  = "http://127.0.0.1:8080/fceditorServer/getAllPluginInfo";
	httpService.send();
}

private function onResult(event:ResultEvent):void{
	//Alert.show("tt:"+""+event.result);
	var xml:XML = new XML(""+event.result);
	trace(xml);
	var resultXmllist:XMLList = xml.result;
	var pluginVos:ArrayCollection = new ArrayCollection();
	for(var i:int = 0 ; i < resultXmllist.length();i++){
		var resultXml:XML = resultXmllist[i];
		var pluginXmllist:XMLList = resultXml.children();
		var fceditorPlugin:PluginXmlVo = new PluginXmlVo();
		pluginVos.addItem(fceditorPlugin);
		for(var j:int = 0; j < pluginXmllist.length();j++){
			var plugInxml:XML = pluginXmllist[j];
			if(plugInxml.localName() == "pluginId"){
				fceditorPlugin.pluginId = ""+plugInxml.text();
			}
			if(plugInxml.localName() == "content"){
				fceditorPlugin.xmlContent = ""+plugInxml.text();
			}
		}
	}
	
	var projectFile:File = new File(File.applicationDirectory.resolvePath("project.xml").nativePath);
	var fileStream:FileStream = new FileStream();
	fileStream.open(projectFile,FileMode.READ);
	var projectXml:XML = new XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
	fileStream.close();
	
	this.initApp(pluginVos,""+projectXml.proectName,""+projectXml.pluginBaseDir);
}

private function onFault(event:FaultEvent):void{
	Alert.show("error");
}