/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package servidor;

/**
 *
 * @author Saulo
 */
import java.io.IOException;
import java.nio.BufferUnderflowException;
import java.nio.channels.ClosedChannelException;
import org.xsocket.*;
import org.xsocket.connection.*;

public class ServidorHandler implements IDataHandler
{

    public boolean onData(INonBlockingConnection nbc) throws IOException, BufferUnderflowException, ClosedChannelException, MaxReadSizeExceededException
    {
        try
        {
            String data = nbc.readStringByDelimiter("\0");
           nbc.write(data + "\0");
            String [] decodificado = data.split("#");
            if(decodificado[1].equals("conectar")){
                nbc.write("conexão de "+decodificado[0]+" aceita."+"\0");
            }

            if(data.equalsIgnoreCase("SHUTDOWN"))
                Main.shutdownServer();
        }
        catch(Exception ex)
        {
            System.out.println(ex.getMessage());
        }

        return true;
    }
}
