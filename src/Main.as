package {
	import clips.MethodClip;
	import clips.PropertyClip;
	
	import fl.containers.ScrollPane;
	import fl.controls.ComboBox;
	import fl.controls.TextInput;
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.*;
	import flash.net.dns.AAAARecord;
	import flash.ui.Keyboard;
	
	import menu.CustomMenu;
	
	import storage.*;
	
	public class Main extends MovieClip	{
		public static var classes:XML;
		//# Base AS3 classes are stored in this array...
		public static var classArray:Array = new Array();
		//# Perhaps add another array for custom classed that have been created with Flubble?
		// public static var customClassArray:Array = new Array();
		
		public static var imports:Array = new Array();
		
		private static var currentFilterableTextInput:TextInput;
		public static var scrollPane:ScrollPane;
		
		public static var propertyClip:PropertyClip;
		public static var methodClip:MethodClip;
		public static var mainDisplay:MainDisplay;
		
		public static var instance:Main;
		
		public function Main() {
			super();
			this.stage.nativeWindow.menu = new CustomMenu();
			Config.initialize();
			instance = this;
			
			scrollPane = scrollPane_mc;
			
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest("allClasses.xml");
			
			//# TODO, add another request for custom classes created with Flubble.
			
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
			//# Update the display to display the character in the box as quickly as possible for fast typers.....
			e.updateAfterEvent();
				
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
			
			//# Filter through all of the default AS3 classes first..
			filterArray = filterArray.filter(filterClasses);
			
			//# Filter through our custom array of classes that have been created with Flubble
			if(filterArray.length == 0) {
				//# Todo, create filter for custom classes...
			}
			
			//# Get a marker for current text in the text input.
			var begin:int = e.currentTarget.length;					
					
			if(!resetSelection && filterArray.length > 0) {
				//# Set the input text to the first matching class name	
				e.currentTarget.text = filterArray[0].className;
				//# Create a selection so the user can continue to type.
				e.currentTarget.setSelection(begin, e.currentTarget.length);
				
				//# Add or remove an import line
				imports[e.currentTarget.name] = filterArray[0].packageName;
				
				//# If this is a base class, we set the combobox to reflect it, for later comparison when saving our class.
				//var index:int = classArray.indexOf(filterArray[0]);
				//ComboBox(classes_mc).selectedIndex = index;
			}else {
				imports[e.currentTarget.name] = null;
			}
			
		}
		
		private static function filterClasses(element:*, index:int, array:Array):Boolean {			
			return ( String(element.className).indexOf(currentFilterableTextInput.text) == 0 );			
		}
		
	}
}