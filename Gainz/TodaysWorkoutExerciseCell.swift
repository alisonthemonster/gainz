//
//  TodaysWorkoutExerciseCell.swift
//  Gainz
//
//  Created by Siena McFetridge on 3/18/16.
//  Copyright © 2016 cs378. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TodaysWorkoutExerciseCell: PFTableViewCell, UITextFieldDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sets: UILabel!
    @IBOutlet weak var reps: UILabel!
    @IBOutlet weak var weights: UILabel!
    @IBOutlet weak var checkMark: UIImageView!
    
    
    var exercise:PFObject?
    var complete:Bool = false
    var rating:Int = -1
    var object:PFObject?
    
   }
