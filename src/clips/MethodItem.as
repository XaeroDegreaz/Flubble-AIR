package clips {
	import flash.display.MovieClip;
	
	import flash.events.*;
	import flash.net.*;
	import flash.display.*;
	
	public class MethodItem extends MovieClip {
		
		public var methodParameters:Vector.<MethodParameterItem> = new Vector.<MethodParameterItem>();
		
		private static var itemHeight:int = 29;
		private static var startY:int = 29;
		
		public var instance:MethodItem;
		
		public function MethodItem() {
			super();
			instance = this;
			
			newParam_btn.addEventListener(MouseEvent.CLICK, onMouseClick);
			remove_btn.addEventListener(MouseEvent.CLICK, onRemoveBtnClick);
			returnType_txt.addEventListener(KeyboardEvent.KEY_UP, Main.startClassFilter);
		}
		
		private function onMouseClick(e:MouseEvent):void {
			var item:MethodParameterItem = new MethodParameterItem();			
			methodParameters.push(addChild(item));
			
			MethodClip.resize();
		}
		
		private function onRemoveBtnClick(e:MouseEvent):void {
			var index:int = MethodClip.methodItems.indexOf(this);
			MethodClip.methodItems.splice(index, 1);
			MethodClip.resize();
			this.parent.removeChild(this);
		}
		
	}
}