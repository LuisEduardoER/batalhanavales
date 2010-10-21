package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.XMLSocket;
	import flash.events.DataEvent;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class ControleLogin extends MovieClip {
		
		private var comunicacao:XMLSocket;
		private var conexaoAceita_evt:Event;
		private var _idCliente:int;
		
		public function ControleLogin(socket:XMLSocket) {
			this.configurar();
			this.comunicacao = socket;
			this.conexaoAceita_evt = new EventosBatalhaNaval(EventosBatalhaNaval.CONEXAOACEITA);
		}
		
		public function configurar():void {			
			this.nome_txt.addEventListener(Event.CHANGE, this.modificar);						
			this.humano_rb.addEventListener(Event.CHANGE, this.modificar);			
			this.computador_rb.addEventListener(Event.CHANGE, this.modificar);
			this.ok_btn.addEventListener(MouseEvent.MOUSE_UP, this.logar);
		}	
		
		private function modificar(e:Event):void {			
			if ( (this.nome_txt.text != "") && (this.humano_rb.selected || this.computador_rb.selected) ) {
				this.ok_btn.enabled = true;
			}
			else {
				this.ok_btn.enabled = false;
			}
		}
				
		private function logar(e:Event):void {
			this.ok_btn.removeEventListener(MouseEvent.MOUSE_UP, this.logar);
			this.ok_btn.enabled = false;
			this.log_txt.htmlText += "Conectando ao servidor...";
			this.comunicacao.addEventListener(Event.CONNECT, confirmarConexao);
			this.comunicacao.connect("localhost", 8090);
			this.enviarNome();
		}
		
		public function enviarNome():void {
			var mensagem:Mensagem = new Mensagem();
			mensagem.tipo = "envioNome";
			//mensagem.idCliente = this.idCliente;
			mensagem.texto = this.nome_txt.text;
			this.comunicacao.send(mensagem.criarXML());
		}
		
		private function confirmarConexao(e:Event):void {
			//var xml:XML = XML(e.data);
			this.log_txt.htmlText += "Conexão realizada com sucesso.";
			this.dispatchEvent(this.conexaoAceita_evt);
		}
		
		public function get idCliente():int { 
			return _idCliente;
		}
		
		public function set idCliente(value:int):void {
			_idCliente = value;
		}
		
		
	}
	
}