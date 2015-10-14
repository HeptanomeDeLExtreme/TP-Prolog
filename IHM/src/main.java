import org.jpl7.Query;

public class main {
	
	public static void main(String[] args){
		System.out.println("OPENING FILE");
		Querifier.q = new Query("consult('foo.pl')");
		Querifier.q.hasSolution();
		
		System.out.println("INITIALISATION");
		Querifier.q = new Query("init");
		Querifier.q.hasSolution();
	}

	public static void debug(String s){
		System.out.println(s);
	}
	
	public static void init(MainFrame f){
		Querifier.maFenetre = f;
	}
	
	public static void echec(){
		Querifier.maFenetre.echec();
	}
	
	public static void victoire(){
		Querifier.maFenetre.victoire();
	}

}
