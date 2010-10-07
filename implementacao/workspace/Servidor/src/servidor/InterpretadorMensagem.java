/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package servidor;

/**
 *
 * @author Saulo
 */
public class InterpretadorMensagem {
    private Servidor servidor;
    private Mensagem mensagem;
    private Cliente cliente;


    public InterpretadorMensagem(Servidor servidor,Mensagem mensagem, Cliente cliente) {
        this.servidor = servidor;
        this.mensagem = mensagem;
        this.cliente = cliente;
        this.interpretar();

    }

    private void interpretar(){
        String tipo = this.mensagem.getTipo();

       switch(this.mapearTipo(tipo)){
           case 1://pedidoJogadores
               Mensagem resposta = new Mensagem();
               resposta.setTipo("respostaPedidoJogadores");
               resposta.setTexto(this.servidor.getNomesJogadores());
               this.servidor.broadcastMessage(resposta);
           break;
           case 2://enviarNome
               this.cliente.setNome(this.mensagem.getTexto());
           break;

       }
        
    }

    private int mapearTipo(String tipo){
        int retorno = -1;
        if(tipo.equals("pedidoJogadores"))retorno = 1;
        else if(tipo.equals("envioNome"))retorno = 2;

        return retorno;
    }


}
