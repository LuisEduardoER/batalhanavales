package {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Embarcacao {
		
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
			peca.addEventListener(EventosBatalhaNaval.ATINGIRPECA, this.verificarEstado);
		}
		
		public function verificarEstado(e:Event):void {
			var peca:Peca = Peca(e.target);
			peca.removeEventListener(EventosBatalhaNaval.ATINGIRPECA, this.verificarEstado);
			
			var contadorPecasAtingidas:int;
			for (var i:int = 0; i < this.pecas.length; i++) {
				if (this.pecas[i].estado == EstadoPeca.PECAATINGIDA) {
					contadorPecasAtingidas++;
					this.pecas[i].estado = EstadoPeca.PECAATINGIDA;
				}
			}
			if (contadorPecasAtingidas == this.pecas.length) {
				this.abater();
			}
			else if (contadorPecasAtingidas > 0) {
				this.estado = EstadoEmbarcacao.EMBARCACAOATINGIDA;
			}
		}
		
		public function abater():void {
			this.estado = EstadoEmbarcacao.EMBARCACAOABATIDA;
			for (var i:int = 0; i < this.pecas.length; i++) {
				this.pecas[i].estado = EstadoPeca.PECAABATIDA;
			}
		}
		
		public function verificarPecaExistente(linha:uint, coluna:uint):Boolean {
			var retorno:Boolean = false;
			for (var i:int = 0; i < pecas.length; i++) {
				if ((pecas[i].linha == linha) && (pecas[i].coluna == coluna)) {
					retorno = true;
					break;
				}
				
			}
			return retorno;
		}
		
	}
	
}