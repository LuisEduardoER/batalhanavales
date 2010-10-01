package teste;

import java.io.*;
import java.net.*;

public class CSCliente extends Thread {
    private Thread thrThis; 
    private Socket socket;
    private Servidor server;
    private String ip; 
    protected BufferedReader in;
    protected PrintWriter out;
    
    private int id;
    private static int count = 0;

    public CSCliente(Servidor server, Socket socket) {
    	this.id = CSCliente.count++;
    	
        this.server = server;
        this.socket = socket;
        this.ip = socket.getInetAddress().getHostAddress();
        
        try {
            in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            out = new PrintWriter(socket.getOutputStream(), true);
        } catch(IOException ioe) {
            server.writeActivity("Client IP: " + ip + " n�o p�de ser inicializado e foi desconectado.");
            killClient();
        }
    }

    public void run() {
        try {
            char charBuffer[] = new char[1];
            
            while(in.read(charBuffer,0,1) != -1) {
                StringBuffer stringBuffer = new StringBuffer(8192);
                while(charBuffer[0] != '\0') {
                    stringBuffer.append(charBuffer[0]);
                    in.read(charBuffer, 0 ,1);
                }
                
                server.broadcastMessage(stringBuffer.toString());
            }
        } catch(IOException ioe) {
            server.writeActivity("IP do Cliente: " + ip + " causou um erro de leitura " 
            + ioe + " : " + ioe.getMessage() + "e foi desconectado.");
        } finally {
            killClient();
        }
    }

    public String getIP() {
        return ip;
    }
    
    public long getId() {
		return id;
	}

    public void send(String message) {
        out.print(message);
        
        if(out.checkError()) {
            server.writeActivity("IP do Cliente: " + ip + " causou um erro de escrita "
            + "e foi desconectado.");
            killClient();
        }
    }
   
    private void killClient() {
        server.removeClient(this);

        try {
            in.close();
            out.close();
            socket.close();            
            thrThis = null;
        } catch (IOException ioe) {
            server.writeActivity("IP do Cliente: " + ip + " causou um erro  "
            + "enquanto desconectava.");
        }       
    }
}