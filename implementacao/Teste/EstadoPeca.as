package {
	import flash.events.Event;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class EstadoPeca extends Event{
		
		public static const PECAOCULTA: String = "pecaOculta";
		public static const PECAAGUA: String = "pecaAgua";
		public static const PECAATINGIDA: String = "pecaAtingida";
		public static const PECAABATIDA: String = "pecaAbatida";
		
		public function EstadoPeca(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event { 
			return new EstadoPeca(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("EstadoPeca", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}