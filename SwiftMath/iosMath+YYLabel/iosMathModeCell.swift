//
//  swift
//  SwiftMath
//
//  Created by 付有芳 on 2019/12/23.
//  Copyright © 2019 付有芳. All rights reserved.
//

import UIKit
import iosMath
import YYText
import SnapKit

class iosMathModeCell: UITableViewCell {
    
    var mathText: String? {
        didSet {
            let text: NSMutableAttributedString
            
            if mathText == nil {
                mathTextLabel.attributedText = nil
            } else {
                let regex = "\(DEFAULT_DELIMITER).*?\(DEFAULT_DELIMITER)"
                let result = RegularExpression(regex: regex, validateString: mathText!)
                
                text = NSMutableAttributedString()
                text.append(NSAttributedString(string: mathText!, attributes: [NSAttributedString.Key.font : mathTextContentFont]))
                if result.count > 0 {
                    for item in result {
                        let range: NSRange = (text.string as NSString).range(of: item)
                        if range.location != NSNotFound {
                            let label = MTMathUILabel()
                            label.labelMode = .text
                            label.textAlignment = .left
                            label.fontSize = CGFloat(mathTextContentFontSize)
                            label.textColor = mathTextContentColor
                            label.latex = item.replacingOccurrences(of: DEFAULT_DELIMITER, with: "")
                            label.sizeToFit()
                            let size = CGSize(width: label.frame.size.width + 10, height: label.frame.size.height)
                            let attachment = NSMutableAttributedString.yy_attachmentString(withContent: label, contentMode: .center, attachmentSize: size, alignTo: mathTextContentFont, alignment: .center)
                            text.replaceCharacters(in: range, with: attachment)
                        }
                    }
                }
                mathTextLabel.attributedText = text
            }
            let size = mathTextLabel.sizeThatFits(CGSize(width: CGFloat(screenWidth - mathTextContentLeft - mathTextContentRight) , height: CGFloat.greatestFiniteMagnitude))
            mathTextLabel.snp.updateConstraints { (maker) in
                maker.size.equalTo(size)
            }
            contentScrollView.contentSize = CGSize(width: size.width, height: 0)
        }
    }
    
    
    private lazy var contentScrollView: UIScrollView = {
        var scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var mathTextLabel: YYLabel = {
        var label = YYLabel()
        label.numberOfLines = 0
        label.textColor = mathTextContentColor
        label.font = mathTextContentFont
        return label
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
        contentView.addSubview(contentScrollView)
        contentScrollView.addSubview(mathTextLabel)
        
        contentScrollView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(UIEdgeInsets(top: 10, left: CGFloat(mathTextContentLeft), bottom: 10, right: CGFloat(mathTextContentRight)))
        }
        
        mathTextLabel.snp.makeConstraints { (maker) in
            maker.left.right.top.bottom.height.equalToSuperview()
            maker.size.equalTo(CGSize.zero)
        }
    }
}

/// 正则匹配
///
/// - Parameters:
///   - regex: 匹配规则
///   - validateString: 匹配对test象
/// - Returns: 返回结果
func RegularExpression (regex:String,validateString:String) -> [String] {
    do {
        let regex: NSRegularExpression = try NSRegularExpression(pattern: regex, options: [])
        let matches = regex.matches(in: validateString, options: [], range: NSMakeRange(0, validateString.count))
        
        var data:[String] = Array()
        for item in matches {
            let string = (validateString as NSString).substring(with: item.range)
            data.append(string)
        }
        
        return data
    }
    catch {
        return []
    }
}
