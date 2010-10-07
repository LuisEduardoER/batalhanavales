/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package servidor;

/**
 *
 * @author HAVANA
 */
public class ServerThread extends Thread{
    private int port;
    Servidor server;
    public ServerThread(int port){
        this.port = port;
    }
    
    public void run(){
        server = new Servidor(port);
        server.startServer();
    }
    
    public void stopConexao(){
      server.killServer();  
    }
}
