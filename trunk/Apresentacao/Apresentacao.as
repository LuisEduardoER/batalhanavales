package {	
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Apresentacao extends MovieClip{
		private var avanca:Button;
		
		public function Apresentacao() {
			this.avanca = this.avanca_btn;			
			this.avanca.addEventListener(MouseEvent.MOUSE_UP, clicar);						
			this.gotoAndStop(1);
		}
		
		private function clicar(e:MouseEvent):void {
			this.nextFrame();			
			trace("frame atual = " + this.currentFrame);
		}
		
	}
	
}