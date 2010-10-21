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
			
			this.portaAvioes.addEventListener("terminarArrasto", this.terminarArrasto);
		}
		
		public function liberar():void {
			this.log_txt.htmlText += "Posicione sua frota nos locais desejados e clique em \"Iniciar jogo\".";						
		}
		
		private function terminarArrasto(e:Event):void {
			var embarcacao:PortaAvioes = PortaAvioes(e.currentTarget);
			this.estaDentroTabuleiro(embarcacao);
		}
		
		private function estaDentroTabuleiro(embarcacao:PortaAvioes):Boolean {				
			if (embarcacao.figura.x > this.tabuleiro.x - embarcacao.x - embarcacao.parent.x + embarcacao.figura.width / 2) {
				trace("está à direita do x mínimo");
			}
			else {
				trace("está à esquerda do x mínimo");
			}
			
			return true;
		}
		
	}
	
}