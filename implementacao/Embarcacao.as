package {
	import flash.display.MovieClip;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Embarcacao extends MovieClip {
		
		public var quantidadePartes:int;
		public var quantidadePartesAtingidas:int;
		public var estado:String;
		
		public function Embarcacao() {
			this.estado = "perfeito";
		}
		
	}
	
}