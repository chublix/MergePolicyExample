//
//  RefreshView.swift
//  MergePolicyExample
//
//  Created by Andrey Chuprina on 1/22/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit

enum RefreshButtonType: Int {
    case setup      = 0
    case update1
    case update2
    case close
}

protocol RefreshViewDelegate: class {
    func refreshView(_ view: RefreshView, buttonDidTouch type: RefreshButtonType)
}

class RefreshView: UIRefreshControl {
    
    weak var delegate: RefreshViewDelegate?
    
    class func create() -> RefreshView {
        return UINib(nibName: "RefreshView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! RefreshView
    }
    
    @IBAction private func buttonTouch(_ sender: UIButton) {
        guard let type = RefreshButtonType(rawValue: sender.tag) else { return }
        delegate?.refreshView(self, buttonDidTouch: type)
    }
    
}
