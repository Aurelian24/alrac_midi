//ESCALA MAYOR : T T st T T T st

//ESCALA MENOR : T st T T st T T

class Keyboard {

  ArrayList<Particle> particles;
  ArrayList<Spring> springs;

  int desde;
  int hasta;
  int Nnotas;
  int Cantoctavas;
  int num_scale = -1;


  /*VARIABLES PARA REPRODUCIR SONIDO */
  int actualNote;
  boolean sube = true; //Si sube
  boolean REP = false;

  long LlastTime  = millis();
  long LlastTime2 = millis();
  Keyboard() {

    particles = new ArrayList<Particle>();
    springs = new ArrayList<Spring>();
    Nnotas = 12;
    Cantoctavas = 5;
    desde = width * 1/8;
    hasta = width * 7/8;

    for (int k=0; k<Cantoctavas; k++) {
      for (int j=0; j<Nnotas; j++) {
        Particle p = new Particle(new Vec3D(map(j, 0, Nnotas-1, desde, hasta), map(k, 0, 4, height * 2/8, height * 6/8), 0), j); 
        particles.add(p);
        p.lock();
      }
    }

    for (int i=0; i< particles.size()-1; i++) {

      if ( i % 12 != 11) {
        Particle a = particles.get(i);
        Particle b = particles.get(i+1);
        Spring s = new Spring(a, b, (hasta - desde) / Nnotas, 0);
        springs.add(s);
        physics.addSpring(s);
      }
    }

    Particle p1 = particles.get(0);
    p1.lock();
    Particle p2 = particles.get(particles.size()-1);
    p2.lock();

    //ULTIMA NOTA
    Particle p = new Particle(new Vec3D(width/2, height * 7/8, 0 ), 0);
    p.lock();
    particles.add(p);

    /* Spring s = new Spring(particles.get(particles.size()-1), particles.get(particles.size()-2), 150, 0.005);
     springs.add(s);
     physics.addSpring(s);*/
    actualNote = 0;
  }

  void display() {

    for (Spring p : springs) {
      p.display();
    }
    for (Particle p : particles) {
      p.run();
    }
    checkIsonscale(num_scale);
    if (REP) {
      reproducirEscala(time);
    }
  }

  void checkNoteOn(int _note) {
    particles.get(_note-36).isPressed = true;
  }

  void checkNoteOff(int _note) {
    particles.get(_note-36).isPressed = false;
  }

  void checkIsonscale(int _n) {

    //ESCALA MAYOR : T T st T T T st


    for (Particle p : particles) {
      p.isOnscale = false;
    }

    if (_n >= 0 && _n <12) {
      for (int k=0; k<60; k++) {
        if (k % 12 == _n % 12 ||
          k  % 12 == (_n + 2) % 12 || 
          k  % 12 == (_n + 4) % 12 || 
          k  % 12 == (_n + 5) % 12 || 
          k  % 12 == (_n + 7) % 12 ||
          k  % 12 == (_n + 9) % 12 ||
          k  % 12 == (_n + 11) % 12 ||
          k  % 12 == (_n + 12) % 12  ) {

          Particle p = particles.get(k);
          p.isOnscale = true;
        }
      }
    } else if (_n >= 12) {
      //println("COME ON");
      //ESCALA MENOR : T st T T st T T
      for (int k=0; k<60; k++) {
        //println("COME ON");
        if (k % 12 == _n % 12 ||
          k  % 12 == (_n+2) % 12 || 
          k  % 12 == (_n+3) % 12 || 
          k  % 12 == (_n+5) % 12 || 
          k  % 12 == (_n+7) % 12 ||
          k  % 12 == (_n+8) % 12 ||
          k  % 12 == (_n+10) % 12 ||
          k  % 12 == (_n+12) % 12   ) {

          Particle p = particles.get(k);
          p.isOnscale = true;
        }
      }
    }
  }

  public void reproducirEscala(long time) {
    //long lastTime  = millis();


    if (millis() - LlastTime > time ) { 

      if (actualNote == 59) {
        println("FIN ");
        println("NOTA FINAL:", actualNote);
        sube = false;
      } else if (actualNote == -1) {
        sube = true;
        actualNote = 0;
        keyboard.particles.get(actualNote).isPressed = false;
        REP = false;
      }

      if (REP) {
        particles.get(actualNote).isPressed = true;
        myBus.sendNoteOn(0, actualNote+36, 127); //Send a noteOn to OutgoingA and OutgoingC through busA

        if (sube) {
          if (actualNote > 0) {
            keyboard.particles.get(actualNote-1).isPressed = false;
            println("ACTUAL NOTE ", actualNote);
            myBus.sendNoteOff(0, actualNote+35, 50); //Send a noteOn to OutgoingA and OutgoingC through busA
          }
          actualNote++;
        } else {
          keyboard.particles.get(actualNote+1).isPressed = false;
          myBus.sendNoteOff(0, actualNote+37, 50); //Send a noteOn to OutgoingA and OutgoingC through busA
          println("ACTUAL NOTE ", actualNote);
          actualNote--;
        }
      }
      
      LlastTime = millis();
      //keyboard.particles.get(pitch-36).isPressed = true;
    }
  }
}