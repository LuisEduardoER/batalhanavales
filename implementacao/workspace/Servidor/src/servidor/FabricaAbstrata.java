/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package servidor;

/**
 *
 * @author Saulo
 */
abstract class FabricaAbstrata {

    public static FabricaAbstrata getFabricaUsuario(){
        return new FabricaUsuario();
    }

    public abstract Usuario criarUsuario(String nome, String senha);
}
