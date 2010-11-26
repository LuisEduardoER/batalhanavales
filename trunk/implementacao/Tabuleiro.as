package {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Tabuleiro extends MovieClip {
		private var _pecas:Array;
		private var _ultimaPecaClicada:Peca;
		private var _frota:Frota; //Por enquanto, é como se fosse a frota do oponente humano.
		private var _ultimaEmbarcacaoAbatida:Embarcacao;
		
		public function Tabuleiro() {
			this.frota = new Frota();
			this.ultimaPecaClicada = undefined;
			this.inicializarPecas();
			
			this.frota.addEventListener(EventosBatalhaNaval.ABATEREMBARCACAO, this.abaterEmbarcacao);
		}
		
		public function copiar(tabuleiro:Tabuleiro):void {						
			for (var i:int = 0; i < tabuleiro.frota.embarcacoes.length; i++) {
				for (var j:int = 0; j < tabuleiro.frota.embarcacoes[i].pecas.length; j++) {
					this.frota.embarcacoes[i].adicionarPeca(this.pecas[tabuleiro.frota.embarcacoes[i].pecas[j].linha][tabuleiro.frota.embarcacoes[i].pecas[j].coluna]);					
				}
			}
		}
		
		private function abaterEmbarcacao(e:Event):void {
			this._ultimaEmbarcacaoAbatida = this.frota.ultimaEmbarcacaoAbatida;
			this.dispatchEvent(new Event(EventosBatalhaNaval.ABATEREMBARCACAO));
		}
		
		private function inicializarPecas():void {
			this._pecas = new Array(10);
			for (var i:int = 0; i < this.pecas.length; i++) {
				this._pecas[i] = new Array(10);
				for (var j:int = 0; j < this.pecas[i].length; j++) {
					this._pecas[i][j] = this.getChildByName("quad" + i + j + "_mc");
					this._pecas[i][j].buttonMode = true;
					this._pecas[i][j].addEventListener(EventosBatalhaNaval.CLICARPECA, clicar);
					this._pecas[i][j].addEventListener(EventosBatalhaNaval.ACERTARAGUA, dispararAcertarAgua);
				}					
			}
		}
		
		private function dispararAcertarAgua(e:Event):void {
			this.dispatchEvent(new Event(EventosBatalhaNaval.ACERTARAGUA));
		}
		
		public function get pecas():Array { 
			return _pecas;
		}
		
		public function get frota():Frota { 
			return _frota;
		}
		
		public function set frota(value:Frota):void {
			_frota = value;
		}
		
		public function get ultimaEmbarcacaoAbatida():Embarcacao { 
			return _ultimaEmbarcacaoAbatida;
		}
		
		public function set pecas(value:Array):void {
			_pecas = value;
		}
		
		public function get ultimaPecaClicada():Peca { 
			return _ultimaPecaClicada;
		}
		
		public function set ultimaPecaClicada(value:Peca):void {
			_ultimaPecaClicada = value;
		}
		
		//O computador não vai clicar em peca nenhuma.
		private function clicar(e:Event):void {	
			this.ultimaPecaClicada = Peca(e.target);
			this.dispatchEvent(new Event(EventosBatalhaNaval.CLICARPECA));		
			this.procurarPecaNaFrota();
		}
		
		private function procurarPecaNaFrota():void {
			var encontrou:Boolean = false;
			for (var i:int = 0; i < this.frota.embarcacoes.length; i++) {
				for (var j:int = 0; j < this.frota.embarcacoes[i].pecas.length; j++) {
					if (this.frota.embarcacoes[i].pecas[j] == this.ultimaPecaClicada) {						
						this.dispatchEvent( new Event(EventosBatalhaNaval.ATINGIRPECA) ); //tah mandando o atingiu peça sem saber se abateu
						this.ultimaPecaClicada.estado = EstadoPeca.PECAATINGIDA;
						encontrou = true;
						break;
					}
				}				
			}			
			if (!encontrou) {
				this.ultimaPecaClicada.estado = EstadoPeca.PECAAGUA;
				
			}			
		}
		
		public function liberarClique(liberado:Boolean):void {
			for (var i:int = 0; i < this.pecas.length; i++) {
				for (var j:int = 0; j < this.pecas[i].length; j++) {
					this.pecas[i][j].mouseEnabled = liberado;
				}	
			}
		}
	}
	
}