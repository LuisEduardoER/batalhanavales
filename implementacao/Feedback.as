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
		public var continuar_evt:Event;
		public var sair_evt:Event;
		
		public function Feedback() {
			this.continuar_evt = new Event("continuar");
			this.sair_evt = new Event("sair");			
		}
		
		function clicar(e:MouseEvent):void{
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