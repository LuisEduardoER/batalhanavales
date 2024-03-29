/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package teste;

/**
 *
 * @author Saulo
 */
import java.io.File;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class XMLReader {

 public static void main(String argv[]) {

  try {
  File file = new File("F:\\faculdade\\Mestrado\\ES\\Projeto_svn\\implementacao\\workspace\\Servidor\\src\\teste\\Usuarios.xml");
  DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
  DocumentBuilder db = dbf.newDocumentBuilder();
  Document doc = db.parse(file);
  doc.getDocumentElement().normalize();
  System.out.println("Root element " + doc.getDocumentElement().getNodeName());
  NodeList nodeLst = doc.getElementsByTagName("usuario");
  System.out.println("Information of all employees");

  for (int s = 0; s < nodeLst.getLength(); s++) {

    Node fstNode = nodeLst.item(s);

    if (fstNode.getNodeType() == Node.ELEMENT_NODE) {

           Element fstElmnt = (Element) fstNode;
      NodeList fstNmElmntLst = fstElmnt.getElementsByTagName("nome");
      Element fstNmElmnt = (Element) fstNmElmntLst.item(0);
      NodeList fstNm = fstNmElmnt.getChildNodes();
      System.out.println("First Name : "  + ((Node) fstNm.item(0)).getNodeValue());
      NodeList lstNmElmntLst = fstElmnt.getElementsByTagName("senha");
      Element lstNmElmnt = (Element) lstNmElmntLst.item(0);
      NodeList lstNm = lstNmElmnt.getChildNodes();
      System.out.println("Last Name : " + ((Node) lstNm.item(0)).getNodeValue());
    }

  }
  } catch (Exception e) {
    e.printStackTrace();
  }
 }
}