package clips {
	import fl.containers.ScrollPane;
	
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Point;
	import flash.net.*;
	
	public class PropertyClip extends MovieClip {
		
		public static var propertyItems:Vector.<PropertyItem> = new Vector.<PropertyItem>();
		
		private static var itemHeight:int = 29;
		private static var startY:int = 29;
		
		public static var instance:PropertyClip;
		
		public function PropertyClip() {
			super();
			instance = this;
			
			newProperty_btn.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(e:MouseEvent):void {
			var item:PropertyItem = new PropertyItem();			
			propertyItems.push(addChild(item));
			
			resize();
		}
		
		public static function resize():void {
			
			for (var i in propertyItems) {
				var item:PropertyItem = propertyItems[i];
				item.y = (i + 1) * startY;				
			}
			
			instance.newProperty_btn.y = (propertyItems.length + 1) * itemHeight;
			
			var point:Point = new Point(instance.newProperty_btn.x, instance.newProperty_btn.y);
			var point2:Point = instance.localToGlobal(point);
			
			MethodClip.instance.y = point2.y + 40;
			
			Main.scrollPane.update();
			
		}
		
	}
}