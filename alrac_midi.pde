/* 
Alrac Midi

Soft para utilizar un piano midi. que hace cosas. 
Explicado en este video : https://youtu.be/FiKOqkpA9hY

Este soft claramente no esta terminado porque carla me saco el piano antes de terminarlo.
de todos modos el piano era de ella. Si, fija que el nombre Alrac esta dedicado a la compañera de lucha
heroina del universo y genia carla.
Carla gracias por tanto

Hecho por Jpupper
Facebook : Jpupper*/




import toxi.util.events.*;
import toxi.util.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.geom.*;



import java.util.*;

import themidibus.*; //Import the library
import controlP5.*;


VerletPhysics3D physics;

ControlP5 cp5;
MidiBus myBus; // The MidiBus



String [] Tnote = new String[12];
color [] paleta = new color [10];

Keyboard keyboard;

PFont Font;
float angle;

int actualNote = 50;
long lastTime = 0;
long lastTime2 = 0;

boolean Setocasolo = false;
long time = 20;
float tamanioborde;
float tamaniomaximodecaja;
float loquesaleenelejez;
float velocidadenlaquesale;
int separacion;

PImage img;
void setup() {

  fullScreen(P3D);
  colorMode(HSB);
  textAlign(CENTER, CENTER);

  /*Font = loadFont("FranklinGothic-Heavy-54.vlw");
   textFont(Font);*/
  String[] fontList = PFont.list();
  printArray(fontList);
  Font = createFont("Dialog.bold", 18);
  textFont(Font);
  
  paleta[0] = color(#E5EEC1, 250); //FONDO
  paleta[1] = color(#39AEA9, 150); //Color por defecto
  paleta[2] = color(#557B83, 150);  //Color presionado
  paleta[3] = color(#336B7E, 250); // Color en escala
  paleta[4] = color(0, 0, 255, 150); //Bordes
  paleta[5] = color(255, 255, 0); // Color de texto por defecto
  paleta[6] = color(255, 0, 255); // Color de texto seleccionado  
  paleta[7] = color(#BC464F);
  paleta[8] = color(#0D2D35); //COLOR DEL TEXTO DEL GUI
  
  tamanioborde = 3;
  tamaniomaximodecaja = 75;
  loquesaleenelejez = 150;
  velocidadenlaquesale = 8;
  separacion = 50;
  SetAOrTnotation(false);
  cp5 = new ControlP5(this);
  IniciarControlP5();
  iniciarMidi();
  physics = new VerletPhysics3D();
  physics.addBehavior(new GravityBehavior3D (new Vec3D(0, 1, 0))); //Gravedad s
  // Set the world's bounding box
  //physics.setWorldBounds(new Rect(0, 0, width, height));
  keyboard = new Keyboard();

  lastTime  = millis();
  lastTime2 = millis();
  
  img = loadImage("logo.png");
}
void draw() {
  //background(0);
 background(paleta[0]);
  physics.update();

  pushMatrix();
  rotateX(radians(5));
  keyboard.display();
  popMatrix();

  float tiempo = map(mouseX, 0, width, 100, 1000);
  //println("velocidad :",tiempo);
  
  if(Setocasolo){
  RandomNotes(time);
  }
  // RandomNotes(500);
  image(img, 1250+separacion,  height * 7/8,458/2,195/2);
}

void SetAOrTnotation(boolean IsAmericannotes) {
  for (int k=0; k<=11; k++) {
    if (IsAmericannotes) {
      switch(k) {
      case 0:
        Tnote[k] = "C";
        break;
      case 1:
        Tnote[k] = "C#\nDb";
        break;
      case 2:
        Tnote[k] = "D";
        break;
      case 3:
        Tnote[k] = "D#\nEb";
        break;
      case 4:
        Tnote[k] = "E";
        break;
      case 5:
        Tnote[k] = "F";
        break;
      case 6:
        Tnote[k] = "F#\nGb";
        break;
      case 7:
        Tnote[k] = "G";
        break;
      case 8:
        Tnote[k] = "G#Ab";
        break;
      case 9:
        Tnote[k] = "A";
        break;
      case 10:
        Tnote[k] = "A#\nBb";
        break;
      case 11:
        Tnote[k] = "B";
        break;
      }
    } else {
      switch(k) {
      case 0:
        Tnote[k] = "Do";
        break;
      case 1:
        Tnote[k] = "Do#\nReb";
        break;
      case 2:
        Tnote[k] = "Re";
        break;
      case 3:
        Tnote[k] = "Re#\nMib";
        break;
      case 4:
        Tnote[k] = "Mi";
        break;
      case 5:
        Tnote[k] = "Fa";
        break;
      case 6:
        Tnote[k] = "Fa#\nSolb";
        break;
      case 7:
        Tnote[k] = "Sol";
        break;
      case 8:
        Tnote[k] = "Sol#\nLab";
        break;
      case 9:
        Tnote[k] = "La";
        break;
      case 10:
        Tnote[k] = "La#\nSib";
        break;
      case 11:
        Tnote[k] = "Si";
        break;
      }
    }
  }
}

void RandomNotes(float _tiempo) {
  int channel = 0;
  int e ;
  int pitch;
  int velocity = 150;

  if ( millis() - lastTime > _tiempo ) {
    channel = 0;
    e = parseInt(random(1, 4));
    println(e);
    if (e == 1 && actualNote < 96) {
      actualNote+=1;
    }
    if (e == 3 && actualNote > 36) {
      actualNote-=1;
    }

    pitch = actualNote;

    myBus.sendNoteOn(channel, pitch, velocity); //Send a noteOn to OutgoingA and OutgoingC through busA
    keyboard.particles.get(pitch-36).isPressed = true;
   
    /*myBus.sendNoteOn(channel, pitch+2, velocity); //Send a noteOn to OutgoingA and OutgoingC through busA
    keyboard.particles.get(pitch-36+2).isPressed = true;
    
     myBus.sendNoteOn(channel, pitch+5, velocity); //Send a noteOn to OutgoingA and OutgoingC through busA
    keyboard.particles.get(pitch-36+5).isPressed = true;*/
    /*println("Actual note :", actualNote);
    println("--------------");*/
    lastTime = millis();

  }

  if ( millis() - lastTime2 > _tiempo ) {
    println("WHY");
    
    for (int j=0; j<keyboard.particles.size()-1; j++) {
      keyboard.particles.get(j).isPressed = false;
      myBus.sendNoteOff(channel, actualNote, velocity); //Send a noteOn to OutgoingA and OutgoingC through busA
    }
    
    lastTime2 = millis();
  }
}