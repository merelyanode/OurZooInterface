import controlP5.*;
import java.util.Date;
import java.util.ArrayList;
import javax.swing.JOptionPane;


final String CSV_FILE_PATH =  "data/zooMockUpCSV.csv";

boolean showVisual = false;

PImage img_1, img_2, img_3;
ControlP5 cp5;
String textValue = "";
String timestamp;

ArrayList<String> barredWords;
String[] wordsToIgnore;

ArrayList<PopularWord> mostPopularWords;
ArrayList<PopularPhrase> mostPopularPhrases;
ArrayList<Word> wordsToDisplay;

ArrayList<String> allEntries;

void setup() {
  img_1 = loadImage("roar2.png");
  img_2 = loadImage("theQuestion.png");
  img_3 = loadImage("instructions.png");
  size(1500,800, P3D);
  background(255);
  PFont font = createFont("arial",20);
  Date d = new Date();
  println(d.getTime());
  
  
  cp5 = new ControlP5(this);
  
  cp5.addTextfield("input")
     .setPosition(800,600)
     .setSize(600,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255))
     ;
  
  String[] barredFromFile = loadStrings("barredWords/barredWrdsEng.txt");
  
  barredWords = new ArrayList<String>();
  
  for (int i = 0; i < barredFromFile.length; i++) {
    
    String[] thisLine = barredFromFile[i].split("￼");
    
    for (int j = 0; j < thisLine.length; j++) {
      
      if (thisLine[j] != null && !thisLine[j].equals("") && !thisLine[j].equals(" ")) {
      
        barredWords.add(thisLine[j]);
        println("Added: " + thisLine[j]);
      } else {
       println("Threw out: " + thisLine[j]); 
      }
    }
  }
  
  allEntries = new ArrayList<String>();
  
  String[] entriesFromFile = loadStrings(CSV_FILE_PATH);
  
  for (int i = 1; i < entriesFromFile.length; i++) {
    
   println("Raw From File: " + entriesFromFile[i]);
   
   entriesFromFile[i] = entriesFromFile[i].substring(entriesFromFile[i].indexOf(",") + 1, entriesFromFile[i].length() - 2);
   
   allEntries.add(entriesFromFile[i]);
    
   println("Loaded From File: " + entriesFromFile[i]);
  }
  
  wordsToIgnore = loadStrings("wordsToIgnore.txt");
    
  /*  
  cp5.addTextfield("textValue")
     .setPosition(20,170)
     //.setSize(200,40)
     .setSize(100,40)
     .setFont(createFont("arial",20))
     .setAutoClear(false)
     ;
  
  cp5.addBang("clear")
     .setPosition(240,170)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;    
  
  cp5.addTextfield("default")
     .setPosition(20,350)
     .setAutoClear(false)
     ;
    */ 
  textFont(font);
}

void draw() {
  //background(0);
  
  if (!showVisual) {
  
  image(img_1, 5, 0);
  image(img_2, 650,215);
  image(img_3, 850,645);
  fill(0,255,0);
  //text(cp5.get(Textfield.class,"input").getText(), 360,130);
  text(textValue, 360,180);
  } else {
    drawVisual();
  }
  //text(textValue, 360,360);
}

public void clear() {
  cp5.get(Textfield.class,"textValue").clear();
  
}

void controlEvent(ControlEvent theEvent) {
}


public void input(String theText) {
  //public void enteryourphrase(String theText) {
  // automatically receives results from controller input
  
  if (showVisual) {
    println("SHOWING VISUAL, RETURNING");
    return;
  }
  
  if (theText.contains(",")) {
    JOptionPane.showMessageDialog(null, "Please avoid using longer phrases that inculde commas");
    println("RETURNING");
    return;
  }
  
  for (int i = 0; i < barredWords.size(); i++) {
     if (theText.contains(barredWords.get(i))) {
       JOptionPane.showMessageDialog(null, "That language is not Zoopropriate");
       println("RETURNING");
       return;
     }  
  }
  
  
  println("a mf textfield event for controller 'input' : "+theText);
   
  String[] savedEntries = loadStrings(CSV_FILE_PATH);
  
  String[] entriesToSave = new String[savedEntries.length + 1];
  
  for (int i = 0; i < savedEntries.length; i++) { 
     entriesToSave[i] = savedEntries[i];
  
     println("Read and copied saved phrase: " + entriesToSave[i]);   
  }
  
  String timestamp =  nf(month(),2) + "-" + nf(day(),2)  + "-" + year()+ "-"  
  + nf(hour(),2) + nf(minute(),2);
  
  println("Timestamp is: " + timestamp);
  
  entriesToSave[entriesToSave.length - 1] = timestamp + "," + theText + ",,";
  
  println("Latest entry: " +  entriesToSave[entriesToSave.length - 1]);
  
  saveStrings( CSV_FILE_PATH, entriesToSave);
  
  println("\"" + entriesToSave + "\" saved to \"" + CSV_FILE_PATH + "\"");

  allEntries.add(theText);

  recalculatePopularWords();

  recalculatePopularPhrases();
  
  setWordsToDisplay();
  
  setupVisual();
  
  showVisual = true;

}

public void recalculatePopularWords() {
  
  ArrayList<PopularWord> popularWords = new ArrayList<PopularWord>();
  
  for (int i = 0; i < allEntries.size(); i++) {
    
    String phrase = allEntries.get(i).replaceAll("[^a-zA-Z ]", "").toLowerCase().trim();
    
    String[] words = phrase.split(" ");
    
    for (int j = 0; j < words.length; j++) {
      words[j] = words[j].trim();
    }
    
    for (int j = 0; j < words.length; j++) {
      
      boolean movePast = false;
      
      for (int m = 0; m < wordsToIgnore.length; m++) {
       if (words[j].equalsIgnoreCase(wordsToIgnore[m])) {
         movePast = true;
         break;
       } 
      }
      
      if (movePast || words[j].length() < 1) {
        continue;
      }
      
      boolean foundMatch = false;
      
      for (int k = 0; k < popularWords.size(); k++) {
        
        if (popularWords.get(k).equals(words[j])) {
          
          println("Old entry: \"" + popularWords.get(k).getWord() + "\" matched with \"" + words[j] + "\"");
          
          popularWords.get(k).addPhraseUsedIn(phrase);
          foundMatch = true;
          break;
        }
      }
      
      if (!foundMatch) {
        println("The word \"" + words[j] + "\" is new and will be added");
        popularWords.add(new PopularWord(words[j], phrase));
      }
    }
  }
  
  mostPopularWords = new ArrayList<PopularWord>();
  
  for (int i = 0; i < 7; i++) {
    
    int maxValue = 0;
    int maxPos = 0;
    
    for (int j = 0; j < popularWords.size(); j++) {
      
      println("The word \"" + popularWords.get(j).getWord() + "\" has " + popularWords.get(j).getNumberOfTimesUsed() + " refrences");
      
      if (!mostPopularWords.contains(popularWords.get(j)) && popularWords.get(j).getNumberOfTimesUsed() > maxValue) {
        
        maxValue = popularWords.get(j).getNumberOfTimesUsed();
        maxPos = j;
        
      }
    }
      println("Picked \"" + popularWords.get(maxPos).getWord() + "\" for pos " + i + " because it had " + popularWords.get(maxPos).getNumberOfTimesUsed() + " refrences");
      mostPopularWords.add(popularWords.get(maxPos));
  }
  
  for (int i = 0; i < 7; i++) {
    println("Popular Word Number " + i + " is: \"" + mostPopularWords.get(i).getWord() + "\"");
  }
}

public void recalculatePopularPhrases() {
  
  ArrayList<PopularPhrase> popularPhrases = new ArrayList<PopularPhrase>();
  
  for (int i = 0; i < allEntries.size(); i++) {
    
    String curPhrase = allEntries.get(i).replaceAll("[^a-zA-Z ]", "").toLowerCase().trim();
    
    boolean foundMatch = false;
    
    for (int j = 0; j < popularPhrases.size(); j++) {
      
      if (popularPhrases.get(j).equals(allEntries.get(i))) {
       
       popularPhrases.get(j).addRefrence(); 
       foundMatch = true;
       break;
      }
    }
    
    if (!foundMatch) {
     popularPhrases.add(new PopularPhrase(curPhrase));
    }
  }
  
    mostPopularPhrases = new ArrayList<PopularPhrase>();
    
    for (int i = 0; i < 14; i++) {
    
    int maxValue = 0;
    int maxPos = 0;
    
    for (int j = 0; j < popularPhrases.size(); j++) {
      
      println("The phrase \"" + popularPhrases.get(j).getPhrase() + "\" has " + popularPhrases.get(j).getNumberOfTimesUsed() + " refrences");
      
      if (!mostPopularPhrases.contains(popularPhrases.get(j)) && popularPhrases.get(j).getNumberOfTimesUsed() > maxValue) {
        
        maxValue = popularPhrases.get(j).getNumberOfTimesUsed();
        maxPos = j;
        
      }
    }
      println("Picked \"" + popularPhrases.get(maxPos).getPhrase() + "\" for pos " + i + " because it had " + popularPhrases.get(maxPos).getNumberOfTimesUsed() + " refrences");
      mostPopularPhrases.add(popularPhrases.get(maxPos));
  }
  
  for (int i = 0; i < 14; i++) {
    println("Popular Phrase Number " + i + " is: \"" + mostPopularPhrases.get(i).getPhrase() + "\"");
  }
}

public void setWordsToDisplay() {
   
  int amountToWords = 200;
  
  int count = 0;
  
  wordsToDisplay = new ArrayList<Word>();
  
  for (int i = allEntries.size() - 1; i >= 0; i--) {
    
    if (mostPopularWords.contains(allEntries.get(i))) {
      continue;
    }
   
    Word curWord = new Word(allEntries.get(i));
    
    for (int j = 0; j < mostPopularPhrases.size(); j++) {
      
      if (mostPopularPhrases.get(j).getPhrase().contains(allEntries.get(i))) {
       
       curWord.addPhraseUsedIn(mostPopularPhrases.get(j).getPhrase());
        
      }
    }
    
    count++;
    
    if (count >= amountToWords) { 
      break;
    }
  } 
}


/*
a list of all methods available for the Textfield Controller
use ControlP5.printPublicMethodsFor(Textfield.class);
to print the following list into the console.

You can find further details about class Textfield in the javadoc.

Format:
ClassName : returnType methodName(parameter type)


controlP5.Controller : CColor getColor() 
controlP5.Controller : ControlBehavior getBehavior() 
controlP5.Controller : ControlWindow getControlWindow() 
controlP5.Controller : ControlWindow getWindow() 
controlP5.Controller : ControllerProperty getProperty(String) 
controlP5.Controller : ControllerProperty getProperty(String, String) 
controlP5.Controller : ControllerView getView() 
controlP5.Controller : Label getCaptionLabel() 
controlP5.Controller : Label getValueLabel() 
controlP5.Controller : List getControllerPlugList() 
controlP5.Controller : Pointer getPointer() 
controlP5.Controller : String getAddress() 
controlP5.Controller : String getInfo() 
controlP5.Controller : String getName() 
controlP5.Controller : String getStringValue() 
controlP5.Controller : String toString() 
controlP5.Controller : Tab getTab() 
controlP5.Controller : Textfield addCallback(CallbackListener) 
controlP5.Controller : Textfield addListener(ControlListener) 
controlP5.Controller : Textfield addListenerFor(int, CallbackListener) 
controlP5.Controller : Textfield align(int, int, int, int) 
controlP5.Controller : Textfield bringToFront() 
controlP5.Controller : Textfield bringToFront(ControllerInterface) 
controlP5.Controller : Textfield hide() 
controlP5.Controller : Textfield linebreak() 
controlP5.Controller : Textfield listen(boolean) 
controlP5.Controller : Textfield lock() 
controlP5.Controller : Textfield onChange(CallbackListener) 
controlP5.Controller : Textfield onClick(CallbackListener) 
controlP5.Controller : Textfield onDoublePress(CallbackListener) 
controlP5.Controller : Textfield onDrag(CallbackListener) 
controlP5.Controller : Textfield onDraw(ControllerView) 
controlP5.Controller : Textfield onEndDrag(CallbackListener) 
controlP5.Controller : Textfield onEnter(CallbackListener) 
controlP5.Controller : Textfield onLeave(CallbackListener) 
controlP5.Controller : Textfield onMove(CallbackListener) 
controlP5.Controller : Textfield onPress(CallbackListener) 
controlP5.Controller : Textfield onRelease(CallbackListener) 
controlP5.Controller : Textfield onReleaseOutside(CallbackListener) 
controlP5.Controller : Textfield onStartDrag(CallbackListener) 
controlP5.Controller : Textfield onWheel(CallbackListener) 
controlP5.Controller : Textfield plugTo(Object) 
controlP5.Controller : Textfield plugTo(Object, String) 
controlP5.Controller : Textfield plugTo(Object[]) 
controlP5.Controller : Textfield plugTo(Object[], String) 
controlP5.Controller : Textfield registerProperty(String) 
controlP5.Controller : Textfield registerProperty(String, String) 
controlP5.Controller : Textfield registerTooltip(String) 
controlP5.Controller : Textfield removeBehavior() 
controlP5.Controller : Textfield removeCallback() 
controlP5.Controller : Textfield removeCallback(CallbackListener) 
controlP5.Controller : Textfield removeListener(ControlListener) 
controlP5.Controller : Textfield removeListenerFor(int, CallbackListener) 
controlP5.Controller : Textfield removeListenersFor(int) 
controlP5.Controller : Textfield removeProperty(String) 
controlP5.Controller : Textfield removeProperty(String, String) 
controlP5.Controller : Textfield setArrayValue(float[]) 
controlP5.Controller : Textfield setArrayValue(int, float) 
controlP5.Controller : Textfield setBehavior(ControlBehavior) 
controlP5.Controller : Textfield setBroadcast(boolean) 
controlP5.Controller : Textfield setCaptionLabel(String) 
controlP5.Controller : Textfield setColor(CColor) 
controlP5.Controller : Textfield setColorActive(int) 
controlP5.Controller : Textfield setColorBackground(int) 
controlP5.Controller : Textfield setColorCaptionLabel(int) 
controlP5.Controller : Textfield setColorForeground(int) 
controlP5.Controller : Textfield setColorLabel(int) 
controlP5.Controller : Textfield setColorValue(int) 
controlP5.Controller : Textfield setColorValueLabel(int) 
controlP5.Controller : Textfield setDecimalPrecision(int) 
controlP5.Controller : Textfield setDefaultValue(float) 
controlP5.Controller : Textfield setHeight(int) 
controlP5.Controller : Textfield setId(int) 
controlP5.Controller : Textfield setImage(PImage) 
controlP5.Controller : Textfield setImage(PImage, int) 
controlP5.Controller : Textfield setImages(PImage, PImage, PImage) 
controlP5.Controller : Textfield setImages(PImage, PImage, PImage, PImage) 
controlP5.Controller : Textfield setLabel(String) 
controlP5.Controller : Textfield setLabelVisible(boolean) 
controlP5.Controller : Textfield setLock(boolean) 
controlP5.Controller : Textfield setMax(float) 
controlP5.Controller : Textfield setMin(float) 
controlP5.Controller : Textfield setMouseOver(boolean) 
controlP5.Controller : Textfield setMoveable(boolean) 
controlP5.Controller : Textfield setPosition(float, float) 
controlP5.Controller : Textfield setPosition(float[]) 
controlP5.Controller : Textfield setSize(PImage) 
controlP5.Controller : Textfield setSize(int, int) 
controlP5.Controller : Textfield setStringValue(String) 
controlP5.Controller : Textfield setUpdate(boolean) 
controlP5.Controller : Textfield setValue(float) 
controlP5.Controller : Textfield setValueLabel(String) 
controlP5.Controller : Textfield setValueSelf(float) 
controlP5.Controller : Textfield setView(ControllerView) 
controlP5.Controller : Textfield setVisible(boolean) 
controlP5.Controller : Textfield setWidth(int) 
controlP5.Controller : Textfield show() 
controlP5.Controller : Textfield unlock() 
controlP5.Controller : Textfield unplugFrom(Object) 
controlP5.Controller : Textfield unplugFrom(Object[]) 
controlP5.Controller : Textfield unregisterTooltip() 
controlP5.Controller : Textfield update() 
controlP5.Controller : Textfield updateSize() 
controlP5.Controller : boolean isActive() 
controlP5.Controller : boolean isBroadcast() 
controlP5.Controller : boolean isInside() 
controlP5.Controller : boolean isLabelVisible() 
controlP5.Controller : boolean isListening() 
controlP5.Controller : boolean isLock() 
controlP5.Controller : boolean isMouseOver() 
controlP5.Controller : boolean isMousePressed() 
controlP5.Controller : boolean isMoveable() 
controlP5.Controller : boolean isUpdate() 
controlP5.Controller : boolean isVisible() 
controlP5.Controller : float getArrayValue(int) 
controlP5.Controller : float getDefaultValue() 
controlP5.Controller : float getMax() 
controlP5.Controller : float getMin() 
controlP5.Controller : float getValue() 
controlP5.Controller : float[] getAbsolutePosition() 
controlP5.Controller : float[] getArrayValue() 
controlP5.Controller : float[] getPosition() 
controlP5.Controller : int getDecimalPrecision() 
controlP5.Controller : int getHeight() 
controlP5.Controller : int getId() 
controlP5.Controller : int getWidth() 
controlP5.Controller : int listenerSize() 
controlP5.Controller : void remove() 
controlP5.Controller : void setView(ControllerView, int) 
controlP5.Textfield : String getText() 
controlP5.Textfield : String[] getTextList() 
controlP5.Textfield : Textfield clear() 
controlP5.Textfield : Textfield keepFocus(boolean) 
controlP5.Textfield : Textfield setAutoClear(boolean) 
controlP5.Textfield : Textfield setColor(int) 
controlP5.Textfield : Textfield setColorCursor(int) 
controlP5.Textfield : Textfield setFocus(boolean) 
controlP5.Textfield : Textfield setFont(ControlFont) 
controlP5.Textfield : Textfield setFont(PFont) 
controlP5.Textfield : Textfield setFont(int) 
controlP5.Textfield : Textfield setHeight(int) 
controlP5.Textfield : Textfield setInputFilter(int) 
controlP5.Textfield : Textfield setPasswordMode(boolean) 
controlP5.Textfield : Textfield setSize(int, int) 
controlP5.Textfield : Textfield setText(String) 
controlP5.Textfield : Textfield setValue(String) 
controlP5.Textfield : Textfield setValue(float) 
controlP5.Textfield : Textfield setWidth(int) 
controlP5.Textfield : Textfield submit() 
controlP5.Textfield : boolean isAutoClear() 
controlP5.Textfield : boolean isFocus() 
controlP5.Textfield : int getIndex() 
controlP5.Textfield : void draw(PGraphics) 
controlP5.Textfield : void keyEvent(KeyEvent) 
java.lang.Object : String toString() 
java.lang.Object : boolean equals(Object) 

created: 2015/03/24 12:21:31

*/


