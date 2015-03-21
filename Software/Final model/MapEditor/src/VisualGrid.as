package
{	
	import spark.components.Group;
	
	public class VisualGrid extends Group implements ITrafficGrid
	{
		protected var _cells:Array;
		protected var _trafficLights:Array;
		protected var _cars:Array;
		
		protected var _allCells:Array;
		protected var gridWidth:int;
		protected var gridHeight:int;
		
		public function VisualGrid()
		{
			super();
		}
		
		/**
		 * Initialise the grid by creating cells and putting them in the array.
		 */
		public function init(width:int, height:int):void
		{
			this._cells = new Array(height);
			this._allCells = new Array(width*height);
			
			for(var i:int=0; i<height; i++){
				var row:Array = new Array(width);
				for (var j:int=0; j<width; j++){
					var cell:ICell = new VisualCell(j,i);
					row[j] = cell;
					allCells[i*width+j] = cell;
				}
				cells[i] = row;
			}
			this.gridWidth = width;
			this.gridHeight = height;
		}
		
		public function get cells():Array
		{
			return _cells;
		}

		public function get trafficLights():Array
		{
			return _trafficLights;
		}

		public function get cars():Array
		{
			return _cars;
		}

		public function get allCells():Array
		{
			return _allCells;
		}


	}
}