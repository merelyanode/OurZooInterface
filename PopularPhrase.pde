public class PopularPhrase {
  
  private String phrase;
  private int count;
  
  public double x, y, z;
  
  public PopularPhrase(String phrase) {
    this.phrase = phrase;
    addRefrence();
  }
  
  public void addRefrence() {
    count++;
  }
  
  public int getNumberOfTimesUsed() {
    return count;
  }
  
  public String getPhrase() {
    return phrase;
  }
 
  public boolean equals(Object o) {
    return (o instanceof PopularPhrase) ? this.phrase.equalsIgnoreCase(((PopularPhrase) o).phrase) : this.phrase.equalsIgnoreCase((String) o);
  }
}
  
  
  
