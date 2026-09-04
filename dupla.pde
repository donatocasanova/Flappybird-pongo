public class DuplaDeTubos {
  private Cuadrado tuboSuperior;
  private Cuadrado tuboInferior;
  private boolean puntoContado = false;

  public DuplaDeTubos(float x, float espacioVacio) {
    float altoArriba = random(100, 350);
    float altoAbajo = height - altoArriba - espacioVacio;

    tuboSuperior = new Cuadrado(x, 0, 70, altoArriba, true);
    tuboInferior = new Cuadrado(x, altoArriba + espacioVacio, 70, altoAbajo, true);
  }

  public void mover() {
    tuboSuperior.mover();
    tuboInferior.mover();
  }

  public void mostrar() {
    tuboSuperior.mostrar();
    tuboInferior.mostrar();
  }

  public boolean colisionaCon(Circulo c) {
    return tuboSuperior.colisionaConCirculo(c) || tuboInferior.colisionaConCirculo(c);
  }

  public boolean evaluarPunto(Circulo c) {
    if (!puntoContado && tuboSuperior.getPosicion().x + tuboSuperior.getAncho() < c.getPosicion().x) {
      puntoContado = true;
      return true;
    }
    return false;
  }

  public boolean fueraDePantalla() {
    return tuboSuperior.getPosicion().x + tuboSuperior.getAncho() < 0;
  }
}
