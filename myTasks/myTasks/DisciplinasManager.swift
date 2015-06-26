 //
//  DisciplinasManager.swift
//  myTasks
//
//  Created by Fernando on 6/11/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

import CoreData
import UIKit
 
 public class DisciplinasManager {
    static let sharedInstance:DisciplinasManager = DisciplinasManager()
    static let entityName:String = "Disciplina"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
        }()
    
    private init(){}
    
    func novaDisciplina()->Disciplina
    {
        return NSEntityDescription.insertNewObjectForEntityForName(DisciplinasManager.entityName, inManagedObjectContext: managedContext) as! Disciplina
    }
    
    func salvar()
    {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func buscarDisciplinas()->Array<Disciplina>
    {
        let fetchRequest = NSFetchRequest(entityName: DisciplinasManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Disciplina] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        
        return Array<Disciplina>()
    }
 }