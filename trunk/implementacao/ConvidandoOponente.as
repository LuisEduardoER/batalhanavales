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
			
			//this.adicionarJogador("1", "Lorena");
		}
		
		private function pedirJogadores():void {
			var msg:Mensagem = new Mensagem();
			msg.idCliente = this.idCliente;
			msg.tipo = "pedidoJogadores";
			this.comunicacao.send(msg.criarXML());
		}
		
		public function adicionarJogador(id:String, nome:String):void {
			this.jogadores.addItem( { Id: id, Nome: nome } );
			this.log_txt.text += "-> " + nome + " entrou na sala.";
		}
		
		private function configurarFataGrid():void {						
			jogadores.columns = ["Id", "Nome"]; 
			jogadores.columns[0].width = 35; 
		}
	}
	
}