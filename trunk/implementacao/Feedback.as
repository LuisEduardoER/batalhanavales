package {
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Feedback extends MovieClip {
		private var continuar_evt:Event;
		private var sair_evt:Event;
		
		public function Feedback() {
			this.sim_btn.addEventListener(MouseEvent.MOUSE_UP, this.clicar);
			this.nao_btn.addEventListener(MouseEvent.MOUSE_UP, this.clicar);
		}
		
		private function clicar(e:MouseEvent):void{
			var botao_btn:Button = Button(e.currentTarget);
			if (botao_btn.name == "sim_btn") {
				this.dispatchEvent(this.continuar_evt);
			}
			else {
				this.dispatchEvent(this.sair_evt);
			}
		}
	}
	
}