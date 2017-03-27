void iniciarMidi(){
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, 0, 3); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device. 
}
void noteOn(int _channel, int _pitch, int _velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  showMidivalues(_channel,_pitch,_velocity);
  
  keyboard.checkNoteOn(_pitch) ;
}

void noteOff(int _channel, int _pitch, int _velocity) {

  // Receive a noteOff
   println();
   println("Note Off:");
   println("--------");
   showMidivalues(_channel,_pitch,_velocity);
  
  keyboard.checkNoteOff(_pitch) ;
  // velocity = _velocity;
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange

  println();
  println("Controller Change:");
  println("--------");

  showMidivalues(channel, number, value);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}


void showMidivalues(int _channel, int _pitch, int _velocity) {

  println("Channel:"+_channel);
  println("Pitch:"+_pitch);
  println("Velocity:"+_velocity);
}