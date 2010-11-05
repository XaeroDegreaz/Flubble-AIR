package clips {
	import flash.display.MovieClip;
	
	import flash.events.*;
	import flash.net.*;
	import flash.display.*;
	
	public class MethodParameterItem extends MovieClip {
		
		public function MethodParameterItem() {
			super();
			
			remove_btn.addEventListener(MouseEvent.CLICK, onMouseClick);
			paramType_txt.addEventListener(KeyboardEvent.KEY_UP, Main.startClassFilter);
			
			paramName_txt.addEventListener(MouseEvent.MOUSE_DOWN, function(e:Event):void {
				if(paramName_txt.text = "_parameterName_txt") {
					paramName_txt.text = "";
				}
			});
			
			paramType_txt.addEventListener(MouseEvent.MOUSE_DOWN, function(e:Event):void {
				if(paramType_txt.text = "_parameterType_txt") {
					paramType_txt.text = "";
				}
			});
		}
		
		private function onMouseClick(e:MouseEvent):void {
			var index:int = MethodItem(this.parent).methodParameters.indexOf(this);
			MethodItem(this.parent).methodParameters.splice(index, 1);
			MethodClip.resize();
			this.parent.removeChild(this);
		}
		
	}
}