//
//  TarefasManager.swift
//  myTasks
//
//  Created by Fernando on 6/11/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

import CoreData
import UIKit

public class TarefasManager {
    static let sharedInstance:TarefasManager = TarefasManager()
    static let entityName:String = "Tarefa"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
        }()
    
    private init(){}
    
    func novaTarefa()->Tarefa
    {
        return NSEntityDescription.insertNewObjectForEntityForName(TarefasManager.entityName, inManagedObjectContext: managedContext) as! Tarefa
    }
    
    func salvar()
    {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func buscarTarefas()->Array<Tarefa>
    {
        let fetchRequest = NSFetchRequest(entityName: TarefasManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Tarefa] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        return Array<Tarefa>()
    }
    
    func edit (){
        
        let fetchRequest = NSFetchRequest(entityName: TarefasManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        if error != nil {
            println("An error occurred loading the data")
        } else {
            let result = fetchedResults as? [Tarefa]
            var saveError : NSError? = nil
            if !managedContext.save(&saveError) {
                println("Could not update record")
            } else {
        
            }
        }
        
        
    }
}