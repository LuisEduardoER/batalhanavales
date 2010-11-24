package {
	import fl.controls.TextArea;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Saulo, Lorena e Havana
	 */
	public class ControleJogo extends MovieClip {
		/*Elementos do palco*/
		private var meuTabuleiro:Tabuleiro;
		private var oponenteTabuleiro:Tabuleiro;
		private var frota:Frota;
		private var log:TextArea;
		/*Fim de elementos do palco*/
		
		private var vez:int;
		private var jogadores:Array;
		private var inteligencia:Inteligencia;
		
		public function ControleJogo(eu:Humano, oponente:Jogador) {
			this.jogadores = [eu, oponente];
			this.meuTabuleiro = this.tabuleiro1_mc;
			this.oponenteTabuleiro = this.tabuleiro2_mc;
			this.frota = this.frota_mc;
			this.log = this.log_txt;				
			
			this.iniciarJogo();
		}				
		
		private function iniciarJogo():void{
			this.vez = Math.floor(Math.random()*2);
		}
	}
	
}