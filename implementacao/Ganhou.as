﻿package {
	
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Ganhou extends Feedback{
		
		public function Ganhou() {
			super();
			this.sim_btn.addEventListener(MouseEvent.MOUSE_UP, this.clicar);
			this.nao_btn.addEventListener(MouseEvent.MOUSE_UP, this.clicar);
		}
	}
	
}