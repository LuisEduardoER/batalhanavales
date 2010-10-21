package {
	
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class ControleGanhou extends Feedback{
		
		public function ControleGanhou() {
			super();
			this.sim_btn.addEventListener(MouseEvent.MOUSE_UP, this.clicar);
			this.nao_btn.addEventListener(MouseEvent.MOUSE_UP, this.clicar);
		}
	}
	
}