//
//  SelectLevelViewController.swift
//  Samplequiz
//
//  Created by Naoki Nomi on 2021/04/09.
//

import UIKit

class SelectLevelViewController: UIViewController {
    @IBOutlet weak var levelButton1: UIButton!
    @IBOutlet weak var levelButton2: UIButton!
    @IBOutlet weak var levelButton3: UIButton!
    var selectTag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        levelButton1.layer.borderWidth = 2
        levelButton1.layer.borderColor = UIColor.black.cgColor
        
        levelButton2.layer.borderWidth = 2
        levelButton2.layer.borderColor = UIColor.black.cgColor
        
        levelButton3.layer.borderWidth = 2
        levelButton3.layer.borderColor = UIColor.black.cgColor

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizVC = segue.destination as! QuizViewController
        quizVC.selectLebel = selectTag
    }

    
    @IBAction func levelButtonAction(sender: UIButton) {
        print(sender.tag)
        selectTag = sender.tag
        performSegue(withIdentifier: "toQuizVC", sender: nil)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
