import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JPanel;

public class Panel extends JPanel {

	private List<Pion> mesPions;
	private boolean victoire = false;
	private boolean echec = false;
	
	public Panel(){
		mesPions = new ArrayList<Pion>();
		super.setSize(800/Querifier.coef, 600/Querifier.coef);
	}
	
   public void paint(Graphics g) {
		Image img = createImageWithText();
		g.drawImage(img, 0,0,this);
	   if(victoire){
		   g.setColor(Color.BLACK);
		   Font fnt1 = new Font("Arial", Font.BOLD, 40/Querifier.coef);
		   g.setFont(fnt1);
		   g.drawString("YOUHOUCH !",350/Querifier.coef,390/Querifier.coef);
	   }
	   else if(echec){
		   g.setColor(Color.BLACK);
		   Font fnt1 = new Font("Arial", Font.BOLD, 40/Querifier.coef);
		   g.setFont(fnt1);
		   g.drawString("PERDU",370/Querifier.coef,390/Querifier.coef);
	   }
   }

   private Image createImageWithText(){
      BufferedImage bufferedImage = new BufferedImage(900/Querifier.coef,770/Querifier.coef,BufferedImage.TYPE_INT_RGB);
      Graphics g = bufferedImage.getGraphics();
      
      g.setColor(Color.LIGHT_GRAY);
      g.fillRect(0,0,900/Querifier.coef,770/Querifier.coef);
      
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
    	  int posX = (130*(current.getColonne()-1)+5)/Querifier.coef;
    	  int posY = (130*(5-current.getLigne()+1)+5)/Querifier.coef;
    	  g.fillOval(posX,posY, 100/Querifier.coef, 100/Querifier.coef);
      }
      return bufferedImage;
   }
   
   public void ajoutePion(Pion p){
	   mesPions.add(p);
	   this.repaint();
   }

   public void echec(){
	   echec = true;
	   this.repaint();
   }
   
   public void victoire(){
	   victoire = true;
	   this.repaint();
   }
   
}