package storage {
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.*;
	import flash.net.dns.AAAARecord;
	
	public class Config {
		
		public static var baseDir:File;
		public static var asSaveDir:File;
		public static var xmlSaveDir:File;
		public static var jsonSaveDir:File;
		private static var configXML:XML;
		
		public static function initialize():void {
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(File.applicationStorageDirectory.nativePath+"/config.xml");
			
			loader.addEventListener(Event.COMPLETE, onLoad);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			loader.load(request);
		}
		
		private static function onLoadError(e:IOErrorEvent):void {
			trace("**** CONFIG FILE NOT FOUND ****");
			var file:File = new File(File.applicationStorageDirectory.nativePath+"/config.xml");
			var fs:FileStream = new FileStream();
			
			fs.open(file, FileMode.WRITE);
			fs.writeUTFBytes("<config><baseSaveDir></baseSaveDir></config>");
			fs.close();
			
			trace("**** INITIAL CONFIG FILE WRITTEN ****");			
			initialize();
		}
		
		
		private static function onLoad(e:Event):void {
			configXML = XML(e.target.data);
			
			if(configXML.baseSaveDir == "") {
				baseDir = new File(File.documentsDirectory.nativePath+"/Flubble-AS3");
				baseDir.browseForDirectory("Please select a location in which to save Flubble-AS3 projects, generated classes, XML, JSON, etc.");
				
				baseDir.addEventListener(Event.SELECT, generateBaseDir);
			}else {
				trace("**** CONFIG LOADED, GENERATING DIRECTORIES WHERE NEEDED ****");
				
				baseDir = new File(configXML.baseSaveDir+"/Flubble-AS3");
				baseDir.createDirectory();
				
				asSaveDir = new File(baseDir.nativePath+"/AS3");
				asSaveDir.createDirectory();
				
				xmlSaveDir = new File(baseDir.nativePath+"/XML");
				xmlSaveDir.createDirectory();
				
				jsonSaveDir = new File(baseDir.nativePath+"/JSON");
				jsonSaveDir.createDirectory();
			}
		}
		
		private static function generateBaseDir(e:Event):void {
			var selectedFolder:File = File(e.target);
			var file:File = new File(File.applicationStorageDirectory.nativePath+"/config.xml");
			var fs:FileStream = new FileStream();
			
			trace("**** GENERATING DIRECTORIES ****");
			
			baseDir = new File(selectedFolder.nativePath+"/Flubble-AS3");
			baseDir.createDirectory();
			
			asSaveDir = new File(baseDir.nativePath+"/AS3");
			asSaveDir.createDirectory();
			
			xmlSaveDir = new File(baseDir.nativePath+"/XML");
			xmlSaveDir.createDirectory();
			
			jsonSaveDir = new File(baseDir.nativePath+"/JSON");
			jsonSaveDir.createDirectory();			
			
			//# Update our XML object.
			configXML.baseSaveDir = selectedFolder.nativePath;
			
			//# Update the actual XML file
			fs.open(file, FileMode.WRITE);
			fs.writeUTFBytes(configXML.toXMLString());
			fs.close();
			
			trace("**** CONFIGURATION FILE UPDATED ****");
		}
		
	}
}