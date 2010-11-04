package {
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.*;
	
	import storage.Save;
	
	public class MainDisplay extends MovieClip {
		
		public function MainDisplay() {
			super();
			Main.mainDisplay = this;
			superClass_txt.addEventListener(KeyboardEvent.KEY_UP, Main.startClassFilter);
			
			renderAsXML_btn.addEventListener(MouseEvent.CLICK, onRenderXMLClick);
			renderAsAS3_btn.addEventListener(MouseEvent.CLICK, onRenderAS3Click);
		}
		
		private function onRenderXMLClick(e:MouseEvent):void {
			Save.save( Save.AsXML() );
		}
		
		private function onRenderAS3Click(e:MouseEvent):void {
			Save.save( Save.AsAS3() );
		}
		
	}
}