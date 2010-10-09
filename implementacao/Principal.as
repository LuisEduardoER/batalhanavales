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
		private var login:MovieClip;
		private var regras:MovieClip;
		private var convidandoOponente:MovieClip;
		private var distribuindoFrota:MovieClip;
		private var jogo:MovieClip;
		private var ganhou:MovieClip;
		private var perdeu:MovieClip;
		
		/*Comunicação*/
		public var socket:XMLSocket;
		
		private var id:int;
		private var nome:String;
		
		/*Construtor da classe*/
		public function Principal() {
			this.socket = new XMLSocket();
			this.socket.addEventListener(DataEvent.DATA, receberMensagem);
			//this.socket.addEventListener(Event.CONNECT, conectarCliente);
			//this.socket.connect("localhost", 8090);
			
			this.alvo = alvo_mc;	
			
			this.introducao = this.attacharTela("Introducao", true);
			this.introducao.addEventListener(EventosBatalhaNaval.INTRODUCAOPASSARTELA, this.irParaRegras);
						
			
			/*this.regras = this.attacharTela("Regras", true);
			this.regras.addEventListener("Regras_clicarOK", this.clicarOKRegras);*/

			//this.distribuindoFrota = this.attacharTela("DistribuindoFrota", true);			
			//this.ganhou = this.attacharTela("Ganhou", true);
			//this.ganhou.addEventListener("continuar", continuarJogando);
			
			
			
		}
		
		private function receberMensagem(e:DataEvent):void {			
			var xml:XML = new XML(e.data);	
			trace("Principal recebeu msg do tipo " + xml.tipo);
			switch((xml.tipo).toString()) {
				case "liberacao": 				this.distribuindoFrota.liberar();									
												break;
									
				case "respostaConecta": 		this.id = int(xml.idCliente);
												this.irParaConvidandoOponente();
												break;
									
				case "respostaPedidoJogadores": trace("xml.texto = " + xml.texto);
												this.preencherDataGrid(xml.texto);
												break;
									
				case "eventoEntradaJogador": 	trace("chegou novo jogador");
												this.preencherDataGrid(xml.texto, true);
												break;
									
				case "eventoSaidaJogador": 		this.removerDoDataGrid(xml.texto);
												break;
									
				case "conversaPublica": 		this.falarChat(xml);
												break;
												
				case "conversaPrivada": 		this.falarChat(xml, true);
												break;
												
				case "conviteOponente": 		this.convidandoOponente.mostrarCaixaConviteRecebido(xml.nomeCliente, xml.idCliente);
												break;
												
				case "cancelamentoConvite":		this.convidandoOponente.receberCancelamentoConvite();
												break;
												
				case "aceitacaoConvite":		this.convidandoOponente.receberAceitacao();
												break;
												
				case "recusaConvite":			this.convidandoOponente.receberRecusa();
												trace("Principal: receberRecusa");
												break;
				
				default:				trace("Principal -> receberMensagem -> não entrou em case nenhum.");
										break;
			}
		}
		
		private function falarChat(xml:XML, reservado:Boolean = false):void {
			var remetente:String = xml.nomeCliente;
			var idDestinatario:String = xml.idDestinatario;
			var fala:String = xml.texto;
			this.convidandoOponente.receberFala(remetente, idDestinatario, fala, reservado);
		}
		
		private function removerDoDataGrid(texto:String):void {
			if(this.convidandoOponente.parent == this.alvo_mc){
				var dados:Array = texto.split(",");						
				this.convidandoOponente.removerJogador(dados[1], dados[0]); 	
			}
		}
		
		private function preencherDataGrid(texto:String, novoJogador:Boolean = false):void {
			var nomes:Array = texto.split(",");
			var ids:Array = [];			
			for (var i:int = (nomes.length/2); i < nomes.length; i++) {
				ids.push(nomes[i]);
			}
			nomes.splice( (nomes.length/2), (nomes.length/2) );			
			for (var j:int = 0; j < nomes.length; j++) {
				/*trace("nomes["+j+"] = " + nomes[j]);
				trace("ids[" + j + "] = " + ids[j]);*/				
				this.convidandoOponente.adicionarJogador(ids[j], nomes[j], novoJogador); 	
			}			
		}
		
		private function irParaRegras(e:Event):void {
			this.regras = this.attacharTela("Regras", true);
			this.regras.addEventListener(EventosBatalhaNaval.REGRASPASSARTELA, irParaLogin);
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
		private function irParaLogin(e:Event):void {
			this.login = this.attacharTela("Login", true);
			//this.login.addEventListener(EventosBatalhaNaval.CONEXAOACEITA, irParaConvidandoOponente);			
			//this.distribuindoFrota = this.attacharTela("DistribuindoFrota", true);		
		}
		
		private function irParaConvidandoOponente():void {
			this.convidandoOponente = this.attacharTela("ConvidandoOponente", true);
			this.convidandoOponente.addEventListener(EventosBatalhaNaval.CONVIDANDOOPONENTEPASSARTELA, this.irParaDistribuindoFrota);			
		}
		
		private function irParaDistribuindoFrota(e:Event):void{
			this.distribuindoFrota = this.attacharTela("DistribuindoFrota", true);
		}
		
		/*Attacha a tela de acordo com o nome passado como parâmetro. A tela atual é removida se o segundo parâmetro for true.*/
		private function attacharTela(nomeTela:String, limpar:Boolean = true):MovieClip {
			if (limpar)	this.limparAlvo();
			var tela:MovieClip;
			switch (nomeTela) {
				case "Introducao":			tela = new Introducao();											
											break;
				case "Login":				tela = new Login(this.socket);											
											break;
				case "Regras": 				tela = new Regras();
											break;
				case "DistribuindoFrota": 	tela = new DistribuindoFrota();
											break;
				case "ConvidandoOponente": 	tela = new ConvidandoOponente(this.socket, this.id);
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