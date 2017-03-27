
class Spring extends VerletSpring3D {
  float border;
  color colorStroke;
  Spring(Particle p1, Particle p2,float _long,float _elasticity) {

    super(p1, p2, _long, _elasticity);
    
    border = p1.border;
    colorStroke = p1.colorStroke;
    
  }

  void display() {
    SHSBA();
    line(a.x, a.y,a.z, b.x, b.y,b.z);
  }
  void SHSBA(){
    strokeWeight(border);
    stroke(colorStroke);
  }
  
}