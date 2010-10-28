﻿package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Peca extends MovieClip {
		private var linha:int;
		private var coluna:int;
		private var estado:String;
		
		public function Peca() {
			var nome:String = this.name;
			this.linha = int(this.name.substr(4, 1));
			this.coluna = int(this.name.substr(5, 1));
			this.estado = EstadoPeca.PECAOCULTA;
			//É isso o que eu faço com o estado???
			//Se for ficar assim, tem que mudar o diagrama de classes pq lá diz que Peca tem um EstadoPeca.
			
			this.addEventListener(MouseEvent.MOUSE_UP, this.clicar);
		}
		
		private function clicar(e:MouseEvent):void {
			this.dispatchEvent( new Event(EventosBatalhaNaval.CLICARPECA) );
		}
		
	}
	
}