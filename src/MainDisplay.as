package {
	import fl.controls.ComboBox;
	
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
			
		}
		
	}
}