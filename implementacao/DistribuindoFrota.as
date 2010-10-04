package {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class DistribuindoFrota extends MovieClip{
		
		private var submarino:MovieClip;
		private var destroyer:MovieClip;
		private var portaAvioes:MovieClip;
		private var tabuleiro:MovieClip;
		
		public function DistribuindoFrota() {
			this.submarino = this.frota_mc.submarino_mc;
			this.destroyer = this.frota_mc.destroyer_mc;
			this.portaAvioes = this.frota_mc.portaAvioes_mc;
			this.tabuleiro = this.tabuleiro_mc;
			this.configurar();
		}
		
		private function configurar():void {
			this.frota_mc.submarinoLinha_mc.visible =
			this.frota_mc.destroyerLinha_mc.visible =
			this.frota_mc.portaAvioesLinha_mc.visible = false;
			
			this.portaAvioes.addEventListener("terminarArrasto", this.terminarArrasto);
		}
		
		public function liberar():void {
			trace("Distribuindo frota: liberar");
			this.log_txt.htmlText += "Oponente conectado. Posicione sua frota nos locais desejados e clique em \"Iniciar jogo\".";
			
			this.portaAvioes.addEventListener("terminarArrasto", this.terminarArrasto);
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