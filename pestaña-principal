public static final int ESTADO_MENU = 0;
public static final int ESTADO_JUGANDO_FLAPPY = 1;
public static final int ESTADO_JUGANDO_PONG = 2;
public static final int ESTADO_GAME_OVER = 3;

private int estadoDelJuego = ESTADO_MENU;
private int juegoSeleccionado = 0; // 1: Flappy, 2: Pong

private ArrayList<DuplaDeTubos> tubos;
private Circulo bird;
private float ultimoPar = 0;
private int puntajeFlappy = 0;
private PVector gravedad = new PVector(0, 0.5);

private Circulo pelotaPong;
private Cuadrado paleta1, paleta2;
private int puntajeP1 = 0, puntajeP2 = 0;
private boolean wPresionada, sPresionada, oPresionada, lPresionada;

void setup() {
  size(800, 600);
  tubos = new ArrayList<DuplaDeTubos>();
}

void draw() {
  switch (estadoDelJuego) {
    case ESTADO_MENU:
      dibujarMenu();
      break;
    case ESTADO_JUGANDO_FLAPPY:
      actualizarYMostrarFlappy();
      break;
    case ESTADO_JUGANDO_PONG:
      actualizarYMostrarPong();
      break;
    case ESTADO_GAME_OVER:
      dibujarGameOver();
      break;
  }
}

private void dibujarMenu() {
  background(30, 30, 40);
  
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(42);
  text("MENÚ DE JUEGOS", width / 2, 100);
  
  textSize(20);
  fill(200);
  text("Seleccioná un juego para empezar:", width / 2, 160);

  fill(135, 206, 235);
  rect(width / 2 - 150, 230, 300, 80, 15);
  fill(0);
  textSize(28);
  text("1. Flappy Bird", width / 2, 270);

  fill(50, 200, 100);
  rect(width / 2 - 150, 350, 300, 80, 15);
  fill(0);
  textSize(28);
  text("2. Pong (2 Jugadores)", width / 2, 390);

  fill(150);
  textSize(16);
  text("Presioná [1] o [2] en el teclado, o hacé clic en las opciones.", width / 2, 520);
}

private void iniciarFlappy() {
  bird = new Circulo(150, height / 2, 20, true);
  tubos.clear();
  puntajeFlappy = 0;
  ultimoPar = millis();
  juegoSeleccionado = ESTADO_JUGANDO_FLAPPY;
  estadoDelJuego = ESTADO_JUGANDO_FLAPPY;
}

private void iniciarPong() {
  pelotaPong = new Circulo(width / 2, height / 2, 12, false);
  paleta1 = new Cuadrado(30, height / 2 - 50, 15, 100, false);
  paleta2 = new Cuadrado(width - 45, height / 2 - 50, 15, 100, false);
  puntajeP1 = 0;
  puntajeP2 = 0;
  juegoSeleccionado = ESTADO_JUGANDO_PONG;
  estadoDelJuego = ESTADO_JUGANDO_PONG;
}

private void dibujarGameOver() {
  fill(0, 180);
  rect(0, 0, width, height);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(50);
  text("GAME OVER", width / 2, height / 2 - 60);

  textSize(24);
  if (juegoSeleccionado == ESTADO_JUGANDO_FLAPPY) {
    text("Puntaje Final: " + puntajeFlappy, width / 2, height / 2);
  } else {
    text("Resultado Final: " + puntajeP1 + " - " + puntajeP2, width / 2, height / 2);
  }

  textSize(18);
  fill(220);
  text("Presioná [ESPACIO] para Volver a Jugar", width / 2, height / 2 + 70);
  text("Presioná [M] para Volver al Menú Principal", width / 2, height / 2 + 100);
}
private void actualizarYMostrarFlappy() {
  background(135, 206, 235);

  if (millis() - ultimoPar > 1800) {
    tubos.add(new DuplaDeTubos(width, 170));
    ultimoPar = millis();
  }

  bird.addFuerza(gravedad);
  bird.mover();

  for (int i = tubos.size() - 1; i >= 0; i--) {
    DuplaDeTubos dupla = tubos.get(i);
    dupla.mover();
    dupla.mostrar();

    if (dupla.colisionaCon(bird)) {
      estadoDelJuego = ESTADO_GAME_OVER;
    }

    if (dupla.evaluarPunto(bird)) {
      puntajeFlappy++;
    }

    if (dupla.fueraDePantalla()) {
      tubos.remove(i);
    }
  }

  if (bird.getPosicion().y - bird.getRadio() < 0 || bird.getPosicion().y + bird.getRadio() > height) {
    estadoDelJuego = ESTADO_GAME_OVER;
  }

  bird.mostrar();

  fill(255);
  textAlign(CENTER, TOP);
  textSize(40);
  text(puntajeFlappy, width / 2, 20);
}
private void actualizarYMostrarPong() {
  fill(0, 40);
  rect(0, 0, width, height);

  if (wPresionada) paleta1.moverArriba(7);
  if (sPresionada) paleta1.moverAbajo(7);
  if (oPresionada) paleta2.moverArriba(7);
  if (lPresionada) paleta2.moverAbajo(7);

  paleta1.contenerEnPantalla(height);
  paleta2.contenerEnPantalla(height);

  pelotaPong.mover();
  pelotaPong.contenerEnPantalla(height);

  if (paleta1.colisionaConCirculo(pelotaPong)) {
    pelotaPong.invertirVelocidadX();
    pelotaPong.setPosicionX(paleta1.getPosicion().x + paleta1.getAncho() + pelotaPong.getRadio());
  }
  if (paleta2.colisionaConCirculo(pelotaPong)) {
    pelotaPong.invertirVelocidadX();
    pelotaPong.setPosicionX(paleta2.getPosicion().x - pelotaPong.getRadio());
  }

  if (pelotaPong.getPosicion().x < 0) {
    puntajeP2++;
    pelotaPong.resetear(width / 2, height / 2);
  } else if (pelotaPong.getPosicion().x > width) {
    puntajeP1++;
    pelotaPong.resetear(width / 2, height / 2);
  }

  if (puntajeP1 >= 5 || puntajeP2 >= 5) {
    estadoDelJuego = ESTADO_GAME_OVER;
  }

  paleta1.mostrar();
  paleta2.mostrar();
  pelotaPong.mostrar();

  fill(255, 30);
  textSize(120);
  textAlign(CENTER, CENTER);
  text(puntajeP1, width / 4, height / 2);
  text(puntajeP2, 3 * width / 4, height / 2);
}

void keyPressed() {
  if (estadoDelJuego == ESTADO_MENU) {
    if (key == '1') iniciarFlappy();
    if (key == '2') iniciarPong();
  } 
  else if (estadoDelJuego == ESTADO_JUGANDO_FLAPPY) {
    if (key == ' ') bird.saltar();
  } 
  else if (estadoDelJuego == ESTADO_JUGANDO_PONG) {
    if (key == 'w' || key == 'W') wPresionada = true;
    if (key == 's' || key == 'S') sPresionada = true;
    if (key == 'o' || key == 'O') oPresionada = true;
    if (key == 'l' || key == 'L') lPresionada = true;
  } 
  else if (estadoDelJuego == ESTADO_GAME_OVER) {public static final int ESTADO_MENU = 0;
public static final int ESTADO_JUGANDO_FLAPPY = 1;
public static final int ESTADO_JUGANDO_PONG = 2;
public static final int ESTADO_GAME_OVER = 3;

private int estadoDelJuego = ESTADO_MENU;
private int juegoSeleccionado = 0; // 1: Flappy, 2: Pong

private ArrayList<DuplaDeTubos> tubos;
private Circulo bird;
private float ultimoPar = 0;
private int puntajeFlappy = 0;
private PVector gravedad = new PVector(0, 0.5);

private Circulo pelotaPong;
private Cuadrado paleta1, paleta2;
private int puntajeP1 = 0, puntajeP2 = 0;
private boolean wPresionada, sPresionada, oPresionada, lPresionada;

void setup() {
  size(800, 600);
  tubos = new ArrayList<DuplaDeTubos>();
}

void draw() {
  switch (estadoDelJuego) {
    case ESTADO_MENU:
      dibujarMenu();
      break;
    case ESTADO_JUGANDO_FLAPPY:
      actualizarYMostrarFlappy();
      break;
    case ESTADO_JUGANDO_PONG:
      actualizarYMostrarPong();
      break;
    case ESTADO_GAME_OVER:
      dibujarGameOver();
      break;
  }
}

private void dibujarMenu() {
  background(30, 30, 40);
  
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(42);
  text("MENÚ DE JUEGOS", width / 2, 100);
  
  textSize(20);
  fill(200);
  text("Seleccioná un juego para empezar:", width / 2, 160);

  fill(135, 206, 235);
  rect(width / 2 - 150, 230, 300, 80, 15);
  fill(0);
  textSize(28);
  text("1. Flappy Bird", width / 2, 270);

  fill(50, 200, 100);
  rect(width / 2 - 150, 350, 300, 80, 15);
  fill(0);
  textSize(28);
  text("2. Pong (2 Jugadores)", width / 2, 390);

  fill(150);
  textSize(16);
  text("Presioná [1] o [2] en el teclado, o hacé clic en las opciones.", width / 2, 520);
}

private void iniciarFlappy() {
  bird = new Circulo(150, height / 2, 20, true);
  tubos.clear();
  puntajeFlappy = 0;
  ultimoPar = millis();
  juegoSeleccionado = ESTADO_JUGANDO_FLAPPY;
  estadoDelJuego = ESTADO_JUGANDO_FLAPPY;
}

private void iniciarPong() {
  pelotaPong = new Circulo(width / 2, height / 2, 12, false);
  paleta1 = new Cuadrado(30, height / 2 - 50, 15, 100, false);
  paleta2 = new Cuadrado(width - 45, height / 2 - 50, 15, 100, false);
  puntajeP1 = 0;
  puntajeP2 = 0;
  juegoSeleccionado = ESTADO_JUGANDO_PONG;
  estadoDelJuego = ESTADO_JUGANDO_PONG;
}

private void dibujarGameOver() {
  fill(0, 180);
  rect(0, 0, width, height);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(50);
  text("GAME OVER", width / 2, height / 2 - 60);

  textSize(24);
  if (juegoSeleccionado == ESTADO_JUGANDO_FLAPPY) {
    text("Puntaje Final: " + puntajeFlappy, width / 2, height / 2);
  } else {
    text("Resultado Final: " + puntajeP1 + " - " + puntajeP2, width / 2, height / 2);
  }

  textSize(18);
  fill(220);
  text("Presioná [ESPACIO] para Volver a Jugar", width / 2, height / 2 + 70);
  text("Presioná [M] para Volver al Menú Principal", width / 2, height / 2 + 100);
}
private void actualizarYMostrarFlappy() {
  background(135, 206, 235);

  if (millis() - ultimoPar > 1800) {
    tubos.add(new DuplaDeTubos(width, 170));
    ultimoPar = millis();
  }

  bird.addFuerza(gravedad);
  bird.mover();

  for (int i = tubos.size() - 1; i >= 0; i--) {
    DuplaDeTubos dupla = tubos.get(i);
    dupla.mover();
    dupla.mostrar();

    if (dupla.colisionaCon(bird)) {
      estadoDelJuego = ESTADO_GAME_OVER;
    }

    if (dupla.evaluarPunto(bird)) {
      puntajeFlappy++;
    }

    if (dupla.fueraDePantalla()) {
      tubos.remove(i);
    }
  }

  if (bird.getPosicion().y - bird.getRadio() < 0 || bird.getPosicion().y + bird.getRadio() > height) {
    estadoDelJuego = ESTADO_GAME_OVER;
  }

  bird.mostrar();

  fill(255);
  textAlign(CENTER, TOP);
  textSize(40);
  text(puntajeFlappy, width / 2, 20);
}
private void actualizarYMostrarPong() {
  fill(0, 40);
  rect(0, 0, width, height);

  if (wPresionada) paleta1.moverArriba(7);
  if (sPresionada) paleta1.moverAbajo(7);
  if (oPresionada) paleta2.moverArriba(7);
  if (lPresionada) paleta2.moverAbajo(7);

  paleta1.contenerEnPantalla(height);
  paleta2.contenerEnPantalla(height);

  pelotaPong.mover();
  pelotaPong.contenerEnPantalla(height);

  if (paleta1.colisionaConCirculo(pelotaPong)) {
    pelotaPong.invertirVelocidadX();
    pelotaPong.setPosicionX(paleta1.getPosicion().x + paleta1.getAncho() + pelotaPong.getRadio());
  }
  if (paleta2.colisionaConCirculo(pelotaPong)) {
    pelotaPong.invertirVelocidadX();
    pelotaPong.setPosicionX(paleta2.getPosicion().x - pelotaPong.getRadio());
  }

  if (pelotaPong.getPosicion().x < 0) {
    puntajeP2++;
    pelotaPong.resetear(width / 2, height / 2);
  } else if (pelotaPong.getPosicion().x > width) {
    puntajeP1++;
    pelotaPong.resetear(width / 2, height / 2);
  }

  if (puntajeP1 >= 5 || puntajeP2 >= 5) {
    estadoDelJuego = ESTADO_GAME_OVER;
  }

  paleta1.mostrar();
  paleta2.mostrar();
  pelotaPong.mostrar();

  fill(255, 30);
  textSize(120);
  textAlign(CENTER, CENTER);
  text(puntajeP1, width / 4, height / 2);
  text(puntajeP2, 3 * width / 4, height / 2);
}

void keyPressed() {
  if (estadoDelJuego == ESTADO_MENU) {
    if (key == '1') iniciarFlappy();
    if (key == '2') iniciarPong();
  } 
  else if (estadoDelJuego == ESTADO_JUGANDO_FLAPPY) {
    if (key == ' ') bird.saltar();
  } 
  else if (estadoDelJuego == ESTADO_JUGANDO_PONG) {
    if (key == 'w' || key == 'W') wPresionada = true;
    if (key == 's' || key == 'S') sPresionada = true;
    if (key == 'o' || key == 'O') oPresionada = true;
    if (key == 'l' || key == 'L') lPresionada = true;
  } 
  else if (estadoDelJuego == ESTADO_GAME_OVER) {
    if (key == ' ') {
      if (juegoSeleccionado == ESTADO_JUGANDO_FLAPPY) iniciarFlappy();
      else if (juegoSeleccionado == ESTADO_JUGANDO_PONG) iniciarPong();
    }
    if (key == 'm' || key == 'M') {
      estadoDelJuego = ESTADO_MENU;
    }
  }
}

void keyReleased() {
  if (estadoDelJuego == ESTADO_JUGANDO_PONG) {
    if (key == 'w' || key == 'W') wPresionada = false;
    if (key == 's' || key == 'S') sPresionada = false;
    if (key == 'o' || key == 'O') oPresionada = false;
    if (key == 'l' || key == 'L') lPresionada = false;
  }
}

void mousePressed() {
  if (estadoDelJuego == ESTADO_MENU) {
    if (mouseX >= width/2 - 150 && mouseX <= width/2 + 150) {
      if (mouseY >= 230 && mouseY <= 310) iniciarFlappy();
      if (mouseY >= 350 && mouseY <= 430) iniciarPong();
    }
  }
}
    if (key == ' ') {
      if (juegoSeleccionado == ESTADO_JUGANDO_FLAPPY) iniciarFlappy();
      else if (juegoSeleccionado == ESTADO_JUGANDO_PONG) iniciarPong();
    }
    if (key == 'm' || key == 'M') {
      estadoDelJuego = ESTADO_MENU;
    }
  }
}

void keyReleased() {
  if (estadoDelJuego == ESTADO_JUGANDO_PONG) {
    if (key == 'w' || key == 'W') wPresionada = false;
    if (key == 's' || key == 'S') sPresionada = false;
    if (key == 'o' || key == 'O') oPresionada = false;
    if (key == 'l' || key == 'L') lPresionada = false;
  }
}

void mousePressed() {
  if (estadoDelJuego == ESTADO_MENU) {
    if (mouseX >= width/2 - 150 && mouseX <= width/2 + 150) {
      if (mouseY >= 230 && mouseY <= 310) iniciarFlappy();
      if (mouseY >= 350 && mouseY <= 430) iniciarPong();
    }
  }
}
