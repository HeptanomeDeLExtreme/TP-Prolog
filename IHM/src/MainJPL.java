import java.util.Map;


import org.jpl7.Query;
import org.jpl7.Term;
 
public class MainJPL {
 
	public static void main(String[] args) {
		
		// Instanciate the query
		Query q;
		
		// Load the file
		q = new Query("consult('foo.pl')");
		System.err.println(q.hasSolution());
		
//		for(int j = 1; j<6;j++){
//			// Query for the i-line
//			q = new Query("pion(COLONNE,"+j+",JOUEUR)");
//			System.err.println(q.hasSolution());
//			 
//			// Print the i-line
//			System.out.println("Ligne "+j+" :");
//			Map<String, Term>[] result = q.allSolutions();
//			for(int i = 0;i<result.length;i++){
//				System.out.println(result[i].get("COLONNE")+" "+result[i].get("JOUEUR"));
//			}
//			
//		}
		
		q = new Query("print");
		System.err.println(q.hasSolution());
		
	}
	
	public static void coucou(){
		System.out.println("Coucou");
	}
	
}
