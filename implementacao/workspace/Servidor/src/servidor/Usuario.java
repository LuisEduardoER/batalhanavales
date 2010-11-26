/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package servidor;

/**
 *
 * @author Saulo
 */
public class Usuario {

    private String nome;
    private String senha;

    public Usuario(String nome,String senha) {
        this.nome = nome;
        this.senha = senha;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    @Override
    public String toString(){
        return ("usuario: "+this.getNome()+" >> senha: "+this.senha);
    }

    @Override
    public boolean equals(Object obj){
        boolean retorno = false;
        Usuario outro = (Usuario) obj;
//        System.out.println("nome outro:" +outro.nome);
//        System.out.println("senha outro:" +outro.senha);
//        System.out.println("nome: "+this.nome);
//        System.out.println("senha: "+this.senha);
//        System.out.println("nome = "+this.nome.equals(outro.nome));
//        System.out.println("senha = "+this.senha.equals(outro.senha));
        if((this.nome.equals(outro.nome)) && (this.senha.equals(outro.senha))){
            retorno = true;
        }

        return retorno;
    }

}
