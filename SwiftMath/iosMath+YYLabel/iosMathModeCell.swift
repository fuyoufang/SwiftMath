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
    
    private static let regex = "\(DEFAULT_DELIMITER).*?\(DEFAULT_DELIMITER)"
    var mathText: String? {
        didSet {
            
            if mathText == nil {
                mathTextLabel.attributedText = nil
            } else {
                let result = RegularExpression(regex: iosMathModeCell.regex, validateString: mathText!)
                
                let text = NSMutableAttributedString()
                text.append(NSAttributedString(string: mathText!, attributes: [NSAttributedString.Key.font : mathTextContentFont]))
                if result.count > 0 {
                    for item in result {
                        let range: NSRange = (text.string as NSString).range(of: item)
                        if range.location != NSNotFound {
                            let label = createMathUILabel(latex: item.replacingOccurrences(of: DEFAULT_DELIMITER, with: ""))
                            let attachment = NSMutableAttributedString.yy_attachmentString(withContent: label, contentMode: .center, attachmentSize: label.frame.size, alignTo: mathTextContentFont, alignment: .center)
                            text.replaceCharacters(in: range, with: attachment)
                        }
                    }
                }
                mathTextLabel.attributedText = text
            }
        }
    }
    
    private func createMathUILabel(latex: String) -> MTMathUILabel {
        let label = MTMathUILabel()
        label.labelMode = .text
        label.textAlignment = .left
        label.fontSize = CGFloat(mathTextContentFontSize)
        label.textColor = mathTextContentColor
        label.latex = latex
        label.sizeToFit()
        return label
    }
    
    
    private lazy var contentScrollView: UIScrollView = {
        var scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var mathTextLabel: YYLabel = {
        var label = YYLabel()
        label.numberOfLines = 0
        // 多行时，需要设置此属性才可以自动换行
        label.preferredMaxLayoutWidth = CGFloat(screenWidth - mathTextContentLeft - mathTextContentRight)
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
        // 在 mathTextLabel 外层需要包一层 scrollView：
        // 因为当数学公式过长，一行显示不全的时候，lable 无法滚动显示，
        // 所以将 label 放入 scrollView 中，使其可以滚动显示
        contentView.addSubview(contentScrollView)
        contentScrollView.addSubview(mathTextLabel)

        contentScrollView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(UIEdgeInsets(top: 10, left: CGFloat(mathTextContentLeft), bottom: 10, right: CGFloat(mathTextContentRight)))
        }
        
        mathTextLabel.snp.makeConstraints { (maker) in
            maker.left.right.top.bottom.height.equalToSuperview()
        }
    }
}

/// 正则匹配
///
/// - Parameters:
///   - regex: 匹配规则
///   - validateString: 匹配对test象
/// - Returns: 返回结果
func RegularExpression(regex: String, validateString: String) -> [String] {
    do {
        let regex: NSRegularExpression = try NSRegularExpression(pattern: regex, options: [])
        let matches = regex.matches(in: validateString, options: [], range: NSMakeRange(0, validateString.count))
        
        var data = [String]()
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
