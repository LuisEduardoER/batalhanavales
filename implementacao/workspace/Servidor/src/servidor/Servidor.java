package servidor;



import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import java.util.*;
import java.io.*;
import java.net.*;


public class Servidor {
    private Vector<Cliente> clients = new Vector<Cliente>();
    private ArrayList<ArrayList> clientes = new ArrayList<ArrayList>();
    ServerSocket server;
    private int port;
    private GuiServidor gui;

    public Servidor(int port, GuiServidor gui) {
        this.port = port;
        //startServer(port);
        this.gui = gui;
        
    }

    public void startServer() {
        writeActivity("Inicializando o Servidor");
        
        try {
            server = new ServerSocket(this.port);
            writeActivity("Servidor inicializado na porta: " + port);

            while(true) {
                Socket socket = server.accept();
                
                Cliente client = new Cliente(this, socket);
                writeActivity(client.getId() + " => " + client.getIP() + " conectado ao servidor.");
                
                
                clients.addElement(client);
                /*Teste de Array de clientes*/
                this.adicionarCliente(client, 0);
                System.out.println("linha cliente = "+this.procurarIdCliente(client));
                /*Fim teste*/
                
                int id = (int)client.getId();
               
                client.start();		
               
               //broadcastMessage("<dados tipo='conecta' id='" + client.getId() + "' info='" + clients.size() + "'/>");
                if(clients.size() == 2){
                  //  broadcastMessage("<dados tipo='liberacao' />");
                    System.out.println("size = 2");
                }
                
            }
        } catch(IOException ioe) {
            writeActivity("Erro do Servidor...Parando o Servidor");
            
            killServer();
        } 
    }

    public synchronized void broadcastMessage(Mensagem mensagem) {
       
        //teste de xstream
        //String xml = xstream

        Enumeration enume = clients.elements();
        while (enume.hasMoreElements()) {
            Cliente cliente = (Cliente)enume.nextElement();
            this.enviarMensagem(mensagem, cliente);
        }

    }

    public synchronized void enviarMensagem(Mensagem mensagem, Cliente cliente) {
        XStream stream = new XStream(new DomDriver());
        String xml = stream.toXML(mensagem);
        xml += '\0';
        System.out.println("enviando xml = " + xml);
        
        cliente.send(xml);
    }

    public void lerMensagem(String msg, Cliente cliente){
        XStream stream = new XStream(new DomDriver());
        Mensagem mensagemLida = (Mensagem) stream.fromXML(msg);
        System.out.println("recebendo xml = " + stream.toXML(mensagemLida));
        InterpretadorMensagem interpretador = new InterpretadorMensagem(this,mensagemLida,cliente);
        //this.interpretarMensagem(mensagemLida, cliente);
    }

//    private void interpretarMensagem(Mensagem msg, Cliente cliente){
//        String tipo = msg.getTipo();
//        System.out.println("tipo = " + tipo);
//        Mensagem mensagemResposta = new Mensagem();
//        if( tipo.equals("pedidoJogadores") ){
//           mensagemResposta.setTexto(this.getNomesJogadores());
//           mensagemResposta.setTipo("respostaPedidoJogadores");
//           this.enviarMensagem(mensagemResposta, cliente);
//        }
//        else if( tipo.equals("envioNome") ){
//            cliente.setNome(msg.getTexto());
//        }
//    }

    public String getNomesJogadores(){
        String retorno = new String();
        Enumeration enume = clients.elements();
        while (enume.hasMoreElements()) {
            Cliente cliente = (Cliente)enume.nextElement();
            retorno += cliente.getNome() + ",";
        }
        enume = clients.elements();
        while(enume.hasMoreElements()){
            Cliente cliente = (Cliente)enume.nextElement();
            retorno += cliente.getId();
            if(cliente.getId() != clients.get(clients.size()-1).getId()){
                retorno += ",";
            }
        }
        return retorno;
    }

    public void removeClient(Cliente client) {
        writeActivity(client.getIP() + " deixou o servidor.");        
        clients.removeElement(client);             
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
       this.gui.mostrarMensagem(activity);
    }

    protected void killServer() {
        try {
            server.close();
            writeActivity("O servidor foi parado!");
        } catch (IOException ioe) {
            writeActivity("Erro enquanto parava o servidor");
        }
    }

    protected void adicionarCliente(Cliente cliente, int linha){
        if(this.clientes.isEmpty()){
            this.clientes.add(new ArrayList<Cliente>());
            this.clientes.get(0).add(cliente);
        }else{
            if(this.clientes.get(linha) != null){
                this.clientes.get(linha).add(cliente);
            }else{
                this.clientes.add(new ArrayList<Cliente>());
                this.clientes.get(linha).add(cliente);
            }
        }
    }

    protected int procurarIdCliente(Cliente cliente){
        int retorno = -1;
        for(int i = 0;i<this.clientes.size();i++){
            if(this.clientes.get(i).indexOf(cliente) != -1){
                retorno = i;
                break;
            }
        }
        return retorno;
    }

    protected Cliente procurarCliente(int id){
       Cliente retorno = null;
       Enumeration enume = clients.elements();
        while (enume.hasMoreElements()) {
           retorno = (Cliente)enume.nextElement();
           if( (retorno).getId() == id ){
                break;
           }
        }
       return retorno;
    }
    
    /*public static void main(String args[]) {
    	Servidor servidor = new Servidor(8080);
    }*/
}
