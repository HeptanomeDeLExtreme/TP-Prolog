import java.util.Map;
import org.jpl7.Query;
import org.jpl7.Term;


public class eval {
	public static void main(String[] args){
		Query q = new Query("consult('foo.pl')");
		q.hasSolution();
		q = new Query("lancerEval");
		q.allSolutions();
	}
	
	public static void print(String nbEssai,String J1,String J2){
		System.out.println("hehe"+nbEssai);
	}
}
