package {
	import flash.display.MovieClip;
	
	import flash.events.*;
	import flash.net.*;
	import flash.display.*;
	
	public class MainDisplay extends MovieClip {
		
		public function MainDisplay() {
			super();
			superClass_txt.addEventListener(KeyboardEvent.KEY_UP, Main.startClassFilter);
		}
		
	}
}