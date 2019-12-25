//
//  WebViewModeController.swift
//  SwiftMath
//
//  Created by 付有芳 on 2019/12/23.
//  Copyright © 2019 付有芳. All rights reserved.
//

import UIKit
import UIKit

class WebViewModeController: UIViewController {
    static let cellReuseIdentifier = "WebViewModeCell"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WebViewModeCell.self, forCellReuseIdentifier: WebViewModeController.cellReuseIdentifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
extension WebViewModeController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MathTexts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WebViewModeController.cellReuseIdentifier) as! WebViewModeCell
        cell.mathText = MathTexts[indexPath.row]
        cell.questionContentLoadFinish = { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
        }
        return cell
    }
}
