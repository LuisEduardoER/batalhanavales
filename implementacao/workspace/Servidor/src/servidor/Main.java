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
     protected static IServer srv = null;
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        try
        {
            srv = new Server(8090, new ServidorHandler());
            srv.run();
        }
        catch(Exception ex)
        {
            System.out.println(ex.getMessage());
        }
    }
    protected static void shutdownServer()
    {
        try
        {
            srv.close();
        }
        catch(Exception ex)
        {
            System.out.println(ex.getMessage());
        }
    }

}
