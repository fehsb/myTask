//
//  Discplina.swift
//  myTasks
//
//  Created by Fernando on 6/11/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

import CoreData

@objc(Disciplina)
class Disciplina: NSManagedObject {
    
    @NSManaged var nome: String
    @NSManaged var tarefas: NSSet
    //
    //}
    //
    //
    //extension Marca {
    func addProduto(tarefa:Tarefa) {
        var tarefas = self.mutableSetValueForKey("tarefas")
        tarefas.addObject(tarefa)
    }
}