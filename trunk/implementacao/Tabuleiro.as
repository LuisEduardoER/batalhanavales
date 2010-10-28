package {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Tabuleiro extends MovieClip {
		private var pecas:Array;
		private var ultimaPecaClicada:Peca;
		
		public function Tabuleiro() {
			this.ultimaPecaClicada = undefined;
			this.inicializarPecas();
		}
		
		private function inicializarPecas():void {
			this.pecas = new Array(10);
			for (var i:int = 0; i < this.pecas.length; i++) {
				this.pecas[i] = new Array(10);
				for (var j:int = 0; j < this.pecas[i].length; j++) {
					this.pecas[i][j] = this.getChildByName("quad" + i + j + "_mc");
					this.pecas[i][j].addEventListener(EventosBatalhaNaval.CLICARPECA, clicar)
				}	
			}
		}
		
		//O computador não vai clicar em peca nenhuma.
		/*private function clicar(e:Event):void {
			this.ultimaPecaClicada
			this.dispatchEvent( new EventosBatalhaNaval(EventosBatalhaNaval.CLICARPECA) );
		}*/
	}
	
}