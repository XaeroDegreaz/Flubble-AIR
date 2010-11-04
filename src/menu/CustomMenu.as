package menu {
	import flash.display.*;
	import flash.display.NativeMenu;
	import flash.events.*;
	import flash.net.*;
	
	import storage.*;
	
	public class CustomMenu extends NativeMenu {
		
		public static var file:NativeMenuItem = new NativeMenuItem("File");
		public static var view:NativeMenuItem = new NativeMenuItem("View");
		public static var tools:NativeMenuItem = new NativeMenuItem("Tools");
		
		public function CustomMenu() {
			super();
			this.addItem(file);
			this.addItem(view);
			this.addItem(tools);
			
			file.submenu = new NativeMenu();
			var file_save:NativeMenuItem = file.submenu.addItem( new NativeMenuItem("Save") );
			var file_open:NativeMenuItem = file.submenu.addItem( new NativeMenuItem("Open Project...") );
			
			file_save.submenu = new NativeMenu();
			var file_save_as3:NativeMenuItem = file_save.submenu.addItem( new NativeMenuItem("AS3") );
			var file_save_xml:NativeMenuItem = file_save.submenu.addItem( new NativeMenuItem("XML") );
			
			view.submenu = new NativeMenu();
			var view_live:NativeMenuItem = view.submenu.addItem( new NativeMenuItem("Live Preview") );
			
			tools.submenu = new NativeMenu();
			var tools_pastebin:NativeMenuItem = tools.submenu.addItem( new NativeMenuItem("Pastebin") );
			
			tools_pastebin.submenu = new NativeMenu();
			var tools_pastebin_as3:NativeMenuItem = tools_pastebin.submenu.addItem( new NativeMenuItem("ActionScript3") );
			tools_pastebin_as3.name = "AS3";
			
			var tools_pastebin_xml:NativeMenuItem = tools_pastebin.submenu.addItem( new NativeMenuItem("XML") );
			tools_pastebin_xml.name = "XML";
			
			tools_pastebin_xml.addEventListener(Event.SELECT, onPastebinSelect);
			tools_pastebin_as3.addEventListener(Event.SELECT, onPastebinSelect);
		}
		
		private function onPastebinSelect(e:Event):void {		
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest("http://www.pastebin.com/api_public.php");
			var vars:URLVariables = new URLVariables();
			
			request.method = URLRequestMethod.POST;
			request.data = vars;
			
			vars.paste_code = Save["As"+e.target.name]().data;
			vars.paste_format = e.target.label;
			
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.load(request);
			
			function onComplete(ev:Event) {
				trace(ev.target.data);
			}
		}
		
	}
}