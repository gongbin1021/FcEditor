package  com.zhrz.flex.ui.core.pageLayoutClient
{
	import com.zhrz.flex.ui.core.extension.AbstractExtensionDescriptor;
	
	public class PageLayoutClientDescriptor extends AbstractExtensionDescriptor
	{
		public function PageLayoutClientDescriptor(id:String)
		{
			super(id);
		}
		
		override public function init(xml:XML):void{
			className = xml.@className;
		}
		
		
		public var className:String;
	}
}