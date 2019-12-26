//
//  iosMathModeController.swift
//  SwiftMath
//
//  Created by 付有芳 on 2019/12/23.
//  Copyright © 2019 付有芳. All rights reserved.
//

import UIKit
import YYText

class iosMathModeController: UITableViewController {
    
    static let cellReuseIdentifier = "iosMathModeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(iosMathModeCell.self, forCellReuseIdentifier: iosMathModeController.cellReuseIdentifier)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MathTexts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: iosMathModeController.cellReuseIdentifier) as! iosMathModeCell
        cell.mathText = MathTexts[indexPath.row]
        return cell
    }
}
