class Particle extends VerletParticle3D {

  float r;

  color colorStroke;
  float border;

  color colorShape_Default;
  color colorShape_Pressed;
  color colorShape_Onscale;

  boolean isPressed;
  boolean isOnscale;

  //String txt_note;

  int notenumber;


  Particle(Vec3D pos, int _notenumber) {
    super(pos);

    isPressed = false;
    isOnscale = false;

    colorStroke = paleta[4] ;

    //colorShape_Default = paleta[1];

    colorShape_Default = paleta[1];
    colorShape_Pressed = paleta[2];
    colorShape_Onscale = paleta[3];

    border = tamanioborde;
    r = 50;
    physics.addParticle(this);
    //physics.addBehavior(new AttractionBehavior2D(this, r*4, 15));

    notenumber = _notenumber;
  }

  void run() {
    display();
    update();
  }
  void display() {
    pushMatrix();
    translate(x, y, z);
    scale(6, 00.2, 8);
    SHSBA();
    displayShape();
    popMatrix();
  }

  void update() {
    if (isPressed) {
      if ( z < loquesaleenelejez) {
        z+=velocidadenlaquesale;
      }  
      if (r <tamaniomaximodecaja) {
        r+=5;
      }
      
    } else {
      if (z > 0) {
        z-=velocidadenlaquesale;
      }
      if (r > 50) {
        r-=5;
      }
    }
  }
  void displayShape() {

    box(r);
    //ellipse(0, 0, r*2, r*2);
    //rect(0,0,r*2,r*2);
    //textSize(18);

    if (isPressed) {
      fill(paleta[5]);
    } else {
      fill(paleta[6]);
    }
    // translate(0,-r/2,z+r/2);
    textLeading(14);
    text(Tnote[notenumber], 0, -2.5, r/2+5);
  }
  void SHSBA() {
    if (isPressed && isOnscale) {
      fill(colorShape_Pressed);
    }
    else if (isOnscale) {
      fill(colorShape_Onscale);
    } else if (isPressed){
      fill(paleta[7]);
    } else{
      fill(colorShape_Default); 
    }
    
    stroke(colorStroke);
    strokeWeight(border);
  }

  /*boolean estaAgarrado(){
   if (mousePressed && this.isInCircle(new Vec2D(mouseX,mouseY),r)){
   return true; 
   }
   else {
   return false;
   }
   }*/
}