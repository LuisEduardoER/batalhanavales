﻿package {
	import fl.controls.DataGrid;
	import flash.display.MovieClip;
	import flash.net.XMLSocket;
	import flash.events.DataEvent;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class ConvidandoOponente extends MovieClip {
		
		private var jogadores:DataGrid;
		private var comunicacao:XMLSocket;	
		private var idCliente:int;
		
		public function ConvidandoOponente(socket:XMLSocket, id:int) {
			this.jogadores = this.jogadores_dg;
			this.idCliente = id;
			this.configurarFataGrid();
			this.comunicacao = socket;
			this.pedirJogadores();						
		}
		
		private function pedirJogadores():void {
			var msg:Mensagem = new Mensagem();
			msg.idCliente = this.idCliente;
			msg.tipo = "pedidoJogadores";
			this.comunicacao.send(msg.criarXML());
		}
		
		public function adicionarJogador(id:String, nome:String, novoJogador:Boolean = false):void {
			var item:Object = { Id: id, Nome: nome };
			if(!this.verificarExistencia(item)){
				this.jogadores.addItem( item );			
				if ( (novoJogador) || (int(id) == this.idCliente) ) {
					this.log_txt.text += "-> " + nome + " entrou na sala.\n";
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
	}
	
}