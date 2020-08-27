
import java.awt.image.BufferedImage;
import java.io.*;


import javax.imageio.ImageIO;

public class PictureCompiler {
    
    /**
     * stupid simple RGB source generator from jpg to RGB
     * bmp-like format for input to the encode. This micro
     * benchmark takes in bmp image format. This code is
     * also useful for debugging the end result. 
     */

	public static void main(String[] args) {
		try {
			File inputFile = new File("knuth_don.jpg");
			File outputFile = new File("picturespec.txt");
			PrintWriter out = new PrintWriter(outputFile);
			BufferedImage bufferedImage;
		
			bufferedImage = ImageIO.read(inputFile);

			int width = bufferedImage.getWidth();
			int height = bufferedImage.getHeight(null);
			
			width -= width % 8;
			height -= height % 8;
			
			out.println("" + width + " " + height);

			int rgbValue;
			for(int j = 0; j < height; j+=8){
				for(int k = 0; k < width; k+=8){
					for(int y = 0; y < 8; ++y)
						for(int x = 0; x < 8; ++x){
							rgbValue = bufferedImage.getRGB(k + x, j + y) & 0xFFFFFF;
							out.print("" + rgbValue + " ");
						}
				}
			}
			
			out.flush();
			out.close();
		}
		catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
