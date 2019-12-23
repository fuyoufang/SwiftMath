//
//  WebViewModeCell.swift
//  SwiftMath
//
//  Created by 付有芳 on 2019/12/23.
//  Copyright © 2019 付有芳. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class WebViewModeCell: UITableViewCell {
    var questionContentLoadFinish: (() -> Void)?
    
    
    var mathText: String? {
        didSet {
            if mathText == oldValue {
                return
            }
            
            refreshedTableView = false
            let htmlPath = Bundle.main.path(forResource: "katex/index", ofType: "html")
            let baseURL = NSURL.fileURL(withPath: htmlPath!)
            
            if mathText == nil {
                 webView.loadHTMLString("", baseURL: baseURL)
            } else {
                var html: NSString = mathText! as NSString
                do {
                    var appHtml = try NSString(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8.rawValue)
                    var r: NSRange = html.range(of: DEFAULT_DELIMITER)
                    if r.location != NSNotFound {
                        var index = false
                        while r.location != NSNotFound {
                            html = html.replacingCharacters(in: r, with: (index ? "</span>" : "<span class=\"tex\">")) as NSString
                            index = !index
                            r = html.range(of: DEFAULT_DELIMITER)
                        }
                        if index {
                            debugPrint("没有闭合")
                        }
                        appHtml = appHtml.replacingOccurrences(of: "$LATEX$", with: html as String) as NSString
                        
                        webView.loadHTMLString((appHtml as String), baseURL: baseURL)
                        
                    }
                } catch {
                }
            }
        }
    }
    
    var refreshedTableView: Bool = false
    
    private lazy var webView: WKWebView = {
        var webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        contentView.addSubview(webView)
        
        webView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(UIEdgeInsets(top: 10, left: CGFloat(mathTextContentLeft), bottom: 10, right: CGFloat(mathTextContentRight)))
            maker.height.equalTo(20)
        }
    }
    
    var webViewScrollHeight: CGFloat = 20
    
    var cellHeight: CGFloat {
        return webViewScrollHeight + 20
    }
}

extension WebViewModeCell: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        guard questionContentLoadFinish != nil else { return }
        
        guard !refreshedTableView else { return }
        // 当webview加载完成，计算并刷新高度
        webView.evaluateJavaScript("document.body.scrollHeight") { [weak self] (any, error) in
            // height就是加载完毕的webView的高度
            let height = any as! Int
            
            self?.webViewScrollHeight = CGFloat(height)
            // 调整webView高度
            self?.webView.snp.updateConstraints({ (maker) in
                maker.height.equalTo(height)
            })
            self?.questionContentLoadFinish?()
            self?.refreshedTableView = true
        }
    }
}
