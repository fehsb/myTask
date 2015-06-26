//
//  TableDiscplinas.swift
//  myTasks
//
//  Created by Fernando on 6/11/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//
import SystemConfiguration
import CoreData
import UIKit
import CloudKit

class TableDiscplinas:UITableViewController , UITableViewDataSource, UITableViewDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    lazy var disciplinas:Array<Disciplina> = {
        return DisciplinasManager.sharedInstance.buscarDisciplinas()
        }()
    
    
    override func viewDidLoad() {
        
        if (TableDiscplinas.isConnectedToNetwork()){
            
            let pred = NSPredicate(value: true)
            let query = CKQuery(recordType: "Disciplinas", predicate: pred)
            
            _public.performQuery(query, inZoneWithID: nil, completionHandler: { (objetos, errQuery) -> Void in
                
                let quer = CKQuery(recordType: "Tarefas", predicate: pred)
                
                _public.performQuery(quer, inZoneWithID: nil, completionHandler: { (objeTar, errQuery) -> Void in
                    
                    
                    if (objetos.count == 0){
                        
                        for disc in self.disciplinas{
                            
                            let cloud = CKRecord(recordType: "Disciplinas")
                            cloud.setObject(disc.nome, forKey: "nome")
                            var tars = [CKReference]()
                            
                            for tar in disc.tarefas.allObjects {
                                let t = tar as! Tarefa
                                let cloudTar = CKRecord(recordType: "Tarefas")
                                cloudTar.setObject(tar.nome, forKey: "nome")
                                cloudTar.setObject(tar.data, forKey: "data")
                                var not = NSNumber(double: t.nota)
                                cloudTar.setObject(not, forKey: "nota")
                                _public.saveRecord(cloudTar, completionHandler: nil)
                                tars.append(CKReference(record:cloudTar!, action: CKReferenceAction.None))
                            }
                            
                            cloud.setObject(tars, forKey: "Tarefas")
                            _public.saveRecord(cloud, completionHandler: nil)
                        
                        }
                        
                    }else{
                        for dis in self.disciplinas{
                            
                            var existe = 0
                            
                            for obj in objetos{
                                
                                let nome = obj.objectForKey("nome") as! String
                                var tars = [CKReference]()
                                if nome == dis.nome {
                                    if dis.tarefas.allObjects.count != 0 {
                                        var tarefas = dis.tarefas.allObjects as! [Tarefa]
                                        for trs in dis.tarefas.allObjects{
                                            var tem = 0
                                            if let ll = obj.objectForKey("Tarefas") as? [Tarefa]{
                                                for l in ll {
                                                    if l == trs as! Tarefa {
                                                        tem = 1
                                                    }
                                                }
                                            }
                                            
                                            if (tem == 0){
                                                let t = trs as! Tarefa
                                                let cloudTar = CKRecord(recordType: "Tarefas")
                                                cloudTar.setObject(trs.nome, forKey: "nome")
                                                cloudTar.setObject(trs.data, forKey: "data")
                                                var not = NSNumber(double: t.nota)
                                                cloudTar.setObject(not, forKey: "nota")
                                                _public.saveRecord(cloudTar, completionHandler: nil)
                                                tars.append(CKReference(record:cloudTar!, action: CKReferenceAction.None))
                                            }
                                        }
                                        
                                        obj.setObject(tars, forKey: "Tarefas")
                                        _public.saveRecord(obj as! CKRecord, completionHandler: nil)
                                    }
                                    
                                    
                                    existe = 1
                                }
                            }
                            
                            if existe == 0 {
                                let cloud = CKRecord(recordType: "Disciplinas")
                                cloud.setObject(dis.nome, forKey: "nome")
                                _public.saveRecord(cloud, completionHandler: nil)
                            }
                        }
                        
                    }
                })
            })
            
        }else{
            // mensagem de falta de conexão
            
        }
    }
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)).takeRetainedValue()
        }
        
        var flags: SCNetworkReachabilityFlags = 0
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
            return false
        }
        
        let isReachable = (flags & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return isReachable && !needsConnection
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
        
        disciplinas = DisciplinasManager.sharedInstance.buscarDisciplinas()
        self.tableView.reloadData()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return disciplinas.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item:Disciplina = disciplinas[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("disciplinaCell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = item.nome
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destino = segue.destinationViewController as? TableConteudo {
            destino.disciplina = disciplinas[tableView.indexPathForSelectedRow()!.row] as Disciplina
        }
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext!
            
            context.deleteObject(disciplinas[indexPath.row] as NSManagedObject)
            
            disciplinas.removeAtIndex(indexPath.row)
            context.save(nil)
            
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
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
