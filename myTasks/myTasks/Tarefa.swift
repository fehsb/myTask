//
//  Tarefa.swift
//  myTasks
//
//  Created by Fernando on 6/19/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

import Foundation
import CoreData

@objc(Tarefa)
class Tarefa: NSManagedObject {

    @NSManaged var data: NSDate
    @NSManaged var nome: String
    @NSManaged var peso: Double 
    @NSManaged var tipo: String
    @NSManaged var status: Bool
    @NSManaged var disciplina: Disciplina
    @NSManaged var nota: Double

}
