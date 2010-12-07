/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package servidor;

/**
 *
 * @author Saulo
 */
class FabricaUsuario extends FabricaAbstrata {

    public FabricaUsuario() {
    }

    @Override
    public Usuario criarUsuario(String nome, String senha) {
        return new Usuario(nome,senha);
    }


}
