public class Cuadrado {
  private PVector pos;
  private float ancho, alto;
  private float velocidad = 4;
  private boolean esTubo;

  public Cuadrado(float x, float y, float ancho, float alto, boolean esTubo) {
    this.pos = new PVector(x, y);
    this.ancho = ancho;
    this.alto = alto;
    this.esTubo = esTubo;
  }

  public void mover() {
    if (esTubo) {
      pos.x -= velocidad;
    }
  }

  public void moverArriba(float v) {
    pos.y -= v;
  }

  public void moverAbajo(float v) {
    pos.y += v;
  }

  public void contenerEnPantalla(float altoPantalla) {
    pos.y = constrain(pos.y, 0, altoPantalla - alto);
  }

  public void mostrar() {
    if (esTubo) {
      fill(40, 180, 70);
      rect(pos.x, pos.y, ancho, alto);
      fill(30, 150, 60);
      if (pos.y == 0) {
        rect(pos.x - 5, pos.y + alto - 25, ancho + 10, 25);
      } else {
        rect(pos.x - 5, pos.y, ancho + 10, 25);
      }
    } else {
      fill(255);
      rect(pos.x, pos.y, ancho, alto, 5);
    }
  }

  public boolean colisionaConCirculo(Circulo c) {
    PVector cPos = c.getPosicion();
    float cRadio = c.getRadio();

    float cercanoX = constrain(cPos.x, pos.x, pos.x + ancho);
    float cercanoY = constrain(cPos.y, pos.y, pos.y + alto);

    float distX = cPos.x - cercanoX;
    float distY = cPos.y - cercanoY;

    return (distX * distX + distY * distY) < (cRadio * cRadio);
  }

  public PVector getPosicion() {
    return pos.copy();
  }

  public float getAncho() {
    return ancho;
  }

  public float getAlto() {
    return alto;
  }
}
