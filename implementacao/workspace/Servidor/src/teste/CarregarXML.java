/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package teste;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.xml.sax.SAXException;
import servidor.CarregadorUsuarios;
import servidor.Usuario;

/**
 *
 * @author Saulo
 */
public class CarregarXML {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException {
        CarregadorUsuarios carregar = new CarregadorUsuarios();
        try {
            ArrayList<Usuario> lista = carregar.listarUsuarios("F:\\faculdade\\Mestrado\\ES\\Projeto_svn\\implementacao\\workspace\\Servidor\\src\\teste\\Usuarios.xml");
            //        File arquivo = new File("F:\\faculdade\\Mestrado\\ES\\Projeto_svn\\implementacao\\workspace\\Servidor\\src\\teste\\Usuarios.xml");
            //        FileReader reader;
            //        BufferedReader leitor;
            //        String xml = null;
            //
            //        XStream xstream = new XStream(new DomDriver());
            //        try {
            //            // TODO code application logic here
            //            reader = new FileReader(arquivo);
            //            leitor = new BufferedReader(reader);
            //            String linha = "";
            //            while((linha != null)){
            //                try {
            //                    linha = leitor.readLine();
            //                    System.out.println("linha: " +linha);
            //                    if(linha != null){
            //                        xml += linha+"\r";
            //                    }
            //                } catch (IOException ex) {
            //                    Logger.getLogger(CarregarXML.class.getName()).log(Level.SEVERE, null, ex);
            //                }
            //            }
            //            List usuarios = (List) xstream.fromXML(xml);
            //            System.out.println(usuarios.get(0));
            //
            //            leitor.close();
            //            reader.close();
            //        } catch (FileNotFoundException ex) {
            //            Logger.getLogger(CarregarXML.class.getName()).log(Level.SEVERE, null, ex);
            //        }
        } catch (SAXException ex) {
            Logger.getLogger(CarregarXML.class.getName()).log(Level.SEVERE, null, ex);
        }

        

    }

}
