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
               Mensagem mensagemResposta = new Mensagem();
               mensagemResposta.setTexto(this.servidor.getNomesJogadores());
               mensagemResposta.setTipo("respostaPedidoJogadores");
               this.servidor.enviarMensagem(mensagemResposta, cliente);

               Mensagem mensagemResposta2 = new Mensagem();
               mensagemResposta2.setTexto( this.cliente.getNome() + "," + this.cliente.getId() );
               mensagemResposta2.setTipo("eventoEntradaJogador");
               this.servidor.broadcastMessage(mensagemResposta2);
               break;

           case 2://enviarNome
               this.cliente.setNome(this.mensagem.getTexto());
               this.servidor.writeActivity(this.cliente.getId() + " => " + this.cliente.getNome() + " conectado ao servidor.");
               break;

           case 3://conversaPublica
               this.mensagem.setNomeCliente(this.cliente.getNome());
               this.servidor.broadcastMessage(this.mensagem);
               break;

           case 4://conversaPrivada
               this.mensagem.setNomeCliente(this.cliente.getNome());
               Cliente destinatario = this.servidor.procurarCliente(this.mensagem.getDestinatario());
               this.servidor.enviarMensagem(this.mensagem, destinatario);
               this.servidor.enviarMensagem(this.mensagem, this.cliente);
               break;

       }
        
    }

    private int mapearTipo(String tipo){
        int retorno = -1;
        if(tipo.equals("pedidoJogadores"))retorno = 1;
        else if(tipo.equals("envioNome"))retorno = 2;
        else if(tipo.equals("conversaPublica"))retorno = 3;
        else if(tipo.equals("conversaPrivada"))retorno = 4;

        return retorno;
    }


}
