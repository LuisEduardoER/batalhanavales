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
               mensagemResposta2.setTexto( this.cliente.getNome() + "," + this.cliente.getIdCliente() + "," + this.cliente.getEstado() );
               mensagemResposta2.setTipo("eventoEntradaJogador");
               this.servidor.broadcastMessage(mensagemResposta2);
               break;

           case 2://envioNome
               this.cliente.setNome(this.mensagem.getTexto());
               this.servidor.writeActivity(this.cliente.getIdCliente() + " => " + this.cliente.getNome() + " conectado ao servidor.");
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
           case 5://conviteOponente
               this.mensagem.setNomeCliente(this.cliente.getNome());
               this.mensagem.setIdCliente(this.cliente.getIdCliente());
               Cliente destinatarioConvite = this.servidor.procurarCliente(this.mensagem.getDestinatario());
               this.servidor.enviarMensagem(this.mensagem, destinatarioConvite);
               break;
           case 6://cancelamentoConvite
               this.mensagem.setNomeCliente(this.cliente.getNome());
               this.mensagem.setIdCliente( this.cliente.getIdCliente() );
               Cliente destinatarioCancelamentoConvite = this.servidor.procurarCliente(this.mensagem.getDestinatario());
               this.servidor.enviarMensagem(this.mensagem, destinatarioCancelamentoConvite);
               break;
           case 7://aceitacaoConvite
               Cliente convidador = this.servidor.procurarCliente(this.mensagem.getDestinatario());
               this.servidor.enviarMensagem(this.mensagem, convidador);
               this.servidor.adicionarDupla(this.cliente, convidador);
               System.out.println("convidador.getNome() = " + convidador.getNome());

               Mensagem msgMudancaEstado = new Mensagem();
               msgMudancaEstado.setTipo("mudancaEstado");
               msgMudancaEstado.setDestinatario(this.mensagem.getDestinatario());
               msgMudancaEstado.setIdCliente(this.cliente.getIdCliente());
               msgMudancaEstado.setTexto("Jogando");
               this.servidor.broadcastMessage(msgMudancaEstado);
               break;
           case 8://recusaConvite
               Cliente convidador2 = this.servidor.procurarCliente(this.mensagem.getDestinatario());
               this.servidor.enviarMensagem(this.mensagem, convidador2);
               break;

       }
        
    }

    private int mapearTipo(String tipo){
        int retorno = -1;
        if(tipo.equals("pedidoJogadores"))retorno = 1;
        else if(tipo.equals("envioNome"))retorno = 2;
        else if(tipo.equals("conversaPublica"))retorno = 3;
        else if(tipo.equals("conversaPrivada"))retorno = 4;
        else if(tipo.equals("conviteOponente"))retorno = 5;
        else if(tipo.equals("cancelamentoConvite"))retorno = 6;
        else if(tipo.equals("aceitacaoConvite"))retorno = 7;
        else if(tipo.equals("recusaConvite"))retorno = 8;

        return retorno;
    }


}
