package {
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Mensagem {
		private var _nomeCliente:String;
		private var _idCliente:int;
		private var _tipo:String;
		private var _texto:String;
		private var _idDestinatario:int;
		
		public function Mensagem() {
			this.texto = "";
			this.nomeCliente = "";
		}
		
		public function get idCliente():int { 
			return _idCliente;
		}
		
		public function set idCliente(value:int):void {
			_idCliente = value;
		}
		
		public function get tipo():String { 
			return _tipo;
		}
		
		public function set tipo(value:String):void {
			_tipo = value;
		}
		
		public function get texto():String { 
			return _texto;
		}
		
		public function set texto(value:String):void {
			_texto = value;
		}
		
		public function get nomeCliente():String { 
			return _nomeCliente;
		}
		
		public function set nomeCliente(value:String):void {
			_nomeCliente = value;
		}
		
		public function get idDestinatario():int { 
			return _idDestinatario;
		}
		
		public function set idDestinatario(value:int):void {
			_idDestinatario = value;
		}
		
		
		public function criarXML():String {
			var retorno_str:String = new String();
			retorno_str += "<servidor.Mensagem>";
			retorno_str += "<idCliente>" + this.idCliente + "</idCliente>";			
			retorno_str += "<tipo>" + this.tipo + "</tipo>";					
			retorno_str += "<texto>" + this.texto+ "</texto>";			
			retorno_str += "<nomeCliente>" + this.nomeCliente+ "</nomeCliente>";			
			retorno_str += "<idDestinatario>" + this.idDestinatario+ "</idDestinatario>";			
			retorno_str += "</servidor.Mensagem>";
			return retorno_str;
		}
	}
	
}