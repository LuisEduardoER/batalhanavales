package {
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
		
		public function ConvidandoOponente(socket:XMLSocket) {
			this.jogadores = this.jogadores_dg;
			this.configurarFataGrid();
			this.comunicacao = socket;
			this.pedirJogadores();
			
			//this.adicionarJogador("1", "Lorena");
		}
		
		private function pedirJogadores():void {
			this.comunicacao.send("<dados tipo='pedidoJogadores' />");
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