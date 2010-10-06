package {
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Mensagem {
		private var _idCliente:int;
		private var _tipo:String;
		private var _texto:String;
		
		public function Mensagem() {
			this.texto = "";
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
		
		public function criarXML():String {
			var retorno_str:String = new String();
			retorno_str += "<servidor.Mensagem>";
			retorno_str += "<idCliente>" + this.idCliente + "</idCliente>";			
			retorno_str += "<tipo>" + this.tipo + "</tipo>";					
			retorno_str += "<texto>" + this.texto+ "</texto>";			
			retorno_str += "</servidor.Mensagem>";
			return retorno_str;
		}
	}
	
}