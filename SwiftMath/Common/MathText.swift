//
//  MathText.swift
//  SwiftMath
//
//  Created by 付有芳 on 2019/12/23.
//  Copyright © 2019 付有芳. All rights reserved.
//

import UIKit

let DEFAULT_DELIMITER = "`"

let MathText0 =
"""
数学公式1：`f^{(n)}(z_0) = frac{n!}{2pi i}oint_gammafrac{f(z)}{(z-z_0)^{n+1}}dz`
"""

let MathText1 =
"""
数学公式2：`x = \\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}`
"""

let MathText2 =
"""
数学公式3：`\\frak Q(\\lambda,\\hat{\\lambda}) = -\\frac{1}{2} \\mathbb P(O \\mid \\lambda ) \\sum_s \\sum_m \\sum_t \\gamma_m^{(s)} (t) +\\\\ \\quad \\left( \\log(2 \\pi ) + \\log \\left| \\cal C_m^{(s)} \\right| + \\left( o_t - \\hat{\\mu}_m^{(s)} \\right) ^T \\cal C_m^{(s)-1} \\right)`
"""

let MathText3 =
"""
数学公式4：`i\\hbar\\frac{\\partial}{\\partial t}\\mathbf\\Psi(\\mathbf{x},t) = -\\frac{\\hbar}{2m}\\nabla^2\\mathbf\\Psi(\\mathbf{x},t) + V(\\mathbf{x})\\mathbf\\Psi(\\mathbf{x},t) -\\frac{\\hbar}{2m}\\nabla^2\\mathbf\\Psi(\\mathbf{x},t) + V(\\mathbf{x})\\mathbf\\Psi(\\mathbf{x},t)`
"""

let MathText4 =
"""
数学公式5：第一段公式 `i\\hbar\\frac{\\partial}{\\partial t}\\mathbf\\Psi(\\mathbf{x},t)`，第二段公式  `-\\frac{\\hbar}{2m}\\nabla^2\\mathbf\\Psi(\\mathbf{x},t) + V(\\mathbf{x})\\mathbf\\Psi(\\mathbf{x},t)`，第三段公式 `-\\frac{\\hbar}{2m}\\nabla^2\\mathbf\\Psi(\\mathbf{x},t) + V(\\mathbf{x})\\mathbf\\Psi(\\mathbf{x},t)`，结束。
"""

let MathText5 =
"""
数学公式6：
第一段公式 `i\\hbar\\frac{\\partial}{\\partial t}\\mathbf\\Psi(\\mathbf{x},t)`，
第二段公式 `-\\frac{\\hbar}{2m}\\nabla^2\\mathbf\\Psi(\\mathbf{x},t) + V(\\mathbf{x})\\mathbf\\Psi(\\mathbf{x},t)`，
第三段公式 `-\\frac{\\hbar}{2m}\\nabla^2\\mathbf\\Psi(\\mathbf{x},t) + V(\\mathbf{x})\\mathbf\\Psi(\\mathbf{x},t)`，
结束。
"""

let MathTexts = [MathText0, MathText1, MathText2, MathText3, MathText4, MathText5]


let screenWidth = Int(UIScreen.main.bounds.size.width)
let mathTextContentLeft = 14
let mathTextContentRight = 14
let mathTextContentFontSize = 17
let mathTextContentFont = UIFont.systemFont(ofSize: 17)
let mathTextContentColor = UIColor.darkText
