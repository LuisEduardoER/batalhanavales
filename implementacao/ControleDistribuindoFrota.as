package {
	import fl.controls.Button;
	import fl.controls.TextArea;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.XMLSocket;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class ControleDistribuindoFrota extends MovieClip{
		
		private var submarino:MovieClip;
		private var destroyer:MovieClip;
		private var portaAvioes:MovieClip;
		private var tabuleiro:MovieClip;
		
		private var fala:TextArea;
		
		
		/*Botoes*/
		private var sair:Button;
		private var enviar:Button;
		private var iniciarJogo:Button;
		/*Fim de Botoes*/
		
		/*Comunicacao*/
		private var comunicacao:XMLSocket;
		private var idCliente:int;
		/*Fim de Comunicacao*/
		
		/*Frota*/
		private var frota:Array;
		/*Fim frota*/
		
		public function ControleDistribuindoFrota(socket:XMLSocket, id:int) {
			/*Comunicacao*/
			this.comunicacao = socket;
			this.idCliente = id;
			/*Fim de Comunicacao*/
			
			this.submarino = this.frota_mc.submarino_mc;
			this.destroyer = this.frota_mc.destroyer_mc;
			this.portaAvioes = this.frota_mc.portaAvioes_mc;
			this.tabuleiro = this.tabuleiro_mc;
			
			/*Botoes*/
			this.sair = this.sair_btn;
			this.sair.addEventListener(MouseEvent.MOUSE_UP, this.clicarSair);
			this.enviar = this.enviar_btn;
			this.iniciarJogo = this.iniciarJogo_btn;
			/*Fim de Botoes*/
			
			this.fala = this.fala_txt;
			
			this.frota = new Array();
			
			
			this.configurar();
			this.liberar();
		}
		
		private function clicarSair(e:MouseEvent):void {
			this.dispatchEvent( new EventosBatalhaNaval(EventosBatalhaNaval.SAIR) );			
		}				
		
		public function habilitar(novoEstado:Boolean):void {
			
			if (novoEstado) {
				if (this.fala.text != "") {
					this.enviar.enabled = 
					this.enviar.mouseEnabled = novoEstado;
				}
			}else {
				this.enviar.enabled = 
				this.enviar.mouseEnabled = novoEstado;
			}
			this.fala.editable =
			this.sair.enabled = 
			this.sair.mouseEnabled =
			this.iniciarJogo.mouseEnabled =
			this.iniciarJogo.enabled = novoEstado;//falta criar condicao para habilitar o iniciarJogo
		}
		
		private function configurar():void {
			this.frota_mc.submarinoLinha_mc.visible =
			this.frota_mc.destroyerLinha_mc.visible =
			this.frota_mc.portaAvioesLinha_mc.visible = false;
			
			/*this.submarino.addEventListener(MouseEvent.MOUSE_DOWN, arrastarEmbarcacao);
			this.submarino.addEventListener(MouseEvent.MOUSE_UP, soltarEmbarcacao);*/
			
			this.portaAvioes.addEventListener(EventosBatalhaNaval.SOLTAREMBARCACAO, this.soltarEmbarcacao);
			this.destroyer.addEventListener(EventosBatalhaNaval.SOLTAREMBARCACAO, this.soltarEmbarcacao);
		}
		
		private function soltarEmbarcacao(e:EventosBatalhaNaval):void {
			var movie:MovieClip = MovieClip(e.currentTarget);
			var posicoes:Array = this.localizarPosicoes(movie);
			trace(posicoes)
			if (movie.pecas.length != posicoes.length) {//quando a embarcacao esta fora do tabuleiro ou parte fora
				movie.dispatchEvent(new EventosBatalhaNaval(EventosBatalhaNaval.FORATABULEIRO));
				
			}else if(this.verificarPecas(posicoes)) {
				movie.dispatchEvent(new EventosBatalhaNaval(EventosBatalhaNaval.FORATABULEIRO));
				trace("colocou embarcacao em cima de outra embarcacao");
				
			}else {
				var embarcacao:Embarcacao = new Embarcacao();
				for (var i:int = 0; i < posicoes.length; i++) {
					var peca:Peca = this.tabuleiro.pecas[posicoes[i][0]][posicoes[i][1]];
					embarcacao.adicionarPeca(peca);
				}
				this.frota.push(embarcacao);
			}
			
			
			
			
		}
		
		private function localizarPosicoes(embarcacao:MovieClip):Array {
			var retorno:Array = new Array();
			var pecas:Array = embarcacao.pecas;
			var parar_bool:Boolean = false;
			for (var k:int = 0; k < pecas.length ; k++) {
				parar_bool = false;
				for (var i:int = 0; i < 10; i++) {
					for (var j:int = 0; j < 10 ; j++) {
						if (pecas[k].hitTestObject(this.tabuleiro["quad"+i+""+j+"_mc"])) {
							parar_bool = true;
							retorno.push([i, j]);
							break;
						}
					}
					if (parar_bool) break;
					
				}
			}
			return retorno;
		}
		
		private function verificarPecas(posicoes:Array):Boolean {
			var retorno:Boolean = false;
			for (var i:int = 0; i < this.frota.length; i++) {
				for (var j:int = 0; j <posicoes.length; j++) {
					if (this.frota[i].verificarPecaExistente(posicoes[j][0],posicoes[j][1])) {
						retorno = true;
						break;
					}
				}
				if (retorno) break;
				
			}
			return retorno;
		}
		
		/*private function arrastarEmbarcacao(e:MouseEvent):void {
			this.submarino.startDrag();
			
		}*/
		
		public function liberar():void {
			this.log_txt.htmlText += "Posicione sua frota nos locais desejados e clique em \"Iniciar jogo\".";						
		}
		
		/*private function terminarArrasto(e:Event):void {
			var embarcacao:PortaAvioes = PortaAvioes(e.currentTarget);
			this.estaDentroTabuleiro(embarcacao);
		}*/
		
		/*private function estaDentroTabuleiro(embarcacao:PortaAvioes):Boolean {				
			if (embarcacao.figura.x > this.tabuleiro.x - embarcacao.x - embarcacao.parent.x + embarcacao.figura.width / 2) {
				trace("está à direita do x mínimo");
			}
			else {
				trace("está à esquerda do x mínimo");
			}
			
			return true;
		}*/
		
	}
	
}