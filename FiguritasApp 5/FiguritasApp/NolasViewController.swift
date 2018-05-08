//
//  NolasViewController.swift
//  FiguritasApp
//
//  Created by E4420 on 5/4/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import UIKit

class NolasViewController: UIViewController, OnTapDelegate {
    
    func onTapDelegate(nombre: String, numero: String) {
        //cuando le hace click a alguno de los elementos llamo al segue
        performSegue(withIdentifier: "Show Detalle 2", sender: self)
    }
    
    //se llama antes de ejecutar cualquier segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //viendo a que segue se ha llamado
        switch (segue.identifier!) {
        case "Show Detalle 2":
            let vcd = segue.destination as? DetalleNola2ViewController //referencia al siguiente viewcontroller que llamaré o sea una instancia, con as? casteamos
            
            vcd?.numero = "500"
            vcd?.jugador = "neymar"
            
            //o
//            if let vcd = segue.destination as? DetalleNola2ViewController {
//                vcd.numero = "500"
//                vcd.jugador = "neymar"
//            }
            
        default:
            break
        }
    }
    
    @IBOutlet var fviNolas: [FiguritaView]!{
        didSet { //apenas se crean las figuritas 
            for nola in fviNolas {
                nola.numero = "455"
                nola.jugador = "neymar"
                nola.isCaraArriba = false
                nola.onTapDelegate = self
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    
}
