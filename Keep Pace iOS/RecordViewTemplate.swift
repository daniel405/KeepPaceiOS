//
//  RecordViewTemplate.swift
//  Keep Pace iOS
//
//  Created by Quincy Lam on 2018-05-14.
//  Copyright © 2018 Daniel Katz. All rights reserved.
//

import UIKit

class RecordViewTemplate: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var stackContainer: UIStackView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        //we're going to do stuff here
        Bundle.main.loadNibNamed("RecordViewTemplate", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
