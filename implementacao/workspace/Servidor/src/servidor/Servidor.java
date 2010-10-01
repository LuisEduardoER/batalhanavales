package servidor;



import java.util.*;
import java.io.*;
import java.net.*;


public class Servidor {
    private Vector<Cliente> clients = new Vector<Cliente>();
    ServerSocket server;
    //private GuiServidor gui;

    public Servidor(int port/*, GuiServidor gui*/) {
        //this.gui = gui;
        startServer(port);
        
    }

	private void startServer(int port) {
        writeActivity("Inicializando o Servidor");
        
        try {
            server = new ServerSocket(port);
            writeActivity("Servidor inicializado na porta: " + port);

            while(true) {
                Socket socket = server.accept();
                Cliente client = new Cliente(this, socket);
                writeActivity(client.getId() + " => " + client.getIP() + " conectado ao servidor.");
                
                clients.addElement(client);
                
                int id = (int)client.getId();
               
                client.start();		
               
                broadcastMessage("<dados tipo='conecta' id='" + client.getId() + "' info='" + clients.size() + "'/>");
                
            }
        } catch(IOException ioe) {
            writeActivity("Erro do Servidor...Parando o Servidor");
            
            killServer();
        } 
    }

    public synchronized void broadcastMessage(String message) { 
       
        message += '\0';
        
        System.out.println(message);

        Enumeration enume = clients.elements();
        while (enume.hasMoreElements()) {
            Cliente client = (Cliente)enume.nextElement();
            client.send(message);
        }

    }

    public void removeClient(Cliente client) {
        writeActivity(client.getIP() + " deixou o servidor.");
        
        clients.removeElement(client);
        
        broadcastMessage("<dados tipo='qtd' id='" + client.getId() + "' info='" + clients.size() + "'/>");        
    }

    public void writeActivity(String activity) {
        Calendar cal = Calendar.getInstance();
        activity = "[" + cal.get(Calendar.DAY_OF_MONTH) 
                 + "/" + (cal.get(Calendar.MONTH) + 1) 
                 + "/" + cal.get(Calendar.YEAR) 
                 + " " 
                 + cal.get(Calendar.HOUR_OF_DAY) 
                 + ":" + cal.get(Calendar.MINUTE) 
                 + ":" + cal.get(Calendar.SECOND) 
                 + "] " + activity + "\n";
        System.out.print(activity);
       // this.gui.mostrarMensagem("teste qualquer mensagem");
    }

    protected void killServer() {
        try {
            server.close();
            writeActivity("O servidor foi parado!");
        } catch (IOException ioe) {
            writeActivity("Erro enquanto parava o servidor");
        }
    }
    
    /*public static void main(String args[]) {
    	Servidor servidor = new Servidor(8080);
    }*/
}
