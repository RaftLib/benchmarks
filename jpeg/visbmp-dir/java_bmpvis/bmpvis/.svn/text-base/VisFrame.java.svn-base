package bmpvis;

import javax.swing.JFrame;
import javax.swing.ScrollPaneConstants;
import javax.swing.JScrollPane;
import java.awt.Container;
import java.awt.Graphics;
import java.awt.color.ColorSpace;
import java.awt.Color;
import java.awt.Point;
import java.awt.Canvas;
import java.awt.Dimension;
import java.util.ArrayList;
import java.util.ConcurrentModificationException;

public class VisFrame extends JFrame{

   private static Integer width = 0;
   private static Integer height = 0;
   private static JScrollPane scrollPane = null;
   private static VisCanvas canvas = null;
   private static Graphics graphics = null;
   private static int count = 0;

   public VisFrame(int WIDTH, int HEIGHT, int cs){
      //do nothing with cs right now
      width = WIDTH;
      height = HEIGHT;
      init();
      setVisible(true);
   }
   public VisFrame(int WIDTH, int HEIGHT){
      width = WIDTH;
      height = HEIGHT;
      init();
      setVisible(true);
      graphics = getGraphics();
  }

   private void init(){
      setSize(1080,760);
      setTitle("Streaming Graphics Viewer");
      setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
      getContentPane().setBackground(Color.DARK_GRAY);
//      setResizable(true);
      canvas = new VisCanvas();
      canvas.setSize(width,height);
      canvas.setBackground(Color.DARK_GRAY);
      canvas.setVisible(true);
      scrollPane = new JScrollPane(canvas, ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS, ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
      getContentPane().add(scrollPane);
      addComponentListener(new java.awt.event.ComponentAdapter() {
            public void componentResized(java.awt.event.ComponentEvent evt) {
                frameComponentResized(evt);
            }
      });
            
  }

   public void frameComponentResized(java.awt.event.ComponentEvent evt){
      //work on this later
   }

   public synchronized void addPixel(int r,int g,int b){
      Color color = new Color(r,g,b);
      canvas.queuePixel(color);
   }

   class VisCanvas extends Canvas{
      private ArrayList<Color> new_pixels = null;
      private int current_x = 0;
      private int current_y = 0;

      public VisCanvas(){
         new_pixels = new ArrayList<Color>();
      }

      public void update(Graphics g){
         super.update(g); 
      }


      @Override
      public void paint(Graphics g){
         try{
            for(int i = 0; i< new_pixels.size(); i++){
               Color color = new_pixels.get(i);
               g.setColor(color);
               Point point = increment();
               g.fillRect((int) point.getX(), (int) point.getY(), 1,1);
               g.drawRect((int)point.getX(), (int) point.getY(), 1,1);
            }
         }catch(ConcurrentModificationException cm){
            cm.printStackTrace();
         }catch(Exception ex){
            ex.printStackTrace();
        }
      }

      public void queuePixel(Color pixel){
         new_pixels.add(pixel);
      }

      private Point increment(){
         Point point = new Point(current_x,current_y);
         if(current_x == (width - 1)){
            current_y+=1;
            current_x = 0;
         }else{
            ++current_x;
         }
         return point;
      }

   }

}
