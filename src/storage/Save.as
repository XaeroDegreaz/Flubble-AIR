package storage {
	import clips.*;
	
	import com.adobe.air.filesystem.FileUtil;
	import com.adobe.serialization.json.*;
	
	import fl.controls.ComboBox;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.*;
	import flash.utils.Dictionary;
	
	public class Save {
		
		public static function AsXML()	{
			trace("**** OUTPUTTING XML FORMATTED CLASS INFORMATION ****\n");
			var out:String = "<?out version='1.0' encoding='UTF-8'?>";
			out += "<file>";
			out += "<package name='"+Main.mainDisplay.packageName_txt.text+"'/>";
			out += "<class name='"+Main.mainDisplay.className_txt.text+"' visibility='"+Main.mainDisplay.visibility_mc.selectedItem.data+"'/>";
			out += "<superclass type='"+Main.mainDisplay.superClass_txt.text+"'/>";
			
			out += "<classFunctions>";
			//# Loop through class methods...
			for each(var item:MethodItem in MethodClip.methodItems) {
				out += "<function name='"+item.methodName_txt.text+"' visibility='"+ComboBox(item.visibility_mc).selectedItem.data+"' returnType='"+item.returnType_txt.text+"'>";
				
				//# Loop through method parameters..
				for each(var param:MethodParameterItem in item.methodParameters) {
					out += "<parameter name='"+param.paramName_txt.text+"' type='"+param.paramType_txt.text+"'/>";
				}
				
				out += "</function>";
				
			}
			
			out += "</classFunctions>";
			
			out += "<variables>";
			//# Loop through class properties...
			for each(var item2:PropertyItem in PropertyClip.propertyItems) {
				out += "<variable name='"+item2.propertyName_txt.text+"' visibility='"+ComboBox(item2.visibility_mc).selectedItem.data+"' type='"+item2.propertyType_txt.text+"'></variable>";
			}
			out += "</variables>";
			
			out += "</file>";
			
			trace(XML(out).toXMLString());
			save(XML(out).toXMLString(), "xml");
		}
		
		public static function AsAS3()	{
			trace("**** OUTPUTTING ACTIONSCRIPT 3 CLASS FILE ****\n");
			var out:String = "package "+Main.mainDisplay.packageName_txt.text+" {\n\n";
			
			//# Import line loops should go here later...
			out += removeDuplicateImports().join("")+"\n";
			
			//# Check for super class
			var extendsLine:String = "";
			if(Main.mainDisplay.superClass_txt.text != "") {
				extendsLine = " extends "+Main.mainDisplay.superClass_txt.text+"";
			}
			
			out += "\t"+Main.mainDisplay.visibility_mc.selectedItem.data+" class "+Main.mainDisplay.className_txt.text+""+extendsLine+" {\n\n";
			
			//# Class properties..
			//# Loop through class properties...
			for each(var item2:PropertyItem in PropertyClip.propertyItems) {
				out += "\t\t"+ComboBox(item2.visibility_mc).selectedItem.data+" "+item2.propertyName_txt.text+":"+item2.propertyType_txt.text+";\n";
			}
			out += "\n";
			
			//# Class constructor..
			out += "\t\t"+Main.mainDisplay.visibility_mc.selectedItem.data+" function "+Main.mainDisplay.className_txt.text+"() {\n";
			out += "\t\t\tsuper();\n";
			out += "\t\t}\n\n";
			
			//# Class methods..
			for each(var item:MethodItem in MethodClip.methodItems) {
				
				//# Loop through method parameters..
				var parameters:Array = new Array();
				for each(var param:MethodParameterItem in item.methodParameters) {
					parameters.push(param.paramName_txt.text+":"+param.paramType_txt.text);
				}
				
				//# Method declaration
				out += "\t\t"+ComboBox(item.visibility_mc).selectedItem.data+" function "+item.methodName_txt.text+"("+parameters.toString()+"):"+item.returnType_txt.text+" {\n";
				
				//# Dont forget return line in here...
				if(item.returnType_txt.text != "void") {
					out += "\t\t\treturn new "+item.returnType_txt.text+"();\n";
				}
				
				out += "\t\t}\n\n";
				
			}
			
			//# Close class
			out += "\t}\n";
			//# Close package
			out += "}";
			
			
			trace(out);	
			save(out, "as");
		}
		
		private static function save(data:*, type:String):void {
			//# Initialize the config, just in case they decided not to save it before...
			Config.initialize();
			
			var packageDirs:String = String(Main.mainDisplay.packageName_txt.text).split(".").join("/");
			var className:String = String(Main.mainDisplay.className_txt.text);
			
			var file:File = new File(Config[type+"SaveDir"].nativePath+"/"+packageDirs+"/"+className+"."+type);
			var fs:FileStream = new FileStream();
			
			fs.open(file, FileMode.WRITE);
			fs.writeUTFBytes(data);
			fs.close();
			
		}
		
		private static function removeDuplicateImports():Array {
			var testArray:Array = new Array();
			var out:Array = new Array();
			
			for each(var importItem:String in Main.imports) {
				if(!testArray[importItem]) {
					testArray[importItem] = true;
					out.push("\timport "+importItem+".*;\n");
				}
			}
			
			return out;
		}
		
	}
}