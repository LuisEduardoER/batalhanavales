package {
	import fl.controls.Button;
	import fl.controls.TextArea;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Saulo, Lorena e Havana
	 */
	public class ControleJogo extends MovieClip {
		/*Elementos do palco*/
		private var meuTabuleiro:Tabuleiro;
		private var oponenteTabuleiro:Tabuleiro;
		private var tabuleiros:Array;
		private var frota:Frota;
		private var log:TextArea;
		/*Fim de elementos do palco*/
		
		private var vez:int;
		private var eu:Jogador;
		private var oponente:Jogador;
		private var jogadores:Array;
		private var delay:Timer;
		
		/*Teste*/
		private var pcJogar:Button;
		/*Fim Teste*/
		
		public function ControleJogo(eu:Humano, oponente:Jogador, tabuleiro:Tabuleiro) {
			this.eu = eu;
			this.oponente = oponente;
			this.jogadores = [this.eu, this.oponente];
			
			this.meuTabuleiro = this.tabuleiro1_mc;
			this.meuTabuleiro.copiar(tabuleiro);
			this.meuTabuleiro.addEventListener(EventosBatalhaNaval.ACERTARAGUA, acertarAgua);
			this.meuTabuleiro.addEventListener(EventosBatalhaNaval.ATINGIRPECA, atingirPeca);
			this.meuTabuleiro.addEventListener(EventosBatalhaNaval.ABATEREMBARCACAO, this.abaterEmbarcacao);
			this.meuTabuleiro.addEventListener(EventosBatalhaNaval.CLICARPECA, this.informarJogada);
			
			this.oponenteTabuleiro = this.tabuleiro2_mc;
			this.oponenteTabuleiro.addEventListener(EventosBatalhaNaval.ACERTARAGUA, acertarAgua);
			this.oponenteTabuleiro.addEventListener(EventosBatalhaNaval.ATINGIRPECA, atingirPeca);
			this.oponenteTabuleiro.addEventListener(EventosBatalhaNaval.ABATEREMBARCACAO, this.abaterEmbarcacao);
			this.oponenteTabuleiro.addEventListener(EventosBatalhaNaval.CLICARPECA, this.informarJogada);
			
			this.tabuleiros = [this.meuTabuleiro, this.oponenteTabuleiro];									
			
			this.frota = this.frota_mc;
			this.log = this.log_txt;	
			this.log.addEventListener (Event.CHANGE, scrollLog);
			
			this.delay = new Timer(1000);
			
			this.verificarTipoOponente();			
			this.iniciarJogo();			
						
		}	
		
		private function scrollLog (e:Event){
			this.log.verticalScrollPosition = this.log.maxVerticalScrollPosition;
		}
		
		private function revalorarDelay():void {
			var numero:Number = 1000 + Math.floor(Math.random() * 1000);
			this.delay.delay = numero;
		}
		
		private function informarJogada(e:Event):void {
			var tabuleiro:Tabuleiro = Tabuleiro(e.target);
			this.log.text += "\n" + this.jogadores[this.vez].nome + " jogou em (" + tabuleiro.ultimaPecaClicada.linha + ", " + tabuleiro.ultimaPecaClicada.coluna + ").";
		}
		
		private function verificarTipoOponente():void{
			if (this.oponente.nome == "Computador") {
				Computador(this.oponente).criarInteligencia(oponenteTabuleiro);
			}
		}
		
		private function iniciarJogo():void{
			this.vez = Math.floor(Math.random() * 2);
			this.log.text += "Definido por sorteio: " + this.jogadores[this.vez].nome + " inicia jogando.";
			this.liberarJogada();	
		}
		
		private function continuarVez():void {
			this.log.text += "\n" + this.jogadores[this.vez].nome + " deve jogar novamente.";
			if (this.jogadores[this.vez].nome == "Computador") {
				this.revalorarDelay();
				this.delay.start();
				this.delay.addEventListener(TimerEvent.TIMER, this.jogarComputador);
			}
		}
		
		private function passarVez(e:Event = null):void {
			this.vez = (1 - this.vez);			
			this.log.text += "\nAgora eh a vez de " + this.jogadores[this.vez].nome + " jogar.";
			this.liberarJogada();
		}				
		
		private function liberarJogada():void {
			if (this.vez == 0) {				
				this.oponenteTabuleiro.liberarClique(true);
			}			
			else {				
				this.oponenteTabuleiro.liberarClique(false);
				this.revalorarDelay();
				this.delay.start();
				this.delay.addEventListener(TimerEvent.TIMER, this.jogarComputador);				
			}			
		}
		
		private function jogarComputador(e:Event):void {
			this.delay.removeEventListener(TimerEvent.TIMER, this.jogarComputador);			
			var jogadaOponente:Jogada = Computador(this.oponente).escolherJogada();
			this.meuTabuleiro.pecas[jogadaOponente.linha][jogadaOponente.coluna].clicar();			
		}
		
		private function acertarAgua(e:Event):void {
			if (this.vez == 1 && this.oponente.nome == "Computador") {
				Computador(this.oponente).acertarAgua();
			}
			this.log.text += "\n" + this.jogadores[this.vez].nome + " não atingiu nenhuma peça de nenhuma embarcação.";
			this.passarVez();
		}
		
		private function atingirPeca(e:Event):void {
			if (this.vez == 1 && this.oponente.nome == "Computador") {
				Computador(this.oponente).atingirPeca();
			}
			this.log.text += "\n" + this.jogadores[this.vez].nome + " atingiu uma peça de uma embarcação.";
			this.continuarVez();
		}
		
		private function abaterEmbarcacao(e:Event):void {
			if (this.vez == 1 && this.oponente.nome == "Computador") {				
				Computador(this.oponente).abaterEmbarcacao(this.meuTabuleiro.ultimaEmbarcacaoAbatida);				
			}
			this.log.text += "\n" + this.jogadores[this.vez].nome + " abateu um " + this.tabuleiros[(1-this.vez)].ultimaEmbarcacaoAbatida.nome + " de " + this.jogadores[(1-this.vez)].nome + ".";
		}
				
	}
	
}