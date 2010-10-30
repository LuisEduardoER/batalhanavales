﻿package {
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class PortaAvioesFigura extends MovieClip {				
		public var figura:MovieClip;
		private var mais90:Button;
		private var menos90:Button;
		private var terminarArrasto_evt:Event;
		public var partes:Array;
		private var xIni:Number;
		private var yIni:Number;
		
		public function PortaAvioesFigura() {
			super();			
			this.figura = this.figura_mc;
			this.mais90 = this.mais90_mc;
			this.menos90 = this.menos90_mc;
			//this.quantidadePartes = 4;
			this.partes = [this.figura.parte1_mc, this.figura.parte2_mc, this.figura.parte3_mc, this.figura.parte4_mc];
			this.xIni = this.figura.x;
			this.yIni = this.figura.y;
			//this.terminarArrasto_evt = new Event(EventosBatalhaNaval.SOLTAREMBARCACAO);
			
			this.figura.addEventListener(MouseEvent.MOUSE_DOWN, this.iniciarArrasto);
			this.figura.addEventListener(MouseEvent.MOUSE_UP, this.terminarArrasto);
			
			this.addEventListener(MouseEvent.ROLL_OVER, this.aparecer);
			this.addEventListener(MouseEvent.ROLL_OUT, this.desaparecer);
			this.addEventListener(EventosBatalhaNaval.FORATABULEIRO, voltarPosicaoInicial);
			
			this.mais90.addEventListener(MouseEvent.MOUSE_UP, this.rotacionar);
			this.menos90.addEventListener(MouseEvent.MOUSE_UP, this.rotacionar);
			
		}		
		
		private function voltarPosicaoInicial(e:EventosBatalhaNaval):void {
			this.figura.x = this.xIni;
			this.figura.y = this.yIni;
		}
		
		private function iniciarArrasto(m:MouseEvent):void {
			this.desaparecer();
			this.figura.startDrag(true);
		}
				
		private function terminarArrasto(m:Event):void {
			this.figura.stopDrag();
			this.dispatchEvent(new EventosBatalhaNaval(EventosBatalhaNaval.SOLTAREMBARCACAO));
			//this.dispatchEvent(new Event(EventosBatalhaNaval.SOLTAREMBARCACAO));
		}
		
		public function configurar():void {
			
		}
		
		private function aparecer(m:MouseEvent = null):void {
			this.mais90.visible =
			this.menos90.visible = true;
		}
		
		private function desaparecer(m:MouseEvent = null):void {
			this.mais90.visible = 
			this.menos90.visible = false;
		}
		
		private function rotacionar(e:Event = null):void {
			var fator:int;
			var botao:String = Button(e.currentTarget).name;
			if (botao == "mais90_mc") {
				this.figura.rotation += 90;
			}
			else {
				this.figura.rotation -= 90;
			}
		}
		
	}
	
}