//
//  MathText.swift
//  SwiftMath
//
//  Created by 付有芳 on 2019/12/23.
//  Copyright © 2019 付有芳. All rights reserved.
//

import UIKit

let DEFAULT_DELIMITER = "`"

let mathText1 =
"""
这个是测试 `f^{(n)}(z_0) = frac{n!}{2pi i}oint_gammafrac{f(z)}{(z-z_0)^{n+1}}dz`这个是测试这个是测试这个是测试这个是测试这个是测试这个是测试`sum_(i=1)^n i^3=((n(n+1))/2)^2` 这个是测试hello
hello `sum_(i=1)^n i^3=((n(n+1))/2)^2` 这个是测试hello
"""

let mathText2 =
"""
这个是测试 `f^{(n)}(z_0) = frac{n!}{2pi i}oint_gammafrac{f(z)}{(z-z_0)^{n+1}}dz`
"""

//let mathTexts = [mathText1, mathText2]
let mathTexts = [mathText1]


let screenWidth = Int(UIScreen.main.bounds.size.width)
let mathTextContentLeft = 14
let mathTextContentRight = 14
let mathTextContentFontSize = 17
let mathTextContentFont = UIFont.systemFont(ofSize: 17)
let mathTextContentColor = UIColor.darkText
