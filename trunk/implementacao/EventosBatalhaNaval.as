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
		
		/* Passar telas*/
		
		public static const REGRASPASSARTELA: String = "regrasPassarTela";
		public static const INTRODUCAOPASSARTELA: String = "introducaoPassarTela";
		public static const CONVIDANDOOPONENTEPASSARTELA: String = "convidandoOponentePassarTela";
		
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