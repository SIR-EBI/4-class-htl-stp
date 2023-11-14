public class Schueler implements Comparable<Schueler> {

    private String nachname;
    private String vorname;
    private String geschlecht;
    private int nummer;
    private String klasse;

    public Schueler(String line) {
        try {
            String[] data = line.split(",");
            this.nachname = data[0];
            this.vorname = data[1];
            this.geschlecht = data[2];
            this.nummer = Integer.parseInt(data[3]);
            this.klasse = data[4];
        } catch (Exception e) { }
    }

    public String getNachname() {
        return nachname;
    }

    public String getVorname() {
        return vorname;
    }

    public String getGeschlecht() {
        return geschlecht;
    }

    public int getNummer() {
        return nummer;
    }

    public String getKlasse() {
        return klasse;
    }

    @Override
    public String toString() {
        return klasse + "/" + nummer + " " + nachname + " " + vorname + " " + geschlecht;
    }

    @Override
    public int compareTo(Schueler s) {
        if (s.getKlasse() == null || this.getKlasse() == null) {
            return 0;
        }
        if (s.getKlasse().equals(this.getKlasse())) {
            if (s.getNummer() == this.getNummer()) {
                return 0;
            }
            return this.getNummer() - s.getNummer();
        }
        return this.getKlasse().compareTo(s.getKlasse());
    }

}
