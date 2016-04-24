public class Word {
  
  private String word;
  private ArrayList<String> phrasesUsedIn;
  
  public double x, y, z;
  
  public Word(String word) {
    this.word = word;
    this.phrasesUsedIn = new ArrayList<String>();
  }
  
  public void addPhraseUsedIn(String phrase) {
    phrasesUsedIn.add(phrase);
  }
  
  public int getNumberOfTimesUsed() {
    return phrasesUsedIn.size();
  }
  
  public String getWord() {
    return word;
  }
  
  public ArrayList<String> getPhrasesUsedIn() {
    return phrasesUsedIn;
  }
 
  public boolean equals(Object o) {
    
    return (o instanceof PopularWord) ? this.word.equalsIgnoreCase(((PopularWord) o).word) : this.word.equalsIgnoreCase((String) o);
  }
}
