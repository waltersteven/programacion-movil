//
//  ViewController.swift
//  FiguritasApp
//
//  Created by E4401 on 4/20/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit
	
class RepetidasViewController: UIViewController, OnSwipeRightDelegate, OnSwipeLeftDelegate, OnPanDelegate {
    
    var figuritasManager = FiguritasManager()
    var animator: UIViewPropertyAnimator! //forzando el desenvolvimiento
    var panAnimator: UIViewPropertyAnimator!
    
    func onSwipeLeft() {
        print("Se hizo swipe left")
        figuritasManager.prevJugador()
        fviJugador.jugador = figuritasManager.paqueteJugadores[figuritasManager.indiceJugadorActual].imagen
        fviJugador.numero = figuritasManager.paqueteJugadores[figuritasManager.indiceJugadorActual].numero
    }
    
    func onSwipeRight() {
        print("Se hizo swipe right")
        figuritasManager.nextJugador()
        fviJugador.jugador = figuritasManager.paqueteJugadores[figuritasManager.indiceJugadorActual].imagen
        fviJugador.numero = figuritasManager.paqueteJugadores[figuritasManager.indiceJugadorActual].numero
    }
    
    func onPan(withState state: UIGestureRecognizerState, withTranslation translation: CGPoint) {
        switch state {
        case .began:
            panAnimator = UIViewPropertyAnimator(duration: 1, curve: .easeIn, animations:
                { ()-> Void in
                self.fviJugador.frame.origin.y -= self.view.frame.height
            })
            
            panAnimator.addCompletion({ (completion)-> Void in
                //se ejecuta cuando acaba la animacion
            })
            
            panAnimator.pauseAnimation() //pausamos la animacion, solo la creamos
        case .changed:
            panAnimator.fractionComplete = translation.y / 100 //entre 100 porque es un porcentaje, fractionComplete hace que se mueva ese porcentaje
        case .ended:
            panAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            break
        }
    }

    @IBOutlet weak var fviJugador: FiguritaView!{
        didSet{
            fviJugador.onSwipeRightDelegate = self
            fviJugador.onSwipeLeftDelegate = self
            fviJugador.onPanDelegate = self //el delegado sea el viewController (repetidasViewController)
            
            fviJugador.jugador = figuritasManager.paqueteJugadores[figuritasManager.indiceJugadorActual].imagen
            fviJugador.numero = figuritasManager.paqueteJugadores[figuritasManager.indiceJugadorActual].numero
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //se ejecuta cuando todas las vistas aparezcan en pantalla (se inicializan todas las animaciones)
    override func viewDidAppear(_ animated: Bool) {
        fviJugador.frame.origin.x -= view.frame.width //movemos al objeto a la izquierda
        //instanciamos animator
        animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut, animations:
            { ()->Void in
            self.fviJugador.frame.origin.x += self.view.frame.width //moviendo a posicion correcta
        })
        animator.startAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

