import org.jpl7.Query;

public class main {
	
	public static void main(String[] args){
		System.out.println("OPENING FILE");
		Querifier.q = new Query("consult('foo.pl')");
		System.err.println(Querifier.q.hasSolution());
		
		System.out.println("INITIALISATION");
		Querifier.q = new Query("init");
		System.err.println(Querifier.q.hasSolution());
		
		System.out.println("PRINT");
		Querifier.q = new Query("print");
		//System.err.println(Querifier.q.hasSolution());
		
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String temp = "assert(pion(2,2,1))";
		System.out.println(temp);
		Querifier.q = new Query(temp);
		//System.err.println(Querifier.q.hasSolution());
		
		System.out.println("PRINT");
		Querifier.q = new Query("print");
		//System.err.println(Querifier.q.hasSolution());
		
		Querifier.q = new Query("echec");
		//System.out.println(Querifier.q.hasSolution());
		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Querifier.q = new Query("victoire");
		//System.out.println(Querifier.q.hasSolution());
	}
	

}
