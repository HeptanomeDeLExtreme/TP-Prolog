import org.jpl7.Query;

public class main {
	
	public static void main(String[] args){
		System.out.println("OPENING FILE");
		Querifier.q = new Query("consult('foo.pl')");
		System.err.println(Querifier.q.hasSolution());
		
		System.out.println("INITIALISATION");
		Querifier.q = new Query("init");
		System.err.println(Querifier.q.hasSolution());
		

	}
	

}
