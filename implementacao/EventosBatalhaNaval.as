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
		
		/* Passar telas*/
		
		public static const REGRASPASSARTELA: String = "regrasPassarTela";
		public static const INTRODUCAOPASSARTELA: String = "introducaoPassarTela";
		
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