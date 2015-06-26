//
//  HistoricoTableView.swift
//  myTasks
//
//  Created by Fernando on 6/22/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

import UIKit

class HistoricoTableView: UITableViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var aux:Array<Tarefa> = Array<Tarefa>()
    
    lazy var disciplinas:Array<Disciplina> = {
        return DisciplinasManager.sharedInstance.buscarDisciplinas()
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for disc in disciplinas{
            for tar in disc.tarefas.allObjects{
                aux.append(tar as! Tarefa)
            }
        }
        
        aux.sort({$0.data.timeIntervalSinceNow < $1.data.timeIntervalSinceNow})

    }
    
    override func viewWillAppear(animated: Bool) {
        for disc in disciplinas{
            for tar in disc.tarefas.allObjects{
                aux.append(tar as! Tarefa)
            }
        }
        
        aux.sort({$0.data.timeIntervalSinceNow < $1.data.timeIntervalSinceNow})
        disciplinas = DisciplinasManager.sharedInstance.buscarDisciplinas()
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        var cont:Int = 0
        
        if (disciplinas.count > 0){
            for disc in disciplinas {
                cont += disc.tarefas.allObjects.count
                return cont
            }
        }
        
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("datas", forIndexPath: indexPath) as! HistoricoCell
    
        var formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        var dataTexto = formatter.stringFromDate(aux[indexPath.row].data)
        
        cell.nomeLabel.text = aux[indexPath.row].nome
        cell.disciplinaLabel.text = aux[indexPath.row].disciplina.nome
        cell.dataLabel.text = dataTexto
    
    return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
