package {
	import fl.controls.Button;
	import fl.controls.TextArea;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.XMLSocket;
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
		private var resultado:Resultado;
		private var _tipoResultado:String;
		private var comunicacao:XMLSocket;
		
		private var jogadaEnviada:Boolean;
		
		public function ControleJogo(socket:XMLSocket,eu:Humano, oponente:Jogador, tabuleiro:Tabuleiro) {
			this.eu = eu;
			this.oponente = oponente;
			this.jogadores = [this.eu, this.oponente];
			
			this.comunicacao = socket;
			
			this.meuTabuleiro = this.tabuleiro1_mc;
			this.meuTabuleiro.copiar(tabuleiro);
			this.meuTabuleiro.addEventListener(EventosBatalhaNaval.ACERTARAGUA, acertarAgua);
			this.meuTabuleiro.addEventListener(EventosBatalhaNaval.ATINGIRPECA, atingirPeca);
			this.meuTabuleiro.addEventListener(EventosBatalhaNaval.ABATEREMBARCACAO, this.abaterEmbarcacao);
			this.meuTabuleiro.addEventListener(EventosBatalhaNaval.CLICARPECA, this.informarJogada);
			this.meuTabuleiro.addEventListener(EventosBatalhaNaval.TERMINARJOGO, this.terminarJogo);
			
			this.oponenteTabuleiro = this.tabuleiro2_mc;
			this.oponenteTabuleiro.addEventListener(EventosBatalhaNaval.ACERTARAGUA, acertarAgua);
			this.oponenteTabuleiro.addEventListener(EventosBatalhaNaval.ATINGIRPECA, atingirPeca);
			this.oponenteTabuleiro.addEventListener(EventosBatalhaNaval.ABATEREMBARCACAO, this.abaterEmbarcacao);
			this.oponenteTabuleiro.addEventListener(EventosBatalhaNaval.CLICARPECA, this.informarJogada);
			this.oponenteTabuleiro.addEventListener(EventosBatalhaNaval.TERMINARJOGO, this.terminarJogo);
			
			this.tabuleiros = [this.meuTabuleiro, this.oponenteTabuleiro];									
			
			this.frota = this.frota_mc;
			this.log = this.log_txt;				
			
			this.delay = new Timer(1000);
			
			this.verificarTipoOponente();	
			//-----------------------------//
			this.meuTabuleiro.liberarClique(false);
			this.oponenteTabuleiro.liberarClique(false);
			this.vez = -1;
			this.jogadaEnviada = false;
			//----------------------------//
			//this.iniciarJogo();			
						
		}
		
		public function liberarMinhaJogada():void {
			this.vez = 0;
			this.escreverLog("Vez de " + this.jogadores[this.vez].nome + " jogar.");
			this.liberarJogada();
		}
		
		public function liberarOponenteJogada():void {
			this.vez = 1;
			this.escreverLog("Vez de " + this.jogadores[this.vez].nome + " jogar.");
			this.liberarJogada();
		}
		
		private function escreverLog (texto:String) {
			this.log.appendText(texto);
			this.log.verticalScrollPosition = this.log.maxVerticalScrollPosition;
		}
		
		private function revalorarDelay():void {
			var numero:Number = 1000 + Math.floor(Math.random() * 1000);
			this.delay.delay = numero;
		}
		
		private function informarJogada(e:Event):void {
			
			var tabuleiro:Tabuleiro = Tabuleiro(e.target);
			this.oponenteTabuleiro.liberarClique(false);
			this.meuTabuleiro.liberarClique(false);
			this.escreverLog("\n" + this.jogadores[this.vez].nome + " jogou em (" + tabuleiro.ultimaPecaClicada.linha + ", " + tabuleiro.ultimaPecaClicada.coluna + ") ");
			if (this.oponente.nome != "Computador" && this.vez == 0 && !this.jogadaEnviada) {
				var msg:Mensagem = new Mensagem();
				msg.tipo = "jogada";
				msg.linha = tabuleiro.ultimaPecaClicada.linha;
				msg.coluna = tabuleiro.ultimaPecaClicada.coluna;
				this.comunicacao.send(msg.criarXML());
				this.jogadaEnviada = true;
			}
			
			
		}
		
		private function verificarTipoOponente():void{
			if (this.oponente.nome == "Computador") {
				Computador(this.oponente).criarInteligencia(oponenteTabuleiro);
				//------//
				this.vez = Math.floor(Math.random() * 2);
				
				this.liberarJogada();
			}
		}
		
		public function iniciarJogo():void{
			/*this.vez = Math.floor(Math.random() * 2);*/
			this.escreverLog("Definido por sorteio: " + this.jogadores[this.vez].nome + " inicia jogando.");
			this.liberarJogada();	
		}
		
		public function continuarVez():void {
			this.escreverLog("\n" + this.jogadores[this.vez].nome + " deve jogar novamente.");
			if (this.jogadores[this.vez].nome == "Computador") {
				this.revalorarDelay();
				this.delay.start();
				this.delay.addEventListener(TimerEvent.TIMER, this.jogarComputador);
			}else {
				//this.vez = 0;
				this.liberarJogada();
			}
		}
		
		public function passarVez(e:Event = null):void {
			this.vez = (1 - this.vez);			
			this.escreverLog("\nAgora eh a vez de " + this.jogadores[this.vez].nome + " jogar.");
			this.liberarJogada();
		}				
		
		private function liberarJogada():void {
			this.jogadaEnviada = false;
			if (this.vez == 0) {				
				this.oponenteTabuleiro.liberarClique(true);
				this.meuTabuleiro.liberarClique(false);
			}			
			else {				
				this.oponenteTabuleiro.liberarClique(false);
				this.meuTabuleiro.liberarClique(true);
				if (this.jogadores[this.vez].nome == "Computador") {
					this.revalorarDelay();
					this.delay.start();
					this.delay.addEventListener(TimerEvent.TIMER, this.jogarComputador);
				}
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
				//
				
			}
			if (this.vez == 1 && this.oponente.nome != "Computador" && !this.jogadaEnviada) {
				this.retornarJogada(EstadoPeca.PECAAGUA);
				
			}
			
			this.escreverLog("e não atingiu nenhuma peça de nenhuma embarcação de " + this.jogadores[(1 - this.vez)].nome + ".");
			this.passarVez();
		}
		
		private function atingirPeca(e:Event):void {
			if (this.vez == 1 && this.oponente.nome == "Computador") {
				Computador(this.oponente).atingirPeca();
			}
			if (this.vez == 1 && this.oponente.nome != "Computador") {
				this.retornarJogada(EstadoPeca.PECAATINGIDA);
			}
			this.escreverLog("e atingiu uma peça de uma embarcação de " + this.jogadores[(1-this.vez)].nome + ".");
			this.continuarVez();
		}
		
		private function abaterEmbarcacao(e:Event):void {
			if (this.vez == 1 && this.oponente.nome == "Computador") {				
				Computador(this.oponente).abaterEmbarcacao(this.meuTabuleiro.ultimaEmbarcacaoAbatida);				
			}
			if (this.vez == 1 && this.oponente.nome != "Computador") {
				this.retornarJogada(EstadoPeca.PECAABATIDA);
			}
			this.escreverLog("\n" + this.jogadores[this.vez].nome + " abateu um " + this.tabuleiros[(1 - this.vez)].ultimaEmbarcacaoAbatida.nome + " de " + this.jogadores[(1 - this.vez)].nome + ".");			
		}
		
		private function terminarJogo(e:Event):void {
			this.oponenteTabuleiro.liberarClique(false);
			this.escreverLog("\n" + this.jogadores[this.vez].nome + " abateu todas as embarcações de " + this.jogadores[(1 - this.vez)].nome + ".");			
			if (this.vez == 0) {
				this.tipoResultado = TipoResultado.GANHOU;
			}
			else {
				this.tipoResultado = TipoResultado.PERDEU;
			}
			this.dispatchEvent( new EventosBatalhaNaval(EventosBatalhaNaval.TERMINARJOGO ) );
		}
		
		private function sair(e:Event):void{
			trace("sair");
		}
		
		private function continuarJogo(e:Event):void{
			trace("continuar");
		}
		
		public function get tipoResultado():String { 
			return _tipoResultado;
		}
		
		public function set tipoResultado(value:String):void {
			_tipoResultado = value;
		}
		
		
		public function executarJogadaOponente(linha:int, coluna:int):void {
			this.meuTabuleiro.pecas[linha][coluna].clicar();
		}
		
		public function receberResultadoJogada(tipo:String):void {
			trace("this.meuTabuleiro.ultimaPecaClicada: " + this.meuTabuleiro.ultimaPecaClicada);
			this.oponenteTabuleiro.ultimaPecaClicada.estado = tipo;
		}
		
		private function retornarJogada(tipo:String):void {
			var msg:Mensagem = new Mensagem();
			msg.tipo = "resultadoJogada";
			msg.texto = tipo;
			this.comunicacao.send(msg.criarXML());
		}
				
	}
	
}