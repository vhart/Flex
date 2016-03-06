//
//  ViewController.swift
//  Flex
//
//  Created by Varindra Hart on 2/18/16.
//  Copyright © 2016 Varindra Hart. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var context =  AppDelegate().managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()


        let temp = Set.init(context: context)
        temp.setValue(NSNumber(int: 5), forKey:"reps")
        print(temp.reps!)

        temp.save()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

