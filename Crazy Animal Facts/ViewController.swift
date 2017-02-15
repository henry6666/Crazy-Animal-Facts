//
//  ViewController.swift
//  Crazy Animal Facts
//
//  Created by Henry Aguinaga on 2016-07-14.
//  Copyright © 2016 Henry Aguinaga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var randomHeaderLabel: UILabel!
    @IBOutlet weak var crazyFactsLabel: UILabel!
    @IBOutlet weak var facts: UILabel!
    @IBOutlet weak var factButton: UIButton!
    
    let banner = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    
    let factsForBanner = RandomFacts()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    // Load banner
        
        banner.isHidden = false
        banner.center.y = 325
        banner.center.x = 185
        banner.frame.size.width = 300
        banner.frame.size.height = 125
        view.addSubview(banner)
        
        
    // Load the fact label over the banner
        
        label.frame = CGRect(x: 0, y: 0, width: banner.frame.size.width, height: banner.frame.size.height - 50)
        label.font = UIFont(name: "Baskerville-Bold", size: 17)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        banner.addSubview(label)
        
    
        // This loads up the first fact to go over the banner
        
        self.label.text = self.factsForBanner.factsArray[0]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        // Set our starting point for the views
        factButton.center.y += 30.0
        factButton.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        crazyFactsLabel.center.x -= view.bounds.width
        randomHeaderLabel.center.x += view.bounds.width
        
        // Animate randomHeaderLabel
        UIView.animate(withDuration: 0.7, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.randomHeaderLabel.center.x -= self.view.bounds.width
            
        }, completion: nil)
        
        // Animate crazyFactsLabel
        UIView.animate(withDuration: 0.9, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.crazyFactsLabel.center.x += self.view.bounds.width
            
            }, completion: nil)
        
        // Animate factButton with springs
        UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            self.factButton.center.y -= 30.0
            self.factButton.alpha = 1.0
            }, completion: nil)
    }

    
    
    
    @IBAction func buttonPressed() {
        let b = self.factButton.bounds
        
        //self.label.text = factsForBanner.randomFact()
        
        //showFacts()
        
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 3, options: [],
                                   animations: {
                                    // Grow the factButton wider when pressed
                                   self.factButton.bounds = CGRect(x: b.origin.x - 20, y: b.origin.y, width: b.size.width + 30, height: b.size.height + 10)
                                    
            }, completion: {_ in
                
                self.showFacts()
                
                //Shrink factButton back to original size after grow is completed
                self.factButton.bounds = CGRect(x: b.origin.x - 20, y: b.origin.y , width: b.size.width, height: b.size.height)
                
        })
    }
    
    func showFacts() {
       UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [],
        animations: {
            // first move away any message thats over the banner by moving to the right
            self.banner.center.x += self.view.frame.width
            
        }, completion: {_ in
       
            self.label.text = self.factsForBanner.randomFact()
            self.banner.isHidden = true
            self.banner.center.x -= self.view.frame.size.width
            
            UIView.transition(with: self.banner, duration: 0.3, options: [.curveEaseOut,UIViewAnimationOptions.transitionFlipFromTop], animations: {self.banner.isHidden = false}, completion: nil)
            
       })
    }
    
    
    
}

