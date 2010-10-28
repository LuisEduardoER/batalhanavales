package {
	import flash.display.MovieClip;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Embarcacao{
		
		public var quantidadePecas:int;
		public var quantidadePecasAtingidas:int;
		public var estado:String;
		public var pecas:Array;
		
		public function Embarcacao() {
			this.estado = EstadoEmbarcacao.EMBARCACAOPERFEITA;
			this.pecas = [];
		}
		
		public function adicionarPeca(peca:Peca):void {
			this.pecas.push(peca);
			this.quantidadePecas = this.pecas.length;
		}
		
		public function verificarEstado():void {
			var contadorPecasAtingidas:int;
			for (var i:int = 0; i < this.pecas.length; i++) {
				if (this.pecas[i].estado == EstadoPeca.PECAATINGIDA) {
					contadorPecasAtingidas++;
					this.pecas[i].estado = EstadoPeca.PECAATINGIDA;
				}
			}
			if (contadorPecasAtingidas == this.pecas.length) {
				this.abatar();
			}
			else if (contadorPecasAtingidas > 0) {
				this.estado = EstadoEmbarcacao.EMBARCACAOATINGIDA;
			}
		}
		
		public function abatar():void {
			this.estado = EstadoEmbarcacao.EMBARCACAOABATIDA;
			for (var i:int = 0; i < this.pecas.length; i++) {
				this.pecas[i].estado = EstadoPeca.PECAABATIDA;
			}
		}
		
	}
	
}