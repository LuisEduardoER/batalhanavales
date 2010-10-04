package {
	import fl.controls.Button;
	import fl.controls.RadioButton;
	import fl.controls.TextArea;
	import flash.display.MovieClip;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.XMLSocket;
	
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
		
		/*Comunicação*/
		public var socket:XMLSocket;
		
		/*Construtor da classe*/
		public function Principal() {
			this.socket = new XMLSocket();
			this.socket.addEventListener(DataEvent.DATA, receberMensagem);
			//this.socket.addEventListener(Event.CONNECT, conectarCliente);
			//this.socket.connect("localhost", 8090);
			
			this.alvo = alvo_mc;			
			this.introducao = this.attacharTela("Introducao", true);
			this.introducao.addEventListener("conexaoAceita", irParaRegras);
			/*this.regras = this.attacharTela("Regras", true);
			this.regras.addEventListener("Regras_clicarOK", this.clicarOKRegras);*/

			//this.distribuindoFrota = this.attacharTela("DistribuindoFrota", true);			
			//this.ganhou = this.attacharTela("Ganhou", true);
			//this.ganhou.addEventListener("continuar", continuarJogando);
			
			
			
		}
		
		private function receberMensagem(e:DataEvent):void {
			trace("recebeu msg");			
			var xml:XML = new XML(e.data);			
			switch((xml.@tipo).toString()) {
				case "liberacao": 	this.distribuindoFrota.liberar();
									trace("entrou no case");
									break;
			}
		}
		
		private function irParaRegras(e:Event):void {
			this.regras = this.attacharTela("Regras", true);
			this.regras.addEventListener("Regras_clicarOK", clicarOKRegras);
		}
		
		
		
		/* Esse método será chamando quando, depois de terminado o jogo, o jogador decide continuar jogando. */
		private function continuarJogando(e:Event):void{
			trace("Feedback: clicou em continuar");
		}
		
		/* Esse método será chamando quando, depois de terminado o jogo, o jogador decide não jogar mais. */
		private function sair(e:Event):void{
			trace("Feedback: clicou em sair");
		}
		
		/* Esse método será chamando quando, o OK da tela de Regras for pressionado. */
		//É preciso adicionar a linha de baixo qdo a tela de regras for criada.
		//this.regras.addEventListener("Regras_clicarOK", this.clicarOKRegras);
		private function clicarOKRegras(e:Event):void {
			this.distribuindoFrota = this.attacharTela("DistribuindoFrota", true);		
		}
		
		/*Attacha a tela de acordo com o nome passado como parâmetro. A tela atual é removida se o segundo parâmetro for true.*/
		private function attacharTela(nomeTela:String, limpar:Boolean = true):MovieClip {
			if (limpar)	this.limparAlvo();
			var tela:MovieClip;
			switch (nomeTela) {
				case "Introducao":			tela = new Introducao(this.socket);											
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
				default:					trace("Essa tela não existe.");
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