package {
	
	/**
	 * ...
	 * @author Saulo e Lorena
	 */
	public class Jogador {
		private var _nome:String;
		
		public function Jogador(nome:String) {
			this.nome = nome;
		}
		
		public function get nome():String { 
			return _nome;
		}
		
		public function set nome(value:String):void {
			_nome = value;
		}
	}
	
}