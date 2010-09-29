package {
	
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Perdeu extends Feedback{
		
		public function Perdeu() {
			super();
			this.sim_btn.addEventListener(MouseEvent.MOUSE_UP, this.clicar);
			this.nao_btn.addEventListener(MouseEvent.MOUSE_UP, this.clicar);
		}
	}
	
}