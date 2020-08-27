package bmpvis;

import java.awt.color.ColorSpace;
import java.util.*;
import java.io.*;

public class VisMain{
   private static int width = 800;
   private static int height = 800;
   private static long pixelDimensions;
   private static long pixelCount = 0;

   public static void main(String[] args) throws java.lang.InterruptedException{
      DataInputStream input_stream = null;
      try{
         input_stream = new DataInputStream(new BufferedInputStream(System.in,4096));
         //read first two values, should block for input
         width = input_stream.readUnsignedShort();
         System.out.println("here");
         height = input_stream.readUnsignedShort();
         System.out.println("Width, Height: "+width+" , "+height);
         pixelDimensions = (width * height);
         VisFrame vf = new VisFrame(width,height,ColorSpace.TYPE_RGB);
         vf.setVisible(true);

         //now lets go into reading pixels
         while(pixelCount < pixelDimensions){
            while(input_stream.available() >=3){
               //read 3 off
               vf.addPixel(input_stream.readUnsignedByte(), input_stream.readUnsignedByte(), input_stream.readUnsignedByte());
               pixelCount++;
            }
         }

      }catch(EOFException eof){
         eof.printStackTrace();
      }catch(IOException io){
         io.printStackTrace();
      }catch(Exception ex){
         ex.printStackTrace();
      }
   }

}
