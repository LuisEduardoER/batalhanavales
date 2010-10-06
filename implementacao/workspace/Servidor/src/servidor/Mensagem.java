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
    private int idCliente;
    private int tipo;
    private String mensagem;

    /**
     * @return o id do cliente
     */
    public int getIdCliente() {
        return idCliente;
    }

    /**
     * @return o tipo
     */
    public int getTipo() {
        return tipo;
    }

    /**
     * @return a mensagem
     */
    public String getMensagem() {
        return mensagem;
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
    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    /**
     * @param mensagem a mensagem para setar
     */
    public void setMensagem(String mensagem) {
        this.mensagem = mensagem;
    }
}
