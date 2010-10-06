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
    private String tipo;
    private String texto;

    public void Mensagem(){
        this.texto = "";
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

    public String criarXML(){
        String retorno = new String();
        retorno += "<dados>";
        retorno += "<tipo>" + this.tipo + "</tipo>";
        retorno += "<id>" + this.idCliente + "</id>";
        retorno += "<mensagem>" + this.texto + "</mensagem>";
        retorno += "</dados>";
        return retorno;
    }
}
