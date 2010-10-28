package {
	import flash.display.MovieClip;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Embarcacao extends MovieClip {
		
		public var quantidadePecas:int;
		public var quantidadePecasAtingidas:int;
		public var estado:String;
		public var pecas:Array;
		
		public function Embarcacao() {
			this.estado = "perfeito";
		}
		
	}
	
}