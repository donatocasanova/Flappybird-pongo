public class Circulo {
  private PVector pos;
  private PVector vel;
  private PVector acc;
  private float radio;
  private boolean esFlappyBird;

  public Circulo(float x, float y, float radio, boolean esFlappyBird) {
    this.pos = new PVector(x, y);
    this.radio = radio;
    this.esFlappyBird = esFlappyBird;
    this.acc = new PVector(0, 0);

    if (esFlappyBird) {
      this.vel = new PVector(0, 0);
    } else {
      float vx = random(1) > 0.5 ? 5 : -5;
      float vy = random(-3, 3);
      this.vel = new PVector(vx, vy);
    }
  }

  public void addFuerza(PVector fuerza) {
    acc.add(fuerza);
  }

  public void mover() {
    vel.add(acc);
    if (esFlappyBird) vel.limit(10);
    pos.add(vel);
    acc.mult(0);
  }

  public void saltar() {
    if (esFlappyBird) vel.y = -9;
  }

  public void contenerEnPantalla(float altoPantalla) {
    if (pos.y - radio < 0 || pos.y + radio > altoPantalla) {
      vel.y *= -1;
    }
  }

  public void resetear(float x, float y) {
    pos.set(x, y);
    vel.set(random(1) > 0.5 ? 5 : -5, random(-3, 3));
  }

  public void mostrar() {
    if (esFlappyBird) {
      fill(255, 220, 0);
      ellipse(pos.x, pos.y, radio * 2, radio * 2);
      fill(0);
      ellipse(pos.x + 7, pos.y - 7, 5, 5);
      fill(255, 100, 0);
      triangle(pos.x + radio, pos.y, pos.x + radio + 12, pos.y - 5, pos.x + radio + 12, pos.y + 5);
    } else {
      fill(255);
      ellipse(pos.x, pos.y, radio * 2, radio * 2);
    }
  }
  public PVector getPosicion() {
    return pos.copy();
  }

  public float getRadio() {
    return radio;
  }

  public void setPosicionX(float x) {
    this.pos.x = x;
  }

  public void invertirVelocidadX() {
    this.vel.x *= -1;
  }
}
