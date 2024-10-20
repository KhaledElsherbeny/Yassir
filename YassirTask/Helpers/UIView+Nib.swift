//
//  UIView+Nib.swift
//  YassirTask
//
//  Created by Khalid on 21/10/2024.
//

import UIKit

extension UIView {
    @objc func xibSetup() {
        if let contentView = loadViewFromNib() {
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(contentView)
        }
    }

    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }

    func bottomRelative(to view: UIView?) -> CGFloat {
        let globalOrigin = superview?.convert(frame, to: view).origin.y ?? 0
        return globalOrigin + bounds.height
    }
}
