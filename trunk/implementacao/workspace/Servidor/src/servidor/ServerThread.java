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
    GuiServidor gui;
    public ServerThread(int port,GuiServidor gui){
        this.port = port;
        this.gui = gui;
    }
    
    public void run(){
        server = new Servidor(port,this.gui);
        server.startServer();
    }
    
    public void stopConexao(){
      server.killServer();  
    }
}
