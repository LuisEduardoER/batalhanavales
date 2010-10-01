/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package servidor;
import org.xsocket.connection.*;
/**
 *
 * @author Saulo
 */
public class Main {
    // protected static IServer srv = null;
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
       Servidor servidor = new Servidor(8090);
        
    }
    /*protected static void shutdownServer()
    {
        try
        {
            srv.close();
        }
        catch(Exception ex)
        {
            System.out.println(ex.getMessage());
        }
    }*/

}
