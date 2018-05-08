//
//  FiguritaView.swift
//  FiguritasApp
//
//  Created by E4401 on 4/20/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit

protocol OnSwipeRightDelegate {
    func onSwipeRight()
}
protocol OnSwipeLeftDelegate{
    func onSwipeLeft()
}

protocol OnPanDelegate {
    func onPan(withState state: UIGestureRecognizerState, withTranslation translation: CGPoint)
}

protocol OnTapDelegate{
    func onTapDelegate(nombre: String, numero: String)
}


class FiguritaView: UIView {
    var jugador: String?
    var numero: String?{
        didSet{
            setNeedsDisplay()
        }
    }
    var onSwipeRightDelegate: OnSwipeRightDelegate?
    var onSwipeLeftDelegate: OnSwipeLeftDelegate?
    var onTapDelegate: OnTapDelegate?
    var onPanDelegate: OnPanDelegate?
    
    var isCaraArriba: Bool = true{
        didSet{
            for view in self.subviews{
                view.removeFromSuperview()
            }
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) { //inicializamos la vista
        super.init(coder: aDecoder)
        let tapRecognizer: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeRight(_:)))
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeLeft(_:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:))) //dragging til release the screen
        swipeRightRecognizer.direction = UISwipeGestureRecognizerDirection.right
        swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirection.left
        
        //se le agregan los gestos a la vista	
        addGestureRecognizer(tapRecognizer)
        addGestureRecognizer(swipeRightRecognizer)
        addGestureRecognizer(swipeLeftRecognizer)
        addGestureRecognizer(panGestureRecognizer)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        if isCaraArriba{
            dibujarJugador()
        }else{
            dibujarNumero()
        }
        dibujarNombreApp()
    }
    
    func dibujarJugador(){
        if let jug = jugador, let imagen = UIImage(named: jug){
            let alto = imagen.cgImage!.height
            let ancho = imagen.cgImage!.width
            
            let jugadorView = UIImageView(frame: CGRect(x: Int(frame.width)/2 - ancho/2, y: 0, width: ancho, height: alto))
            jugadorView.frame.origin.x = 0
            jugadorView.frame.origin.y = 0
            
            let aspectRatio = jugadorView.frame.width / jugadorView.frame.height
            jugadorView.frame.size.width = frame.size.width
            jugadorView.frame.size.height = frame.size.width / aspectRatio
            jugadorView.image = imagen
            addSubview(jugadorView)
            
            // Igualamos el alto de la imageview al alto de figuritaview
            self.frame.size.height = jugadorView.frame.size.height
        }
    }
    
    func dibujarNombreApp(){
        let anchoLabel = self.bounds.width / 3
        let altoLabel = CGFloat(30)
        let labNombreApp: UILabel = UILabel(frame: CGRect(x: self.frame.size.width - anchoLabel, y: self.frame.height - altoLabel, width: anchoLabel, height: altoLabel))
        //labNombreApp.text = "FiguritasApp"
        let atributos: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont(name: "Chalkduster", size: 14.0)!
        ]
        labNombreApp.attributedText = NSAttributedString(string: "FiguritasApp", attributes: atributos)
        labNombreApp.textAlignment = NSTextAlignment.center
        addSubview(labNombreApp)
    }
    
    func dibujarNumero(){
        // Dibujamos el circulo
        let radioCirculo = self.bounds.width / 8
        let circulo = UIBezierPath(arcCenter: CGPoint(x:self.bounds.midX, y:self.bounds.midY), radius: radioCirculo, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        circulo.stroke()
        
        // Dibujamos el numero
        let altoNumero = CGFloat(30)
        let labNumero = UILabel(frame: CGRect(x: self.bounds.midX - radioCirculo, y: self.bounds.midY - altoNumero / 2, width: 2 * radioCirculo, height: altoNumero))
        labNumero.textAlignment = NSTextAlignment.center
        if let num = numero{
            labNumero.text = num
        }else{
            labNumero.text = "-"
        }
        addSubview(labNumero)
    }
    
    @objc private func onTap(_ gestureRecognizer : UIGestureRecognizer){
        isCaraArriba = !isCaraArriba
        if let delegate = onTapDelegate {
            if let jugador=self.jugador, let numero=self.numero {
                delegate.onTapDelegate(nombre: jugador, numero: numero)
            }
            
        }
    }
    
    @objc private func onSwipeRight(_ gestureRecognizer : UIGestureRecognizer){
        if let delegate = onSwipeRightDelegate{
            delegate.onSwipeRight()
        }
        
    }
    @objc private func onSwipeLeft(_ gestureRecognizer : UIGestureRecognizer){
        if let delegate = onSwipeLeftDelegate{
            delegate.onSwipeLeft()
        }
        
    }
    
    @objc private func onPan(_ gestureRecognizer: UIPanGestureRecognizer) { //se llama cada vez que haya cambios
        if let delegate = onPanDelegate {
            delegate.onPan(withState: gestureRecognizer.state, withTranslation: gestureRecognizer.translation(in: self)) //se le pasa un estado y el nuevo punto de donde está ahora
        }
    }
}











