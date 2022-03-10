//
//  ViewController.swift
//  RealmEjemplo
//
//  Created by Carlos ZR on 10/3/22.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm.beginWrite()
        realm.delete(realm.objects(Persona.self))
        try! realm.commitWrite()
        
        save()
        
        render()
    }
    
    func render() {
        let personas = realm.objects(Persona.self)
        
        for persona in personas {
            let nombre = persona.nombre
            let apellido = persona.apellido
            let nombreCompleto = "\(nombre) \(apellido)"
            
            let label = UILabel(frame: view.bounds)
            label.text = nombreCompleto
            label.textAlignment = .center
            label.numberOfLines = 0
            label.font = UIFont(name: "Helvetica", size: 45)
            view.addSubview(label)
            
        }
    }
    
    func save() {
        let paco = Persona()
        paco.nombre = "Miguel"
        paco.apellido = "Gil"
        
        do {
            realm.beginWrite()
            realm.add(paco)
            
            try realm.commitWrite()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

}

class Persona: Object {
    @objc dynamic var nombre: String = ""
    @objc dynamic var apellido: String = ""
    @objc dynamic var edad: Int = 0
}

