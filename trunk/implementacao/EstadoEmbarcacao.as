package {
	import flash.events.Event;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class EstadoEmbarcacao extends Event{
		
		public static const EMBARCACAOPERFEITA: String = "embarcacaoPerfeita";
		public static const EMBARCACAOATINGIDA: String = "embarcacaoAtingidaa";
		public static const EMBARCACAOABATIDA: String = "embarcacaoAbatida";
		
		public function EstadoEmbarcacao(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event { 
			return new EstadoEmbarcacao(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("EstadoEmbarcacao", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}