package {
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author Lorena Tablada
	*/
	public class Inteligencia extends MovieClip{
		
		private var tabuleiro:Tabuleiro; //Tabuleiro da inteligencia
		private var matrizOponente:Array; // Essa eh a matriz que representa o que a inteligencia conhece da matriz de seu oponente (o humano).
		private var minhaMatriz:Array; //Matriz do usuário que está jogando contra o computador	
		
		//private var jogar:Button;
		private var ultimaLinhaEscolhida:int;
		private var ultimaColunaEscolhida:int;
		
		public function Inteligencia(tabuleiro:Tabuleiro) {
			this.tabuleiro =  tabuleiro;			
			
			//this.jogar = jogar_btn;
			//this.jogar.addEventListener(MouseEvent.MOUSE_UP, this.escolherJogada);
			//O computador não vai clicar em peca nenhuma.
			//this.tabuleiro.addEventListener(EventosBatalhaNaval.CLICARPECA, clicar);
			
			this.inicializarMatrizes();			
			this.distribuirPecas();
		}				
				
		
		//O computador não vai clicar em peca nenhuma.
		/*private function clicar(e:Event):void {
			var pecaClicada:Peca = Peca(e.target);
			trace("pecaClicada.name = " + pecaClicada.name);
		}*/
		
		private function inicializarMatrizes():void {
			this.matrizOponente = new Array(10);
			this.minhaMatriz = new Array(10);
			for (var i:int = 0; i < 10; i++) {
				this.matrizOponente[i] = new Array(10);
				this.minhaMatriz[i] = new Array(10);
				for (var j:int = 0; j < 10; j++) {
					this.matrizOponente[i][j] = "X";
					this.minhaMatriz[i][j] = "X";
				}						
			}
		}
		
		private function mostrarMinhaMatriz():void {
			for (var i:int = 0; i < 10; i++) {
				trace("this.minhaMatriz["+i+"] = "+ this.minhaMatriz[i]);
			}
		}
		
		private function mostrarMatrizOponente():void {
			for (var i:int = 0; i < 10; i++) {
				trace("this.matrizOponente["+i+"] = "+ this.matrizOponente[i]);
			}
		}
		
		//Esse método será usado para o computador distribuir as peças dele, mas, por enquanto, é como se fosse a distribuição do usuário que está jogando
		//contra o computador
		private function distribuirPecas():void {			
			this.distribuirDestroyer();
			this.distribuirPortaAvioes();
			this.distribuirSubmarino();
			
			this.mostrarMinhaMatriz();			
		}
		
		private function posicaoLegal(linha:int, coluna:int, embarcacao:String, orientacao:int = undefined):Boolean {
			var retorno:Boolean = true;
			if (embarcacao == "S") {
				for (var i:int = (linha - 1); i <= (linha + 1) ; i++) {
					for (var j:int = (coluna - 1); j <= (coluna + 1) ; j++) {
						if (  (i >= 0) && (j >= 0) && (i <= (this.minhaMatriz.length - 1) ) && (j <= (this.minhaMatriz.length - 1) ) ) {
							if (this.minhaMatriz[i][j] != "X") {
								retorno = false;
								break;
							}
						}
					}
				}
			}
			else if (embarcacao == "P") {
				if (orientacao == 0) {					
					for (var a:int = (linha - 1); a <= (linha + 1) ; a++) {
						for (var b:int = (coluna - 1); b <= (coluna + 4) ; b++) {
							if (  (a >= 0) && (b >= 0) && (a <= (this.minhaMatriz.length - 1) ) && (b <= (this.minhaMatriz.length - 1) ) ) {
								if (this.minhaMatriz[a][b] != "X") {
									retorno = false;
									break;
								}
							}
						}
					}
					
				}
				else {
					for (var c:int = (linha - 1); c <= (linha + 4) ; c++) {
						for (var d:int = (coluna - 1); d <= (coluna + 1) ; d++) {
							if (  (c >= 0) && (d >= 0) && (c <= (this.minhaMatriz.length - 1) ) && (d <= (this.minhaMatriz.length - 1) ) ) {
								if (this.minhaMatriz[c][d] != "X") {
									retorno = false;
									break;
								}
							}
						}
					}
				}
			}
			else if (embarcacao == "D") {
				if (orientacao == 0) {					
					for (var e:int = (linha - 1); e <= (linha + 3) ; e++) {
						for (var f:int = (coluna - 1); f <= (coluna + 2) ; f++) {
							if (  (e >= 0) && (f >= 0) && (e <= (this.minhaMatriz.length - 1) ) && (f <= (this.minhaMatriz.length - 1) ) ) {
								if( !( ( e == (linha - 1) ) && ( f == (coluna + 2) ) ) && !( ( e == (linha + 3) ) && ( f == (coluna + 2) ) ) ){
									if (this.minhaMatriz[e][f] != "X") {
										retorno = false;
										break;
									}
								}
							}
						}
					}
					
				}
				else if(orientacao == 1){
					for (var g:int = (linha - 1); g <= (linha + 2) ; g++) {
						for (var h:int = (coluna - 1); h <= (coluna + 3) ; h++) {
							if (  (g >= 0) && (h >= 0) && (g <= (this.minhaMatriz.length - 1) ) && (h <= (this.minhaMatriz.length - 1) ) ) {
								if( !( ( g == (linha + 2) ) && ( h == (coluna - 1) ) ) && !( ( g == (linha + 2) ) && ( h == (coluna + 3) ) ) ){
									if (this.minhaMatriz[g][h] != "X") {
										retorno = false;
										break;
									}
								}
							}
						}
					}
				}
				else if(orientacao == 2){
					for (var m:int = (linha - 2); m <= (linha + 2) ; m++) {
						for (var n:int = (coluna - 1); n <= (coluna + 2) ; n++) {
							if (  (m >= 0) && (n >= 0) && (m <= (this.minhaMatriz.length - 1) ) && (n <= (this.minhaMatriz.length - 1) ) ) {
								if( !( ( m == (linha - 2) ) && ( n == (coluna - 1) ) ) && !( ( m == (linha + 2) ) && ( n == (coluna - 1) ) ) ){
									if (this.minhaMatriz[m][n] != "X") {
										retorno = false;
										break;
									}
								}
							}
						}
					}
				}
				else{
					for (var o:int = (linha - 2); o <= (linha + 1) ; o++) {
						for (var p:int = (coluna - 1); p <= (coluna + 3) ; p++) {
							if (  (o >= 0) && (p >= 0) && (o <= (this.minhaMatriz.length - 1) ) && (p <= (this.minhaMatriz.length - 1) ) ) {
								if( !( ( o == (linha - 2) ) && ( p == (coluna - 1) ) ) && !( ( o == (linha - 2) ) && ( p == (coluna + 3) ) ) ){
									if (this.minhaMatriz[o][p] != "X") {
										retorno = false;
										break;
									}
								}
							}
						}
					}
				}
			}
			return retorno;
		}		
		
		private function distribuirSubmarino():void {
			var linha:int = Math.floor(Math.random()*this.minhaMatriz.length);
			var coluna:int = Math.floor(Math.random() * this.minhaMatriz[0].length);
			if ( this.posicaoLegal(linha, coluna, "S") ) {
				this.minhaMatriz[linha][coluna] = "P";
				
				this.tabuleiro.frota.submarino.adicionarPeca(this.tabuleiro.pecas[linha][coluna]);
				
				this.tabuleiro.pecas[linha][coluna].estado = EstadoPeca.PECAEXPOSTA;
			}
			else {
				trace("Submarino nao pode ficar na posicao: " + linha + ", " + coluna);
				this.distribuirSubmarino();
			}
		}
		
		private function distribuirPortaAvioes():void {
			var orientacao:int = Math.floor(Math.random() * 2); // 0 horizontal, 1 vertical.
			var linha:int;
			var coluna:int;
			if (orientacao == 0) { // horizontal
				linha = Math.floor(Math.random() * this.minhaMatriz.length);
				coluna = Math.floor( Math.random() * (this.minhaMatriz[0].length - 3) );
				if ( this.posicaoLegal(linha, coluna, "P", 0) ) {
					this.minhaMatriz[linha][coluna] = "P";
					this.minhaMatriz[linha][coluna + 1] = "P";
					this.minhaMatriz[linha][coluna + 2] = "P";
					this.minhaMatriz[linha][coluna + 3] = "P";	
					
					this.tabuleiro.frota.portaAvioes.adicionarPeca(this.tabuleiro.pecas[linha][coluna]);
					this.tabuleiro.frota.portaAvioes.adicionarPeca(this.tabuleiro.pecas[linha][coluna + 1]);
					this.tabuleiro.frota.portaAvioes.adicionarPeca(this.tabuleiro.pecas[linha][coluna + 2]);
					this.tabuleiro.frota.portaAvioes.adicionarPeca(this.tabuleiro.pecas[linha][coluna + 3]);
					
					this.tabuleiro.pecas[linha][coluna].estado = EstadoPeca.PECAEXPOSTA;
					this.tabuleiro.pecas[linha][coluna+1].estado = EstadoPeca.PECAEXPOSTA;
					this.tabuleiro.pecas[linha][coluna+2].estado = EstadoPeca.PECAEXPOSTA;
					this.tabuleiro.pecas[linha][coluna+3].estado = EstadoPeca.PECAEXPOSTA;
				}
				else {
					this.distribuirPortaAvioes();
				}
			}
			else { // vertical
				linha = Math.floor( Math.random() * (this.minhaMatriz.length - 3) );
				coluna = Math.floor( Math.random() * this.minhaMatriz[0].length );
				if ( this.posicaoLegal(linha, coluna, "P", 1) ) {
					this.minhaMatriz[linha][coluna] = "P";
					this.minhaMatriz[linha + 1][coluna] = "P";
					this.minhaMatriz[linha + 2][coluna] = "P";
					this.minhaMatriz[linha + 3][coluna] = "P";			
					
					this.tabuleiro.frota.portaAvioes.adicionarPeca(this.tabuleiro.pecas[linha][coluna]);
					this.tabuleiro.frota.portaAvioes.adicionarPeca(this.tabuleiro.pecas[linha + 1][coluna]);
					this.tabuleiro.frota.portaAvioes.adicionarPeca(this.tabuleiro.pecas[linha + 2][coluna]);
					this.tabuleiro.frota.portaAvioes.adicionarPeca(this.tabuleiro.pecas[linha + 3][coluna]);
					
					this.tabuleiro.pecas[linha][coluna].estado = EstadoPeca.PECAEXPOSTA;
					this.tabuleiro.pecas[linha+1][coluna].estado = EstadoPeca.PECAEXPOSTA;
					this.tabuleiro.pecas[linha+2][coluna].estado = EstadoPeca.PECAEXPOSTA;
					this.tabuleiro.pecas[linha+3][coluna].estado = EstadoPeca.PECAEXPOSTA;
				}
				else {
					this.distribuirPortaAvioes();
				}
			}						
		}
		
		private function distribuirDestroyer():void {
			var orientacao:int = Math.floor(Math.random() * 4);
			var linha:int;
			var coluna:int;
			if (orientacao == 0) {
				linha = Math.floor(Math.random() * (this.minhaMatriz.length - 2) );
				coluna = Math.floor( Math.random() * (this.minhaMatriz[0].length - 1) );
				if ( this.posicaoLegal(linha, coluna, "D", 0) ) {
					this.minhaMatriz[linha][coluna] = "P";
					this.minhaMatriz[linha + 1][coluna + 1] = "P";
					this.minhaMatriz[linha + 2][coluna] = "P";		
					
					this.tabuleiro.frota.destroyer.adicionarPeca(this.tabuleiro.pecas[linha][coluna]);
					this.tabuleiro.frota.destroyer.adicionarPeca(this.tabuleiro.pecas[linha + 1][coluna + 1]);
					this.tabuleiro.frota.destroyer.adicionarPeca(this.tabuleiro.pecas[linha + 2][coluna]);
					
					this.tabuleiro.pecas[linha][coluna].estado = EstadoPeca.PECAEXPOSTA;
					this.tabuleiro.pecas[linha+1][coluna+1].estado = EstadoPeca.PECAEXPOSTA;
					this.tabuleiro.pecas[linha+2][coluna].estado = EstadoPeca.PECAEXPOSTA;
				}
				else {
					this.distribuirDestroyer();
				}
			}
			else if(orientacao == 1){
				linha = Math.floor(Math.random() * (this.minhaMatriz.length - 1) );
				coluna = Math.floor( Math.random() * (this.minhaMatriz[0].length - 2) );
				if ( this.posicaoLegal(linha, coluna, "D", 0) ) {
					this.minhaMatriz[linha][coluna] = "P";
					this.minhaMatriz[linha][coluna + 2] = "P";
					this.minhaMatriz[linha + 1][coluna + 1] = "P";		
					
					this.tabuleiro.frota.destroyer.adicionarPeca(this.tabuleiro.pecas[linha][coluna]);
					this.tabuleiro.frota.destroyer.adicionarPeca(this.tabuleiro.pecas[linha][coluna + 2]);
					this.tabuleiro.frota.destroyer.adicionarPeca(this.tabuleiro.pecas[linha + 1][coluna + 1]);
					
					this.tabuleiro.pecas[linha][coluna].estado = EstadoPeca.PECAEXPOSTA;
					this.tabuleiro.pecas[linha][coluna+2].estado = EstadoPeca.PECAEXPOSTA;
					this.tabuleiro.pecas[linha+1][coluna+1].estado = EstadoPeca.PECAEXPOSTA;
				}
				else {
					this.distribuirDestroyer();
				}
			}
			else if(orientacao == 2){
				linha = Math.floor(Math.random() * (this.minhaMatriz.length - 1) );
				coluna = Math.floor( Math.random() * (this.minhaMatriz[0].length - 1) );
				if ( this.posicaoLegal(linha, coluna, "D", 0) ) {
					this.minhaMatriz[linha][coluna] = "P";
					this.minhaMatriz[linha - 1][coluna + 1] = "P";
					this.minhaMatriz[linha + 1][coluna + 1] = "P";	
					
					this.tabuleiro.frota.destroyer.adicionarPeca(this.tabuleiro.pecas[linha][coluna]);
					this.tabuleiro.frota.destroyer.adicionarPeca(this.tabuleiro.pecas[linha - 1][coluna + 1]);
					this.tabuleiro.frota.destroyer.adicionarPeca(this.tabuleiro.pecas[linha + 1][coluna + 1]);
					
					this.tabuleiro.pecas[linha][coluna].estado = EstadoPeca.PECAEXPOSTA;
					this.tabuleiro.pecas[linha-1][coluna+1].estado = EstadoPeca.PECAEXPOSTA;
					this.tabuleiro.pecas[linha+1][coluna+1].estado = EstadoPeca.PECAEXPOSTA;
				}
				else {
					this.distribuirDestroyer();
				}
			}
			else{
				linha = Math.floor(Math.random() * (this.minhaMatriz.length - 2) ) + 1;
				coluna = Math.floor( Math.random() * (this.minhaMatriz[0].length - 2) );
				if ( this.posicaoLegal(linha, coluna, "D", 0) ) {
					this.minhaMatriz[linha][coluna] = "P";
					this.minhaMatriz[linha - 1][coluna + 1] = "P";
					this.minhaMatriz[linha][coluna + 2] = "P";	
					
					this.tabuleiro.frota.destroyer.adicionarPeca(this.tabuleiro.pecas[linha][coluna]);
					this.tabuleiro.frota.destroyer.adicionarPeca(this.tabuleiro.pecas[linha - 1][coluna + 1]);
					this.tabuleiro.frota.destroyer.adicionarPeca(this.tabuleiro.pecas[linha][coluna + 2]);
					
					this.tabuleiro.pecas[linha][coluna].estado = EstadoPeca.PECAEXPOSTA;
					this.tabuleiro.pecas[linha-1][coluna+1].estado = EstadoPeca.PECAEXPOSTA;
					this.tabuleiro.pecas[linha][coluna+2].estado = EstadoPeca.PECAEXPOSTA;
				}
				else {
					this.distribuirDestroyer();
				}
			}						
		}
		
		public function escolherJogada():Jogada {	
			var jogada:Jogada;
			this.ultimaLinhaEscolhida = Math.floor( Math.random() * this.tabuleiro.pecas.length );
			this.ultimaColunaEscolhida = Math.floor( Math.random() * this.tabuleiro.pecas[0].length );
			
			if (this.matrizOponente[this.ultimaLinhaEscolhida][this.ultimaColunaEscolhida] == "X") { //Se ainda n tiver atirado nessa posicao,
				//this.tabuleiro.pecas[this.ultimaLinhaEscolhida][this.ultimaColunaEscolhida].clicar(); //Atirar.
				jogada = new Jogada(this.ultimaLinhaEscolhida, this.ultimaColunaEscolhida);				
			}
			else {
				jogada = this.escolherJogada(); //Se já tiver atirado nessa posicao, escolher outra.
			}
			return jogada;
		}
		
		public function acertarAgua():void {
			this.matrizOponente[this.ultimaLinhaEscolhida][this.ultimaColunaEscolhida] = "A";
		}
		
		public function atingirPeca():void {
			this.matrizOponente[this.ultimaLinhaEscolhida][this.ultimaColunaEscolhida] = "P";
		}
		
		public function abaterEmbarcacao(embarcacaoAbatida:Embarcacao):void {			
			for (var i:int = 0; i < embarcacaoAbatida.pecas.length; i++) {
				this.matrizOponente[embarcacaoAbatida.pecas[i].linha][embarcacaoAbatida.pecas[i].coluna] = "F";
			}
			this.mostrarMatrizOponente();
		}
	}
	
}