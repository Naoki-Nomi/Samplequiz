//
//  QuizViewController.swift
//  Samplequiz
//
//  Created by Naoki Nomi on 2021/04/09.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var quizTextView: UITextView!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var judgeImageView: UIImageView!
    @IBOutlet weak var answerExplanation: UITextView!
    @IBOutlet weak var nextquestion: UIButton!
    
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizcount = 0
    var correctcount = 0
    var selectLebel = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("選択したのはレベル\(selectLebel)")
        
        csvArray = loadCSV(fileName: "quiz\(selectLebel)")
        csvArray.shuffle()
        
        quizArray = csvArray[quizcount].components(separatedBy: ",")
        quizNumberLabel.text = "第\(quizcount + 1)問"
        quizTextView.text = quizArray[0]
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
        answerExplanation.text = quizArray[6]
        answerExplanation.isHidden = true
        nextquestion.isHidden = true
        
        answerButton1.layer.borderWidth = 2
        answerButton1.layer.borderColor = UIColor.black.cgColor
        answerButton2.layer.borderWidth = 2
        answerButton2.layer.borderColor = UIColor.black.cgColor
        answerButton3.layer.borderWidth = 2
        answerButton3.layer.borderColor = UIColor.black.cgColor
        answerButton4.layer.borderWidth = 2
        answerButton4.layer.borderColor = UIColor.black.cgColor
        nextquestion.layer.borderWidth = 2
        nextquestion.layer.borderColor = UIColor.black.cgColor
        
        

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctcount
    }
    
    
    @IBAction func btnAction(sender: UIButton) {
        if sender.tag == Int(quizArray[1]) {
            print("正解")
            correctcount += 1
            judgeImageView.image = UIImage(named: "correct")
        } else {
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
        }
        print("スコア: \(correctcount)")
        judgeImageView.isHidden = false
        answerExplanation.isHidden = false
        nextquestion.isHidden = false
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        
    }
    
    @IBAction func moveToNext(_ sender: Any) {
        self.judgeImageView.isHidden = true
        self.answerExplanation.isHidden = true
        self.answerButton1.isEnabled = true
        self.answerButton2.isEnabled = true
        self.answerButton3.isEnabled = true
        self.answerButton4.isEnabled = true
        self.nextquestion.isHidden = true
        self.nextQuiz()
    }
    
    func nextQuiz() {
        quizcount += 1
        if quizcount < csvArray.count {
            quizArray = csvArray[quizcount].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizcount + 1)問"
            quizTextView.text = quizArray[0]
            answerButton1.setTitle(quizArray[2], for: .normal)
            answerButton2.setTitle(quizArray[3], for: .normal)
            answerButton3.setTitle(quizArray[4], for: .normal)
            answerButton4.setTitle(quizArray[5], for: .normal)
            answerExplanation.text = quizArray[6]
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }
    
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            var lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            lineChange = lineChange.replacingOccurrences(of: "\n\n", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        } catch {
            print("エラー")
        }
        return csvArray
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
