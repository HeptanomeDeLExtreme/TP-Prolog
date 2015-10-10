import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JPanel;

public class Panel extends JPanel {

	private List<Pion> mesPions;
	
	public Panel(){
		mesPions = new ArrayList<Pion>();
		super.setSize(800, 600);
	}
	
   public void paint(Graphics g) {
      Image img = createImageWithText();
      g.drawImage(img, 0,0,this);
   }

   private Image createImageWithText(){
      BufferedImage bufferedImage = new BufferedImage(900,770,BufferedImage.TYPE_INT_RGB);
      Graphics g = bufferedImage.getGraphics();
      
      g.setColor(Color.LIGHT_GRAY);
      g.fillRect(0,0,900,770);
      
      for(int i = 0;i<mesPions.size();i++){
    	  Pion current = mesPions.get(i);
    	  Color color;
    	  if(current.getJoueur()==1){
    		  color = Color.RED;
    	  }
    	  else{
    		  color = Color.YELLOW;
    	  }
    	  g.setColor(color);
    	  int posX = 130*(current.getColonne()-1)+5;
    	  int posY = 130*(5-current.getLigne()+1)+5;
    	  g.fillOval(posX,posY, 100, 100);
      }
      System.err.println("CREATE IMAGE");
      return bufferedImage;
   }
   
   public void ajoutePion(Pion p){
	   mesPions.add(p);
	   this.repaint();
	   System.err.println("AJOUTE PION");
   }
   
}