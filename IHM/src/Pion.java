
public class Pion {

	private int colonne;
	private int ligne;
	private int joueur;
	
	public Pion(int colonne, int ligne, int joueur) {
		this.colonne = colonne;
		this.ligne = ligne;
		this.joueur = joueur;
	}

	public int getColonne() {
		return colonne;
	}

	public int getLigne() {
		return ligne;
	}

	public int getJoueur() {
		return joueur;
	}

	
}
