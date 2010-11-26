/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package servidor;

/**
 *
 * @author Lorena Tablada
 */
public class Mensagem {

    private String nomeCliente;
    private int idCliente;
    private String tipo;
    private String texto;
    private int idDestinatario;
    private String senha;

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }


    public void Mensagem(){
        this.texto = "";
    }

    public String getNomeCliente() {
        return nomeCliente;
    }

    public void setNomeCliente(String nomeCliente) {
        this.nomeCliente = nomeCliente;
    }

    /**
     * @return o id do cliente
     */
    public int getIdCliente() {
        return idCliente;
    }

    /**
     * @return o tipo
     */
    public String getTipo() {
        return tipo;
    }

    /**
     * @return a mensagem
     */
    public String getTexto() {
        return texto;
    }

    /**
     * @param idCliente o id do cliente para setar
     */
    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    /**
     * @param tipo o tipo para setar
     */
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    /**
     * @param mensagem a mensagem para setar
     */
    public void setTexto(String texto) {
        this.texto = texto;
    }

    public int getDestinatario() {
        return idDestinatario;
    }

    public void setDestinatario(int destinatario) {
        this.idDestinatario = destinatario;
    }
}
