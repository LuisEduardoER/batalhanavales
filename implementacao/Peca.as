package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Peca extends MovieClip {
		private var _linha:int;
		private var _coluna:int;
		private var _estado:String;
		
		public function Peca() {
			var nome:String = this.name;
			this._linha = int(this.name.substr(4, 1));
			this._coluna = int(this.name.substr(5, 1));
			this.estado = EstadoPeca.PECAOCULTA;
			//É isso o que eu faço com o estado???
			//Se for ficar assim, tem que mudar o diagrama de classes pq lá diz que Peca tem um EstadoPeca.
			
			this.addEventListener(MouseEvent.MOUSE_UP, this.clicar);
		}
		
		//O computador não vai clicar em peca nenhuma.
		public function clicar(e:MouseEvent = null):void {			
			this.dispatchEvent( new Event(EventosBatalhaNaval.CLICARPECA) );
		}
		
		public function get estado():String { 
			return _estado;
		}
		
		public function set estado(value:String):void {				
			this.estado = value;
			this.gotoAndStop(this.estado);
			if (this.estado == EstadoPeca.PECAATINGIDA) {
				this.dispatchEvent( new EventosBatalhaNaval(EventosBatalhaNaval.ATINGIRPECA) );
			}
			else if (this.estado == EstadoPeca.PECAAGUA) {
				this.dispatchEvent( new EventosBatalhaNaval(EventosBatalhaNaval.ACERTARAGUA) );
			}
		}
		
		public function get linha():int { 
			return _linha;
		}
		
		private function set linha(value:int):void {
			_linha = value;
		}
		
		public function get coluna():int {
			return _coluna;
		}
		
		private function set coluna(value:int):void {
			_coluna = value;
		}
			
	}
	
}