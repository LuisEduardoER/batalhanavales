package {
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Frota {
		private var _submarino:Submarino;
		private var _portaAvioes:PortaAvioes;
		private var _destroyer:Destroyer;
		
		public function Frota() {
			this.submarino = new Submarino();
			this.portaAvioes = new PortaAvioes();
			this.destroyer = new Destroyer();
		}
		
		public function get submarino():Submarino { 
			return _submarino;
		}
		
		public function get portaAvioes():PortaAvioes { 
			return _portaAvioes;
		}
		
		public function get destroyer():Destroyer { 
			return _destroyer;
		}
		
		
		
	}
	
}