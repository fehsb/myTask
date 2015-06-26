//
//  NovasDiscplinasController.swift
//  myTasks
//
//  Created by Fernando on 6/11/15.
//  Copyright (c) 2015 Fernando. All rights reserved.
//

import UIKit

class NovasDiscplinasController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nomeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nomeTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == nomeTextField ){
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction func registraDiscplina(sender: AnyObject) {
        if (nomeTextField.text != ""){
            var disc = DisciplinasManager.sharedInstance.novaDisciplina()
            disc.nome = nomeTextField.text
            DisciplinasManager.sharedInstance.salvar()
            
            var alert = UIAlertController(title: "Pronto!", message: "sua matéria foi adcionada com sucesso !", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                self.navigationController?.popToRootViewControllerAnimated(true)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }else{
            var alert = UIAlertController(title: "Atenção!", message: "o campo nome OBRIGATORIAMENTE deve estar preenchido!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
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
