//
//  NovaTarefaTable.swift
//  myTasks
//
//  Created by Fernando on 6/11/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

import EventKit
import UIKit

class NovaTarefaTable: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var nomeTarefa: UITextField!
    
    @IBOutlet weak var pesoTarefa: UITextField!
    
    @IBOutlet weak var pick: UIPickerView!
    
    @IBOutlet weak var dataTarefa: UIDatePicker!
    
    var controle = Int()
    
    var tipoTar = "Prova"
    
    var pickerData = [String]()
    
    var disciplina:Disciplina!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controle = 0
        pesoTarefa.delegate = self
        pesoTarefa.delegate = self
        pick.dataSource = self
        pick.delegate = self
        pickerData = ["Prova","Trabalho","Participação","Atividades"]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(row == 0)
        {
            tipoTar = pickerData[0]
        }
        else if(row == 1)
        {
            tipoTar = pickerData[1]
        }
        else if(row == 2)
        {
            tipoTar = pickerData[2]
        }
        else
        {
            tipoTar = pickerData[3]
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if (textField == pesoTarefa)
        {
            controle = 1
            pesoTarefa.text = ""
            return true
        }
        return false
    }
    
    func pick(pick: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
    }

    
    
    @IBAction func salvarTarefa(sender: AnyObject) {
        if (controle == 0){
        }else{
            if((nomeTarefa.text != "")||(pesoTarefa.text != "")){
                var pesoTarefaString = pesoTarefa.text as NSString
                var pesotar:Double = pesoTarefaString.doubleValue
                if ((pesotar <= 100)&&(pesotar>=0)){
                    var tar = TarefasManager.sharedInstance.novaTarefa()
                    tar.nome = nomeTarefa.text
                    tar.disciplina = disciplina!
                    tar.tipo = tipoTar
                    tar.peso = (pesotar/100)
                    tar.data = dataTarefa.date
                    tar.status = false
                    tar.nota = 0
                    TarefasManager.sharedInstance.salvar()
                    
                    var eventStoreFunc:EKEventStore = EKEventStore()
                    
                    var event:EKEvent = EKEvent(eventStore: eventStoreFunc)
                    event.title = tar.nome
                    event.startDate = dataTarefa.date
                    event.endDate = event.startDate.dateByAddingTimeInterval(3600)
                    event.calendar = eventStoreFunc.defaultCalendarForNewEvents
                    eventStoreFunc.saveEvent(event, span: EKSpanThisEvent, error: nil)
                    
                    
                    var alert = UIAlertController(title: "Pronto!", message: "sua tarefa foi adcionada com sucesso !", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                        self.navigationController?.popViewControllerAnimated(true)
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                // mensagem numero errado
            }
        }
        // mensagem campos vazios
        
    }
    
    
    @IBAction func toque(sender: AnyObject) {
        
        pesoTarefa.resignFirstResponder()
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    //        // #warning Potentially incomplete method implementation.
    //        // Return the number of sections.
    //        return 0
    //    }
    //
    //    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete method implementation.
    //        // Return the number of rows in the section.
    //        return 0
    //    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
    
    // Configure the cell...
    
    return cell
    }
    */
    
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
