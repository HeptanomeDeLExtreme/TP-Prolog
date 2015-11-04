import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Map;
import java.util.Random;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

import org.jpl7.Query;
import org.jpl7.Term;


public  class MainFrame extends JFrame{

	private JButton button1;
	private JButton button2;
	private JButton button3;
	private JButton button4;
	private JButton button5;
	private JButton button6;
	private JButton button7;
	private Panel panel;
		
	public MainFrame(){
		
		button1 = new JButton("   1  ");
		button1.addActionListener(new ActionListener()
		{
		  public void actionPerformed(ActionEvent e)
		  {
			  handlerButton(1);
		  }
		});
		button2 = new JButton("   2  ");
		button2.addActionListener(new ActionListener()
		{
		  public void actionPerformed(ActionEvent e)
		  {
			  handlerButton(2);
		  }
		});
		button3 = new JButton("   3  ");
		button3.addActionListener(new ActionListener()
		{
		  public void actionPerformed(ActionEvent e)
		  {
			  handlerButton(3);
		  }
		});
		button4 = new JButton("   4  ");
		button4.addActionListener(new ActionListener()
		{
		  public void actionPerformed(ActionEvent e)
		  {
			  handlerButton(4);
		  }
		});
		button5 = new JButton("   5  ");
		button5.addActionListener(new ActionListener()
		{
		  public void actionPerformed(ActionEvent e)
		  {
			  handlerButton(5);
		  }
		});
		button6 = new JButton("   6  ");
		button6.addActionListener(new ActionListener()
		{
		  public void actionPerformed(ActionEvent e)
		  {
			  handlerButton(6);
		  }
		});
		button7 = new JButton("   7  ");
		button7.addActionListener(new ActionListener()
		{
		  public void actionPerformed(ActionEvent e)
		  {
			  handlerButton(7);
		  }
		});
		panel = new Panel();
		
		this.setTitle("Box Layout");
	    this.setSize(900/Querifier.coef, 870/Querifier.coef);
	    this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	    this.setLocationRelativeTo(null);

	    JPanel b1 = new JPanel();
	    b1.setLayout(new BoxLayout(b1, BoxLayout.LINE_AXIS));
	    b1.add(panel);

	    JPanel b2 = new JPanel();
	    b2.setLayout(new BoxLayout(b2, BoxLayout.LINE_AXIS));
	    b2.add(button1);
	    b2.add(button2);
	    b2.add(button3);
	    b2.add(button4);
	    b2.add(button5);
	    b2.add(button6);
	    b2.add(button7);

	    JPanel b4 = new JPanel();
	    b4.setLayout(new BoxLayout(b4, BoxLayout.PAGE_AXIS));
	    b4.add(b1);
	    b4.add(b2);
			
	    this.getContentPane().add(b4);
	    
	    this.setResizable(false);
	    this.setVisible(true);
	    
	}
	
	public void handlerButton(int no){
		int numberElementInColon;
		try{
			Querifier.q = new Query("pion("+no+",LIGNE,JOUEUR)");
			Querifier.q.hasSolution();
			Map<String, Term>[] result = Querifier.q.allSolutions();
			numberElementInColon = result.length;
		}
		catch(Exception e){
			numberElementInColon = 0;
		}
		
		if(numberElementInColon>6){
			System.out.println("IMPOSSIBLE AJOUT");
		}
		else{
			String temp = "coupJoueur("+no+","+(numberElementInColon)+",1)";
			Querifier.q = new Query(temp);
			Querifier.q.hasSolution();
			this.print();
		}
	}
	
	public void print(){
		
		for(int j = 1; j<7;j++){
			// Query for the j-line
			Querifier.q = new Query("pion(COLONNE,"+j+",JOUEUR)");
			Querifier.q.hasSolution();
			 
			// Print the j-line
			Map<String, Term>[] result = Querifier.q.allSolutions();
			for(int i = 0;i<result.length;i++){
				int c = result[i].get("COLONNE").intValue();
				int jo = result[i].get("JOUEUR").intValue();
				panel.ajoutePion(new Pion(c,j,jo));
				System.out.println("Ajout pion : "+c+' '+j+' '+jo);
			}
			
		}

	}
	
	public void verifIa(int a){
		System.out.println("IA : "+a);
	}
	
	public void echec(){
		System.out.println("PERDU");
		panel.echec();
		this.disableButton();
	}

	public void disableButton(){
		button1.setEnabled(false);
		button2.setEnabled(false);
		button3.setEnabled(false);
		button4.setEnabled(false);
		button5.setEnabled(false);
		button6.setEnabled(false);
		button7.setEnabled(false);
	}
	
	public void victoire(){
		System.out.println("YOUHOUCH !");
		panel.victoire();
		this.disableButton();
	}
	
	public void printMessage(String s){
		panel.changeToPrint(s);
		System.out.println(s);
		panel.repaint();
		this.disableButton();
	}
	
	public static void main(String[] ars){
		new MainFrame();
	}
	
	
}

