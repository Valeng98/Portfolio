//
//  UIViewController+Extension.swift
//  LoginUI
//
//  Created by Valentina Guarnizo on 8/07/22.
//

import UIKit

extension UIViewController {
    func alert(mensaje: String, completion: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: "Alerta!", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: completion))
            
        present(alert, animated: true)
    }
}
