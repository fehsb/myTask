//
//  RegistraNotaViewController.swift
//  myTasks
//
//  Created by Fernando on 6/22/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

import CoreData
import UIKit

class RegistraNotaViewController: UIViewController {

    @IBOutlet weak var notaField: UITextField!
    
    var tarefa:Tarefa?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func salvar(sender: AnyObject) {
        

        var notatar = notaField.text as NSString
        tarefa?.nota = notatar.doubleValue
        tarefa?.status = true
        
        TarefasManager.sharedInstance.edit()
        
        print(tarefa?.nota)
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
