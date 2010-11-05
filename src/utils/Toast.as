package utils {
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	
	public class Toast extends MovieClip {
		
		private var instance:Toast;
		private var fadeTime:Number;
		
		public function Toast(message:String, fadeTime:Number = 3) {
			instance = this;
			this.fadeTime = fadeTime;
			
			message_txt.autoSize = "center";
			message_txt.wordWrap = false;
			
			message_txt.text = message;			
			bg_mc.width = message_txt.width + 100;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void {
			this.x = stage.width / 2;
			this.y = stage.height / 2;
			
			TweenMax.to(this, fadeTime, {alpha: 0, ease: Linear.easeNone,
				onComplete: function(e:Event = null):void {
					instance.parent.removeChild(instance);
				}
			});
		}
		
	}
}