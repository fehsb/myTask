//
//  TableConteudo.swift
//  myTasks
//
//  Created by Fernando on 6/11/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

import UIKit

class TableConteudo: UITableViewController, UITableViewDataSource {

    var disciplina:Disciplina!



    
    override func viewDidLoad() {
        super.viewDidLoad()
        }

    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        self.navigationItem.title = disciplina?.nome
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = disciplina?.tarefas.count {
            return disciplina!.tarefas.allObjects.count
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let item = disciplina!.tarefas.allObjects[indexPath.row] as! Tarefa

//        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("tarefa") as! UITableViewCell
        
//        cell.textLabel?.text = item.nome
//        cell.detailTextLabel?.text = "\(item.data)"

        var cell : ConteudoTableViewCell = tableView.dequeueReusableCellWithIdentifier("tarefa") as! ConteudoTableViewCell

        var formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy, HH:mm"
        var dataTexto = formatter.stringFromDate(item.data)

        cell.nomeLabel.text = item.nome
        cell.dataLabel.text = dataTexto
        cell.tipoLabel.text = item.tipo
        if (item.status){
            cell.statusLabel.textColor = UIColor.greenColor()
            cell.statusLabel.text = "Nota: \(item.nota)"
        }else{
            cell.statusLabel.text = "Pendente"
            cell.statusLabel.textColor = UIColor.blueColor()
        }
        
        return cell
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destino = segue.destinationViewController as? NovaTarefaTable {
            destino.disciplina = disciplina
        }
        if let destino = segue.destinationViewController as? RegistraNotaViewController {
            destino.tarefa = disciplina!.tarefas.allObjects[tableView.indexPathForSelectedRow()!.row] as? Tarefa
        }
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
