package clips {
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.*;
	
	public class PropertyItem extends MovieClip {
		
		public function PropertyItem() {
			super();
			
			remove_btn.addEventListener(MouseEvent.CLICK, onMouseClick);
			propertyType_txt.addEventListener(KeyboardEvent.KEY_UP, Main.startClassFilter);
			
			propertyType_txt.addEventListener(MouseEvent.MOUSE_DOWN, function(e:Event):void {
				if(propertyType_txt.text = "_propertyType") {
					propertyType_txt.text = "";
				}
			});
			
			propertyName_txt.addEventListener(MouseEvent.MOUSE_DOWN, function(e:Event):void {
				if(propertyName_txt.text = "_propertyName") {
					propertyName_txt.text = "";
				}
			});
			
		}
		
		private function onMouseClick(e:MouseEvent):void {
			var index:int = PropertyClip.propertyItems.indexOf(this);
			PropertyClip.propertyItems.splice(index, 1);
			PropertyClip.resize();
			this.parent.removeChild(this);
		}
		
	}
}