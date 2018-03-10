/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package csvtojson2;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Collections;

/**
 *
 * @author SBWin
 */
public class CSVtoJSON2
{

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args)
    {
        ArrayList<String> fields = new ArrayList<>();
        ArrayList<String> values = new ArrayList<>();
        ArrayList<Node> nodes = new ArrayList<>();
//        ArrayList<Field> nodeFields = new ArrayList<>();
        FileReader file;
        BufferedReader br = null;
        FileWriter fileToWrite;
        BufferedWriter bw = null;
        String[] valuesArray;
        String[] fieldsArray;
        Node node;
        try{
            file = new FileReader("test.csv");
            br = new BufferedReader(file);
            fileToWrite = new FileWriter("test.json");
            bw = new BufferedWriter(fileToWrite);
        }catch(IOException e){
            System.out.println("Error opening file: " + e);
        }
        String line = "";
        try{
            if( br != null && (line = br.readLine()) != null){
                fieldsArray = line.split(",");
                System.out.println(line);
//                for(int i=0; i<86; i++){
//                    System.out.print("fieldsArray: " + fieldsArray[i]);
//                }
                Collections.addAll(fields, fieldsArray);
            }
            while(br != null && (line = br.readLine()) != null){
                valuesArray = line.split(",");
                node = new Node(valuesArray);
//                node = new Node(valuesArray[0], valuesArray[1], valuesArray[2], valuesArray[3], valuesArray[4], valuesArray[5], valuesArray[6], valuesArray[7], valuesArray[8], valuesArray[9], valuesArray[10], valuesArray[11], valuesArray[12], valuesArray[13], valuesArray[14], valuesArray[15], valuesArray[16], valuesArray[17], valuesArray[18], valuesArray[19], valuesArray[20], valuesArray[21], valuesArray[22], valuesArray[23], valuesArray[24], valuesArray[25], valuesArray[26], valuesArray[27], valuesArray[28], valuesArray[29], valuesArray[30], valuesArray[31], valuesArray[32], valuesArray[33], valuesArray[34], valuesArray[35], valuesArray[36], valuesArray[37], valuesArray[38], valuesArray[39], valuesArray[40], valuesArray[41], valuesArray[42], valuesArray[43], valuesArray[44], valuesArray[45], valuesArray[46], valuesArray[47], valuesArray[48], valuesArray[49], valuesArray[50], valuesArray[51], valuesArray[52], valuesArray[53], valuesArray[54], valuesArray[55], valuesArray[56], valuesArray[57], valuesArray[58], valuesArray[59], valuesArray[60], valuesArray[61], valuesArray[62], valuesArray[63], valuesArray[64], valuesArray[65], valuesArray[66], valuesArray[67], valuesArray[68], valuesArray[69], valuesArray[70], valuesArray[71], valuesArray[72], valuesArray[73], valuesArray[74], valuesArray[75], valuesArray[76], valuesArray[77], valuesArray[78], valuesArray[79], valuesArray[80], valuesArray[81], valuesArray[82], valuesArray[83], valuesArray[84], valuesArray[85]);
                nodes.add(node);
            }
            if(br != null)
                br.close();
            if(bw != null)
                bw.write("[\n");
            else
                return;
            for(int i = 0; i < (nodes.size() -1 );i++){
                node = nodes.get(i);
                writeNode(node,fields,bw);
                bw.write(",\n");
            }
            node = nodes.get(nodes.size()-1);
            writeNode(node,fields,bw);
            bw.write("\n");
            bw.write("]");
            bw.close();
        }catch(IOException e){
            System.out.println("Error reading line from file: " + e);
        }
//        filereader
//        nodes.forEach(action);
    }
    public static void writeNode(Node node, ArrayList<String> fields, BufferedWriter bw){
        try{
            bw.write("\t{\n");
            Class nodeClass = Class.forName("csvtojson2.Node");
            int i = 0;
            for(Field f: nodeClass.getDeclaredFields()){
                f.setAccessible(true);
                if(!f.getName().equals("simTimeSlipRate")){
                    bw.write("\t\t\"" + fields.get(i) + "\": " +"\"" + f.get(node) + "\",\n");
                    i++;
                }else{
                    bw.write("\t\t\"" + fields.get(fields.size()-1) + "\": " +"\"" + f.get(node) + "\"\n");
                    bw.write("\t}");
                }
                f.setAccessible(false);
            }            
            System.out.println("File written");
        }catch(IOException | ClassNotFoundException | IllegalAccessException | IllegalArgumentException | SecurityException e){
            System.out.println("Error writing node to file");
        }
        
    }
}
