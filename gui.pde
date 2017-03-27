String [] Escalas = new String[24];

void IniciarControlP5() {
  notacionEscalas();
  println("ESCALAS LENGTH", Escalas.length);
  /* add a ScrollableList, by default it behaves like a DropdownList */
  for (int k=0; k<Escalas.length/2; k++) {
    Escalas[k] = Tnote[k] + "  Mayor" ;
  }
  for (int k=Escalas.length/2; k<Escalas.length; k++) {
    Escalas[k] = Tnote[k-Escalas.length/2] + "  Menor" ;
  }

  CColor c = new CColor();
  c.setBackground(paleta[1]);
  int offset = separacion;

  int botonW = 70;
  int botonH = 30;
 
  PFont Font2 = createFont("Dialog.bold", 10);
  cp5.addScrollableList("Escala")
    .setPosition(width * 1/20+offset, height * 1/16)
    .setSize(250, 120)
    .setBarHeight(30)
    .setItemHeight(30)
    .addItems(Escalas)
    .setColorLabel(paleta[6])
    .setBackgroundColor(paleta[4])
    .setColorForeground(paleta[3])
    .setFont(Font2)
    // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;

  cp5.addToggle("Notacion")
    .setPosition(350+offset+100, height * 1/16)
    .setSize(botonW, botonH)
    .setColorValueLabel(color(150, 150, 120))
    .setColorLabel(paleta[8])
    .setColorValue(color(150, 150, 188))
    .setLabel("Cifrado:\nAmericano | Latino")
    .setColorForeground(paleta[3])
    .setFont(Font2)
    ;
    
  cp5.addToggle("Tocarsolo")
    .setPosition(550+offset+100, height * 1/16)
    .setSize(botonW, botonH)
    .setColorLabel(paleta[8])
    .setLabel("Improvisar")
    .setColorForeground(paleta[3])
    .setFont(Font2)
    ;
  cp5.addBang("ReproducirEscala")
    .setPosition(750+offset+100, height * 1/16)
    .setSize(botonW, botonH)
    .setTriggerEvent(Bang.RELEASE)
    .setColorLabel(paleta[8])
    .setLabel("Tocar todas\n las notas")
    .setColorForeground(paleta[3])
    .setColorValue(color(255, 255, 255))
    .setFont(Font2)
    ;
  cp5.addKnob("tiempo")
    .setRange(50, 1000)
    .setValue(50)
    .setColorLabel(paleta[8])
    .setPosition(950+offset+100, height * 1/16)
    .setRadius(35)
    .setDragDirection(Knob.VERTICAL)
    .setColorForeground(paleta[3])
    .setColorBackground(paleta[1])
    .setColorActive(paleta[1])
    .setFont(Font2)
    ;
}

public void ReproducirEscala() {
  println("BANG BANG BANG");
  keyboard.REP = ! keyboard.REP;
}

void notacionEscalas() {
  for (int k=0; k<Escalas.length/2; k++) {
    Escalas[k] = Tnote[k] + "  Mayor" ;
  }
  for (int k=Escalas.length/2; k<Escalas.length; k++) {
    Escalas[k] = Tnote[k-Escalas.length/2] + "  Menor" ;
  }
}

void Notacion(boolean theFlag) {
  if (theFlag) {
    println("APRETADO TRUE");
    SetAOrTnotation(true);
    notacionEscalas();
    cp5.addScrollableList("Escala").clear()
      .setPosition(width * 1/20, height * 1/16)
      .setSize(150, 120)
      .setBarHeight(30)
      .setItemHeight(30)
      .addItems(Escalas)
      .setBackgroundColor(paleta[0])
      // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
      ;
  } else {
    println("APRETADO FALSE");
    SetAOrTnotation(false);
    notacionEscalas();
    cp5.addScrollableList("Escala").clear()
      .setPosition(width * 1/20, height * 1/16)
      .setSize(150, 120)
      .setBarHeight(30)
      .setItemHeight(30)
      .addItems(Escalas)
      .setBackgroundColor(paleta[0])
      // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
      ;
  }
  println("a toggle event.");
}
void tiempo(int theValue) {
  time = theValue;
  
}

void Escala(int n) {
  /* request the selected item based on index n */

  cp5.addScrollableList("Escala").clear()
    .setPosition(width * 1/20, height * 1/16)
    .setSize(150, 120)
    .setBarHeight(30)
    .setItemHeight(30)
    .addItems(Escalas)
    .setBackgroundColor(paleta[0])
    // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;

  CColor c = new CColor();
  c.setBackground(paleta[3]);
  cp5.get(ScrollableList.class, "Escala").getItem(n).put("color", c);
  // println(n, cp5.get(ScrollableList.class, "Escala").getItem(n));


  println(n);
  // keyboard.checkIsonscale(n);

  keyboard.num_scale = n ;
}

void Tocarsolo(boolean theFlag) {
  if (theFlag) {
    Setocasolo = true;
  } else {
    Setocasolo = false;
  }
}