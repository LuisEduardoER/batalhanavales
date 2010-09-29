package {
	import fl.controls.Button;
	import fl.controls.RadioButton;
	import fl.controls.TextArea;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Principal extends MovieClip {
		
		/*Alvo onde as telas serão attachadas*/
		private var alvo:MovieClip;
		
		/*Telas*/
		private var introducao:MovieClip;
		private var regras:MovieClip;
		private var distribuindoFrota:MovieClip;
		private var jogo:MovieClip;
		private var ganhou:MovieClip;
		private var perdeu:MovieClip;
		
		/*Construtor da classe*/
		public function Principal() {
			this.alvo = alvo_mc;			
			//this.introducao = this.attacharTela("Introducao", true);			
			//this.distribuindoFrota = this.attacharTela("DistribuindoFrota", true);			
			this.ganhou = this.attacharTela("Ganhou", true);
			this.ganhou.addEventListener("continuar", continuarJogando);
		}
		
		/* Esse método será chamando quando, depois de terminado o jogo, o jogador decide continuar jogando. */
		private function continuarJogando(e:Event):void{
			trace("clicou em continuar");
		}
		
		/* Esse método será chamando quando, depois de terminado o jogo, o jogador decide não jogar mais. */
		private function sair(e:Event):void{
			trace("clicou em sair");
		}
		
		/*Attacha a tela de acordo com o nome passado como parâmetro. A tela atual é removida se o segundo parâmetro for true.*/
		private function attacharTela(nomeTela:String, limpar:Boolean = true):MovieClip {
			if (limpar)	this.limparAlvo();
			var tela:MovieClip;
			switch (nomeTela) {
				case "Introducao":			tela = new Introducao();											
											break;
				case "Regras": 				tela = new Regras();
											break;
				case "DistribuindoFrota": 	tela = new DistribuindoFrota();
											break;
				case "Jogo": 				tela = new Jogo();
											break;
				case "Ganhou": 				tela = new Ganhou();
											break;
				case "Perdeu": 				tela = new Perdeu();
											break;
			}
			this.alvo.addChild(tela);
			return tela;
		}
		
		private function limparAlvo():void {
			while (this.alvo.numChildren > 0) {
				this.alvo.removeChildAt(0);
			}
		}
				
	}
	
}