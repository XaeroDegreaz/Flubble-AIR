package {
	import fl.containers.ScrollPane;
	import fl.controls.ComboBox;
	import fl.controls.TextInput;
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.*;
	import flash.ui.Keyboard;
	
	public class Main extends MovieClip	{
		public static var classes:XML;
		public static var classArray:Array = new Array();
		
		private static var currentFilterableTextInput:TextInput;
		public static var scrollPane:ScrollPane;
		
		public function Main() {
			super();
			scrollPane = scrollPane_mc;
			
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest("allClasses.xml");
			
			loader.addEventListener(Event.COMPLETE, onClassesLoadComplete);			
			loader.load(request);
		}
		
		private function onClassesLoadComplete(e:Event):void {
			classes = XML(e.target.data);
			
			for each(var item in classes.children()) {
				//# Add the items to the ComboBox
				//classes_mc.addItem({label: item, data: item.@p});
				
				//# Store them in an array also for our filter text function..
				classArray.push({className: item, packageName: item.@p});
			}
		}
		
		public static function startClassFilter(e:KeyboardEvent):void {
			//# This variable controls whether or not to begin a selection while typing..
			var resetSelection:Boolean = false;
			
			//# Ignore shift key
			if(e.charCode == 0) {
				return;
			}
			
			//# If it's the backspace key then do not make a selection
			if(e.charCode == 8) {
				resetSelection = true;
			}
			
			//# Create filter array so we don't overwrite our classArray
			var filterArray:Array = classArray;
			
			//# Retrieve filtered class names
			currentFilterableTextInput = e.currentTarget;
			filterArray = filterArray.filter(filterClasses);	
			
			//# Get a marker for current text in the text input.
			var begin:int = e.currentTarget.length;					
					
			if(!resetSelection && filterArray.length > 0) {
				//# Set the input text to the first matching class name	
				e.currentTarget.text = filterArray[0].className;
				//# Create a selection so the user can continue to type.
				e.currentTarget.setSelection(begin, e.currentTarget.length);
				
				//# If this is a base class, we set the combobox to reflect it, for later comparison when saving our class.
				//var index:int = classArray.indexOf(filterArray[0]);
				//ComboBox(classes_mc).selectedIndex = index;
			}		
			
		}
		
		private static function filterClasses(element:*, index:int, array:Array):Boolean {			
			return ( String(element.className).indexOf(currentFilterableTextInput.text) == 0 );			
		}
		
	}
}