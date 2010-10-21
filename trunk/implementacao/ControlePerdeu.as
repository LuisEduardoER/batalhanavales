package {
	
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class ControlePerdeu extends Feedback{
		
		public function ControlePerdeu() {
			super();
			this.sim_btn.addEventListener(MouseEvent.MOUSE_UP, this.clicar);
			this.nao_btn.addEventListener(MouseEvent.MOUSE_UP, this.clicar);
		}
	}
	
}