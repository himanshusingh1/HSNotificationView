//
//  HSNotificationView.swift
//  HSNotificationView
//
//  Created by Himanshu Singh on 11/03/23.
//

import UIKit

public class HSNotificationView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var pullDownView: UIView!
    
    private static var tag = 9999119
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        // adding the top level view to the view hierarchy
    }
    private func commonInit() {
        Bundle(for: HSNotificationView.self).loadNibNamed("HSNotificationView", owner: self,options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.pullDownView.clipsToBounds = true
        self.pullDownView.layer.cornerRadius = 2
        self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    }
    public static func show(font: UIFont = .systemFont(ofSize: 14), text: String,icon: UIImage? = nil, timeout: Double = 5.0,shouldCleanOldNotifications: Bool = false) {
        let view = HSNotificationView()
        view.tag = HSNotificationView.tag
        view.label.font = font
        view.label.text = text
        view.icon.image = icon ?? Bundle.main.icon
        view.icon.layer.cornerRadius = 8
        view.frame = .init(x: 0, y: -102, width: UIScreen.main.bounds.width, height: 102)
        UIView.animate(withDuration: 0.3, delay: 0) {
            view.frame = .init(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: 102))
        }
        guard let window = UIApplication.shared.keyWindow else { return }
        window.subviews.forEach { oldView in
            if oldView.tag == HSNotificationView.tag {
                oldView.removeFromSuperview()
            }
        }
        window.addSubview(view)
        DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
            view.hide()
        }
    }
    
    @IBAction func didPanOnNotificationView(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self).y
        if location < self.frame.height/2 {
            self.hide()
        }
    }
    func hide() {
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.frame = .init(origin: .init(x: 0, y: -102), size: .init(width: UIScreen.main.bounds.width, height: 102))
        }completion: { _ in
            self.removeFromSuperview()
        }
    }
}

class TopAlignedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: textRect)
    }
}
extension Bundle {
    public var icon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last {
            return UIImage(named: lastIcon)
        }
        return nil
    }
}
