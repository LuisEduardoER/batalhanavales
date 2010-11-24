package {
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Computador extends Jogador {	
		private var _inteligencia:Inteligencia;
		
		public function Computador(nome:String) {
			super(nome);			
		}	
		
		public function criarInteligencia():void {
			this.inteligencia = new Inteligencia();
		}
		
		public function get inteligencia():Inteligencia { 
			return _inteligencia;
		}				
								
	}
	
}