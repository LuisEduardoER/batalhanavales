package {
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Frota {
		private var _submarino:Embarcacao;
		private var _portaAvioes:Embarcacao;
		private var _destroyer:Embarcacao;
		private var _embarcacoes:Array;
		
		//private var ultimaEmbarcacaoAbatida:Embarcacao;
		
		public function Frota() {
			this._submarino = new Embarcacao();
			this._portaAvioes = new Embarcacao();
			this._destroyer = new Embarcacao();
			this._embarcacoes = [this.submarino, this.portaAvioes, this.destroyer];
			//this.ultimaEmbarcacaoAbatida = new Embarcacao();
		}
		
		public function get submarino():Embarcacao { 
			return _submarino;
		}
		
		public function get portaAvioes():Embarcacao { 
			return _portaAvioes;
		}
		
		public function get destroyer():Embarcacao { 
			return _destroyer;
		}
		
		public function get embarcacoes():Array { 
			return _embarcacoes;
		}	
		
	}
	
}