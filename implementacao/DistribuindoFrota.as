package {
	import flash.display.MovieClip;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class DistribuindoFrota extends MovieClip{
		
		private var submarino:MovieClip;
		private var destroyer:MovieClip;
		private var portaAvioes:MovieClip;
		
		public function DistribuindoFrota() {
			this.submarino = this.frota_mc.submarino_mc;
			this.destroyer = this.frota_mc.destroyer_mc;
			this.portaAvioes = this.frota_mc.portaAvioes_mc;
			this.configurar();
		}
		
		private function configurar():void {
			this.frota_mc.submarinoLinha_mc.visible =
			this.frota_mc.destroyerLinha_mc.visible =
			this.frota_mc.portaAvioesLinha_mc.visible = false;
		}
		
	}
	
}