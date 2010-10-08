package {
	import fl.controls.Button;
	import fl.controls.ComboBox;
	import fl.controls.DataGrid;
	import fl.controls.TextArea;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.XMLSocket;
	import flash.events.DataEvent;
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class ConvidandoOponente extends MovieClip {
		
		private var jogadores:DataGrid;
		private var destinatarios:ComboBox;
		private var comunicacao:XMLSocket;	
		private var idCliente:int;
		private var fala:TextArea;
		private var enviar:Button;
		
		public function ConvidandoOponente(socket:XMLSocket, id:int) {
			this.jogadores = this.jogadores_dg;
			this.destinatarios = this.destinatarios_cb;
			this.idCliente = id;
			this.configurarFataGrid();
			this.comunicacao = socket;
			this.fala = this.fala_txt;
			this.enviar = this.enviar_btn;
			this.pedirJogadores();	
			
			this.fala.addEventListener(Event.CHANGE, this.habilitarBotao);
			this.enviar.addEventListener(MouseEvent.MOUSE_UP, this.enviarTexto);
		}
		
		private function enviarTexto(e:MouseEvent):void{
			var msg:Mensagem = new Mensagem();			
			msg.texto = this.fala.text;
			
			if ( this.destinatarios.selectedIndex == 0 ) {
				msg.tipo = "conversaPublica";
			}
			else {
				msg.tipo = "conversaPrivada";
				msg.idDestinatario = this.destinatarios.selectedItem.data;
			}			
			
			this.comunicacao.send( msg.criarXML() );
			this.fala.text = "";
			this.enviar.enabled = false;
		}
		
		private function habilitarBotao(e:Event):void{
			if (this.fala.text != "") {
				this.enviar.enabled = true;
			}
			else {
				this.enviar.enabled = false;
			}
		}
		
		private function pedirJogadores():void {
			var msg:Mensagem = new Mensagem();
			msg.idCliente = this.idCliente;
			msg.tipo = "pedidoJogadores";
			this.comunicacao.send(msg.criarXML());
		}
		
		public function adicionarJogador(id:String, nome:String, novoJogador:Boolean = false):void {
			var item:Object = { Id: id, Nome: nome };
			var itemCB:Object = { label: nome, data: id};
			if(!this.verificarExistencia(item)){
				this.jogadores.addItem( item );						
				if ( (novoJogador) || (int(id) == this.idCliente) ) {
					this.log_txt.text += "-> " + nome + " entrou na sala.\n";
				}
				if (int(id) != this.idCliente) {
					this.destinatarios.addItem(itemCB);
				}
			}
		}
		public function removerJogador(id:String, nome:String):void {
			var item:Object = { Id: id, Nome: nome };
			for (var i:int = 0; i < this.jogadores.length; i++) {
				if (this.jogadores.getItemAt(i).Id == id) {
					this.jogadores.removeItem(this.jogadores.getItemAt(i));
					this.log_txt.text += "-> " + nome + " saiu da sala.\n";
					break;
				}
			}
			this.removerDestinatario(id, nome);
		}
		
		private function removerDestinatario(id:String, nome:String):void {
			var itemCB:Object = { label: nome, data: id };
			for (var i:int = 0; i < this.destinatarios.length; i++) {
				if (this.destinatarios.getItemAt(i).data == id) {
					this.destinatarios.removeItem( this.destinatarios.getItemAt(i) );
					break;
				}
			}
		}
		
		private function verificarExistencia(item:Object):Boolean {
			var retorno:Boolean = false;
			for (var i:int = 0; i < this.jogadores.length; i++) {
				if (this.jogadores.getItemAt(i).Id == item.Id) {
					retorno = true;
					break;
				}
			}
			
			return retorno;
		}
		
		private function configurarFataGrid():void {						
			jogadores.columns = ["Id", "Nome"]; 
			jogadores.columns[0].width = 35; 
		}
		
		public function receberFala(remetente:String, idDestinatario:String, fala:String, reservado:Boolean):void {
			if (reservado) {
				if (this.idCliente.toString() == idDestinatario) {
					this.log_txt.htmlText += (remetente + " falou <i>reservadamente</i> para você: " + fala + "<br>");
				}
				else {
					var destinatario:String = this.buscarNome(idDestinatario);
					this.log_txt.htmlText += ("Você falou <i>reservadamente</i> para " + destinatario + ": " + fala + "<br>");
				}
			}
			else {
				this.log_txt.text += (remetente + " falou: " + fala + "\n");	
			}
		}
		
		private function buscarNome(id:String):String {
			var retorno:String = "";
			for (var i:int = 0; i < this.destinatarios.length; i++) {
				trace(this.destinatarios.getItemAt(i).data + " == " + id);
				if (this.destinatarios.getItemAt(i).data == id) {
					retorno = this.destinatarios.getItemAt(i).label;
					break;
				}
			}
			return retorno;
		}
	}
	
}