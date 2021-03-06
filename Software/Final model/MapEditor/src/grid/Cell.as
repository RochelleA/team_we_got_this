package grid
{
	
	import spark.components.supportClasses.SkinnableComponent;
	import spark.primitives.Rect;
		
	[Style(name="side", inherit="no", type="int")]
	public class Cell extends SkinnableComponent implements ICell
	{
		protected var _type:String;
		protected var _prevType:String;
		
		private var _temp:Boolean;
		
		private var _xPos:int, _yPos:int;
		
		private var _debugType:String;
		
		[SkinState("normal")]
		[SkinState("temp")]
		
		[SkinPart(required="true")]
		public var transparentFillRect:Rect;
		[SkinPart(required="false")]
		public var solidFillRect:Rect;
		[SkinPart(required="false")]
		public var bitmapFillRect:Rect;
		
		public function Cell(x:int, y:int)
		{
			super();
			this._xPos = x;
			this._yPos = y;
			setDefaultStyles();			
		}
		
		private function setDefaultStyles():void{
			this.setStyle("skinClass",CellSkin);
			this.setStyle("side", 20);
			this.setStyle("strokeColour", 0xaaaaaa);
			this.setFill(null, null);
		}

		/**
		 * Use this function to set fills.
		 */
		protected function setFill(solidFillColour:* = null, bitmapFill:* = null):void{
			if(solidFillColour != null){
				this.setStyle("isSolidFill", true);
				this.setStyle('solidFill', solidFillColour);
			}else{
				this.setStyle("isSolidFill", false);
			}
			
			if(bitmapFill != null){
				this.setStyle("isBitmapFill", true);
				this.setStyle("bitmapFill", bitmapFill);
			}else{
				this.setStyle("isBitmapFill", false);
			}

		}
		
		override public function toString():String{
			return "("+_xPos+":"+_yPos+")";
		}
		
		private function position():void{
			this.move(_xPos*this.getStyle("side"),_yPos*this.getStyle("side"));
		}
		
		/**
		 * Override to change side
		 */
		override public function setStyle(styleProp:String, newValue:*):void{
			super.setStyle(styleProp, newValue);
			if(styleProp == "side"){
				position();
			}
		}
				
		override protected function getCurrentSkinState():String
		{
			var s:String = "";
			if(this._temp){
				s = "temp";
			}else{
				s = "normal";
			}
			return s;
		} 
		
		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

//		public function get temp():Boolean
//		{
//			return _temp;
//		}

		private function set temp(value:Boolean):void
		{
			_temp = value;
			this.invalidateSkinState();
		}

		public function get yPos():int
		{
			return _yPos;
		}

		public function get xPos():int
		{
			return _xPos;
		}
		
		/**
		 * If cell's type was temporary changed, this method will discard the temporary type.
		 * @see Cell.tempType
		 * @see Cell.confirmNewType()
		 */
		public function restore():void{
			if(this._temp){
				//trace('restore');
				this.type = this._prevType;
				this.temp = false;
			}
		}
		/**
		 * Sets a temporary cell type. It can de discarded using restore() method.
		 * @see Cell.restore()
		 */
		public function set tempType(value:String):void{
			if(value){
				this.temp = true;
				this._prevType = type;
				this.type = value;
			}
			//trace('set temp type', this, _temp);
		}
		/**
		 * Saves the temporary cell's type.
		 * @see Cell.tempType
		 * @see Cell.restore()
		 */
		public function confirmNewType():void
		{
			this.temp = false;
		}

		public function get debugType():String
		{
			return _debugType;
		}

		public function set debugType(value:String):void
		{
			_debugType = value;
		}


	}
}