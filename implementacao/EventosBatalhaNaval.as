package {
	
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Saulo e Lorena
	 */
	public class EventosBatalhaNaval extends Event {
		
		public static const CONEXAOACEITA: String = "conexaoAceita";
		public static const CONTINUAR: String = "continuar";
		public static const SAIR: String = "sair";
		public static const ACEITARCONVITE: String = "aceitarConvite";
		public static const RECUSARCONVITE: String = "recusarConvite";
		public static const CANCELARCONVITE: String = "cancelarConvite";
		public static const ESCOLHERNOVOOPONENTE: String = "escolherNovoOponente";
		public static const VOLTARCONVIDANDOOPONENTE: String = "voltarConvidandoOponente";
		public static const CAIXAGERALOK: String = "caixaGeralOk";
		public static const CAIXACONFIRMACAOSIM: String = "caixaConfirmacaoSim";
		public static const CAIXACONFIRMACAONAO: String = "caixaConfirmacaoNao";
		
		/*Jogo*/
		public static const CLICARPECA: String = "clicarPeca";
		public static const ATINGIRPECA: String = "atingirPeca"; //Peca dispara para Embarcacao escutar e Tabuleiro dispara para Computador escutar.
		public static const ACERTARAGUA: String = "acertarAgua";		
		/*Fim de Jogo*/
		
		
		/* Passar telas */
		
		public static const REGRASPASSARTELA: String = "regrasPassarTela";
		public static const INTRODUCAOPASSARTELA: String = "introducaoPassarTela";
		public static const CONVIDANDOOPONENTEPASSARTELA: String = "convidandoOponentePassarTela";
		
		/* Fim de Passar telas */
		
		public function EventosBatalhaNaval(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event { 
			return new EventosBatalhaNaval(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("EventosBatalhaNaval", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}