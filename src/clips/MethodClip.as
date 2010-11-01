package clips {
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.*;
	
	public class MethodClip extends MovieClip {
		
		public static var methodItems:Vector.<MethodItem> = new Vector.<MethodItem>();
		
		private static var itemHeight:int = 29;
		private static var startY:int = 29;
		
		public static var instance:MethodClip;
		
		public function MethodClip() {
			super();
			instance = this;
			
			newMethod_btn.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(e:MouseEvent):void {
			var item:MethodItem = new MethodItem();			
			methodItems.push(addChild(item));
			
			resize();
		}
		
		public static function resize():void {
			var totalItems:int = 0;
			var totalSubItems:int = 0;
			
			for (var i in methodItems) {
				totalItems++;
				var item:MethodItem = methodItems[i];
				item.y = (totalItems + totalSubItems) * startY;				
				
				var subItemOnly:int = 1;
				//# Loop through method parameters...
				for (var j in item.methodParameters) {
					totalSubItems++;
					var subItem:MethodParameterItem = item.methodParameters[j];
					subItem.y = subItemOnly * startY;
					subItemOnly++;
					
				}
				
				
			}
			totalItems++;
			instance.newMethod_btn.y = (totalItems + totalSubItems) * itemHeight;
			
			Main.scrollPane.update();
			
		}
		
	}
}