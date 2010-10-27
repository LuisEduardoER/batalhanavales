package {
	import flash.display.MovieClip;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Computador extends MovieClip{
		
		private var tabuleiro:MovieClip;
		private var matrizConhecida:Array;
		private var matrizDesconhecida:Array; //Matriz do usuário que está jogando contra o computador
		
		public function Computador() {
			this.tabuleiro =  tabuleiro_mc;
			this.inicializarMatrizes();
			this.distribuirPecas();
		}
		
		private function inicializarMatrizes():void {
			this.matrizConhecida = new Array(10);
			this.matrizDesconhecida = new Array(10);
			for (var i:int = 0; i < 10; i++) {
				this.matrizConhecida[i] = new Array(10);
				this.matrizDesconhecida[i] = new Array(10);
				for (var j:int = 0; j < 10; j++) {
					this.matrizConhecida[i][j] = "X";
					this.matrizDesconhecida[i][j] = "X";
				}						
			}
		}
		
		private function mostrarMatrizDesconhecida():void {
			for (var i:int = 0; i < 10; i++) {
				trace("this.matrizDesconhecida["+i+"] = "+ this.matrizDesconhecida[i]);
			}
		}
		
		//Esse método será usado para o computador distribuir as peças dele, mas, por enquanto, é como se fosse a distribuição do usuário que está jogando
		//contra o computador
		private function distribuirPecas():void {
			this.distribuirPortaAvioes();
			this.distribuirSubmarino();
			
			this.mostrarMatrizDesconhecida();
		}
		
		private function distribuirSubmarino():void {
			var linha:int = Math.floor(Math.random()*this.matrizDesconhecida.length);
			var coluna:int = Math.floor(Math.random() * this.matrizDesconhecida[0].length);
			if ( this.posicaoLegal(linha, coluna, "S") ) {
				this.matrizDesconhecida[linha][coluna] = "P";
			}
			else {
				trace("Submarino nao pode ficar na posicao: " + linha + ", " + coluna);
				this.distribuirSubmarino();
			}
		}
		
		private function posicaoLegal(linha:int, coluna:int, embarcacao:String, orientacao:int = undefined):Boolean {
			var retorno:Boolean = true;
			if (embarcacao == "S") {
				for (var i:int = (linha - 1); i <= (linha + 1) ; i++) {
					for (var j:int = (coluna - 1); j <= (coluna + 1) ; j++) {
						if (  (i >= 0) && (j >= 0) && (i <= (this.matrizDesconhecida.length - 1) ) && (j <= (this.matrizDesconhecida.length - 1) ) ) {
							if (this.matrizDesconhecida[i][j] != "X") {
								retorno = false;
							}
						}
					}
				}
			}
			else if (embarcacao == "P") {
				if (orientacao == 0) {					
					for (var a:int = (linha - 1); a <= (linha + 1) ; a++) {
						for (var b:int = (coluna - 1); b <= (coluna + 4) ; b++) {
							if (  (a >= 0) && (b >= 0) && (a <= (this.matrizDesconhecida.length - 1) ) && (b <= (this.matrizDesconhecida.length - 1) ) ) {
								if (this.matrizDesconhecida[a][b] != "X") {
									retorno = false;
								}
							}
						}
					}
					
				}
				else {
					for (var c:int = (linha - 1); c <= (linha + 4) ; c++) {
						for (var d:int = (coluna - 1); d <= (coluna + 1) ; d++) {
							if (  (c >= 0) && (d >= 0) && (c <= (this.matrizDesconhecida.length - 1) ) && (d <= (this.matrizDesconhecida.length - 1) ) ) {
								if (this.matrizDesconhecida[c][d] != "X") {
									retorno = false;
								}
							}
						}
					}
				}
			}
			
			return retorno;
		}
		
		private function distribuirPortaAvioes():void {
			var orientacao:int = Math.floor(Math.random() * 2); // 0 horizontal, 1 vertical.
			var linha:int;
			var coluna:int;
			if (orientacao == 0) { // horizontal
				linha = Math.floor(Math.random() * this.matrizDesconhecida.length);
				coluna = Math.floor( Math.random() * (this.matrizDesconhecida[0].length - 4) );
				if ( this.posicaoLegal(linha, coluna, "P", 0) ) {
					this.matrizDesconhecida[linha][coluna] = "P";
					this.matrizDesconhecida[linha][coluna + 1] = "P";
					this.matrizDesconhecida[linha][coluna + 2] = "P";
					this.matrizDesconhecida[linha][coluna + 3] = "P";					
				}
				else {
					this.distribuirPortaAvioes();
				}
			}
			else {
				linha = Math.floor( Math.random() * (this.matrizDesconhecida.length - 4) );
				coluna = Math.floor( Math.random() * this.matrizDesconhecida[0].length );
				if ( this.posicaoLegal(linha, coluna, "P", 1) ) {
					this.matrizDesconhecida[linha][coluna] = "P";
					this.matrizDesconhecida[linha + 1][coluna] = "P";
					this.matrizDesconhecida[linha + 2][coluna] = "P";
					this.matrizDesconhecida[linha + 3][coluna] = "P";					
				}
				else {
					this.distribuirPortaAvioes();
				}
			}						
		}
	}
	
}