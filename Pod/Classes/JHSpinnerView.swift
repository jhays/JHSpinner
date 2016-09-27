import UIKit

public enum JHSpinnerOverlay {
    case fullScreen, circular, square, roundedSquare, custom(CGSize, CGFloat)
}

open class JHSpinnerView: UIView {
    
    @IBOutlet weak var spinnerContainerView: UIView!
    
    @IBOutlet weak var dot1:UIView!
    @IBOutlet weak var dot1Width:NSLayoutConstraint!
    @IBOutlet weak var dot1Height:NSLayoutConstraint!
    @IBOutlet weak var dot1CenterX:NSLayoutConstraint!
    @IBOutlet weak var dot1CenterY:NSLayoutConstraint!
    
    @IBOutlet weak var dot2:UIView!
    @IBOutlet weak var dot2Width:NSLayoutConstraint!
    @IBOutlet weak var dot2Height:NSLayoutConstraint!
    @IBOutlet weak var dot2CenterX:NSLayoutConstraint!
    @IBOutlet weak var dot2CenterY:NSLayoutConstraint!
    
    @IBOutlet weak var dot3:UIView!
    @IBOutlet weak var dot3Width:NSLayoutConstraint!
    @IBOutlet weak var dot3Height:NSLayoutConstraint!
    @IBOutlet weak var dot3CenterX:NSLayoutConstraint!
    @IBOutlet weak var dot3CenterY:NSLayoutConstraint!
    
    @IBOutlet weak var messageLabel:UILabel!
    @IBOutlet weak var messageTop:NSLayoutConstraint!
    @IBOutlet weak var messageWidth:NSLayoutConstraint!
    @IBOutlet weak var messageHeight:NSLayoutConstraint!
    
    //private var nibView:JHSpinnerView!
    fileprivate var overlay: JHSpinnerOverlay = .fullScreen
    fileprivate var overlayView = UIView()
    fileprivate var animating = false
    fileprivate var animationSpeed = 0.14
    fileprivate var maxDot = CGFloat(26)
    fileprivate var minDot = CGFloat(6)
    fileprivate var margin = CGFloat(4)
    fileprivate var circle: CAShapeLayer?
    open var progress = CGFloat(0) {
        didSet{
            if let circle = circle, let color = dot1.backgroundColor {
                circle.removeFromSuperlayer()
                self.addCircleBorder(color, progress: progress)
            }
        }
    }
    
    open class func showOnView(_ view:UIView, spinnerColor:UIColor? = nil, overlay:JHSpinnerOverlay = .fullScreen, overlayColor:UIColor? = nil, fullCycleTime:Double = 4.0, text:String? = nil, textColor:UIColor? = nil) -> JHSpinnerView {
        
        let defaultWhite = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        let defaultBlack = UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        
        var mySpinnerColor = defaultWhite
        if let color = spinnerColor {
            mySpinnerColor = color
        }else {
            if let bgColor = view.backgroundColor {
                if bgColor.isLight() {
                    mySpinnerColor = defaultBlack
                }else {
                    mySpinnerColor = defaultWhite
                }
            }
        }
        
        var myOverlayColor = defaultBlack
        
        if let overlayColor = overlayColor {
            myOverlayColor = overlayColor
        }else {
            if let bgColor = view.backgroundColor {
                if bgColor.isLight() {
                    myOverlayColor = defaultWhite.withAlphaComponent(0.5)
                }else {
                    myOverlayColor = defaultBlack.withAlphaComponent(0.5)
                }
            }
        }
        
        let spinner = JHSpinnerView.instanceFromNib()
        spinner.frame = view.bounds
        spinner.overlay = overlay
        spinner.animationSpeed = fullCycleTime/28.34 //MAGIC NUMBER
        spinner.dot1.backgroundColor = mySpinnerColor
        spinner.dot2.backgroundColor = mySpinnerColor
        spinner.dot3.backgroundColor = mySpinnerColor
        
        spinner.overlayView.backgroundColor = myOverlayColor
        
        spinner.layoutOverlayView()
        
        spinner.addSubview(spinner.overlayView)
        spinner.bringSubview(toFront: spinner.spinnerContainerView)
        
        if let text = text {
            spinner.messageLabel.text = text
            
            if let textColor = textColor {
                spinner.messageLabel.textColor = textColor
            }else {
                if myOverlayColor.isLight() {
                    spinner.messageLabel.textColor = defaultBlack
                }else {
                    spinner.messageLabel.textColor = defaultWhite
                }
            }
            spinner.messageWidth.constant = spinner.overlayView.frame.width - 16
            spinner.messageHeight.constant = (spinner.overlayView.frame.height/2) - (spinner.spinnerContainerView.frame.height/2) - spinner.messageTop.constant
            spinner.messageLabel.isHidden = false
            spinner.bringSubview(toFront: spinner.messageLabel)
            spinner.layoutIfNeeded()
        }
        
        view.addSubview(spinner)
        
        return spinner
    }
    
    open class func showOnView(_ view:UIView, spinnerColor:UIColor? = nil, overlay:JHSpinnerOverlay = .fullScreen, overlayColor:UIColor? = nil, fullCycleTime:Double = 4.0, attributedText:NSAttributedString) -> JHSpinnerView {
        
        let defaultWhite = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        let defaultBlack = UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        
        var mySpinnerColor = defaultWhite
        if let color = spinnerColor {
            mySpinnerColor = color
        }else {
            if let bgColor = view.backgroundColor {
                if bgColor.isLight() {
                    mySpinnerColor = defaultBlack
                }else {
                    mySpinnerColor = defaultWhite
                }
            }
        }
        
        var myOverlayColor = defaultBlack
        
        if let overlayColor = overlayColor {
            myOverlayColor = overlayColor
        }else {
            if let bgColor = view.backgroundColor {
                if bgColor.isLight() {
                    myOverlayColor = defaultWhite.withAlphaComponent(0.5)
                }else {
                    myOverlayColor = defaultBlack.withAlphaComponent(0.5)
                }
            }
        }
        
        let spinner = JHSpinnerView.instanceFromNib()
        spinner.frame = view.bounds
        spinner.overlay = overlay
        spinner.animationSpeed = fullCycleTime/28.34 //MAGIC NUMBER
        spinner.dot1.backgroundColor = mySpinnerColor
        spinner.dot2.backgroundColor = mySpinnerColor
        spinner.dot3.backgroundColor = mySpinnerColor
        
        spinner.overlayView.backgroundColor = myOverlayColor
        
        spinner.layoutOverlayView()
        
        spinner.addSubview(spinner.overlayView)
        spinner.bringSubview(toFront: spinner.spinnerContainerView)
        
        spinner.messageLabel.attributedText = attributedText
        spinner.messageWidth.constant = spinner.overlayView.frame.width - 16
        spinner.messageHeight.constant = (spinner.overlayView.frame.height/2) - (spinner.spinnerContainerView.frame.height/2) - spinner.messageTop.constant
        spinner.messageLabel.isHidden = false
        spinner.bringSubview(toFront: spinner.messageLabel)
        spinner.layoutIfNeeded()
        
        view.addSubview(spinner)
        
        return spinner
    }
    
    open class func showDeterminiteSpinnerOnView(_ view:UIView, spinnerColor:UIColor? = nil, backgroundColor:UIColor? = nil, fullCycleTime:Double = 4.0, initialProgress:CGFloat = 0.0) -> JHSpinnerView {
        
        let defaultWhite = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        let defaultBlack = UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        
        var mySpinnerColor = defaultWhite
        if let color = spinnerColor {
            mySpinnerColor = color
        }else {
            if let bgColor = view.backgroundColor {
                if bgColor.isLight() {
                    mySpinnerColor = defaultBlack
                }else {
                    mySpinnerColor = defaultWhite
                }
            }
        }
        
        var myOverlayColor = defaultBlack
        
        if let overlayColor = backgroundColor {
            myOverlayColor = overlayColor
        }else {
            if let bgColor = view.backgroundColor {
                if bgColor.isLight() {
                    myOverlayColor = defaultWhite.withAlphaComponent(0.5)
                }else {
                    myOverlayColor = defaultBlack.withAlphaComponent(0.5)
                }
            }
        }
        
        let spinner = JHSpinnerView.instanceFromNib()
        spinner.frame = view.bounds
        spinner.animationSpeed = fullCycleTime/28.34 //MAGIC NUMBER
        spinner.dot1.backgroundColor = mySpinnerColor
        spinner.dot2.backgroundColor = mySpinnerColor
        spinner.dot3.backgroundColor = mySpinnerColor
        
        spinner.overlayView.backgroundColor = myOverlayColor
        
        let size = 75
        
        spinner.overlayView.frame = CGRect(x: Int(spinner.center.x) - (size/2), y: Int(spinner.center.y) - (size/2), width: size, height: size)
        spinner.overlayView.layer.cornerRadius = CGFloat(size/2)
        
        spinner.addSubview(spinner.overlayView)
        spinner.bringSubview(toFront: spinner.spinnerContainerView)
        
        spinner.messageLabel.isHidden = true
        
        spinner.addCircleBorder(mySpinnerColor, progress: 1.0)
        
        view.addSubview(spinner)
        
        return spinner
    }
    
    open func addCircleBorder(_ color:UIColor, progress:CGFloat) {
        let radius = self.overlayView.frame.width/2
        // Create the circle layer
        self.circle = CAShapeLayer()
        let borderWidth = CGFloat(2)
        
        if let circle = self.circle {
            
            // Set the center of the circle to be the center of the view
            let center = CGPoint(x: self.overlayView.frame.midX - radius, y: self.overlayView.frame.midY - radius)
            circle.position = CGPoint(x: (self.overlayView.frame.width - borderWidth)/2, y: (self.overlayView.frame.height - borderWidth)/2)
            
            func rad(_ degrees:CGFloat) -> CGFloat {
                return (degrees * CGFloat(M_PI))/180
            }
            
            let clockwise: Bool = true
            
            // `clockwise` tells the circle whether to animate in a clockwise or anti clockwise direction
            circle.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: -rad(90), endAngle: rad(360-90), clockwise: clockwise).cgPath
            
            // Configure the circle
            circle.fillColor = UIColor.clear.cgColor
            circle.strokeColor = color.cgColor
            circle.lineWidth = borderWidth
            
            // When it gets to the end of its animation, leave it at 100% stroke filled
            circle.strokeEnd = progress
            
            // Add the circle to the parent layer
            self.layer.addSublayer(circle)
            
        }
    }
    
    fileprivate func layoutOverlayView() {
        let size = 120
        switch overlay {
        case .fullScreen:
            
            overlayView.frame = bounds
            
        case .square:
            overlayView.frame = CGRect(x: Int(center.x) - (size/2), y: Int(center.y) - (size/2), width: size, height: size)
        case .roundedSquare:
            overlayView.frame = CGRect(x: Int(center.x) - (size/2), y: Int(center.y) - (size/2), width: size, height: size)
            overlayView.layer.cornerRadius = 8.0
        case .circular:
            overlayView.frame = CGRect(x: Int(center.x) - (size/2), y: Int(center.y) - (size/2), width: size, height: size)
            overlayView.layer.cornerRadius = CGFloat(size/2)
        case .custom(let size, let cornerRadius):
            overlayView.frame = CGRect(x: Int(center.x) - Int(size.width/2), y: Int(center.y) - Int(size.height/2), width: Int(size.width), height: Int(size.height))
            if cornerRadius > 0 {
                overlayView.layer.cornerRadius = cornerRadius
            }
        }
    }
    
    open class func instanceFromNib() -> JHSpinnerView {
        let bundle = Bundle(for:JHSpinnerView.self)
        return UINib(nibName: "JHSpinnerView", bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! JHSpinnerView
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        dot1.layer.cornerRadius = minDot/2
        dot2.layer.cornerRadius = minDot/2
        dot3.layer.cornerRadius = minDot/2
        
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutOverlayView()
        
        if !animating {
            animate()
            
            animating = true
        }
    }
    
    open func dismiss() {
        UIView.animate(withDuration: self.animationSpeed, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.alpha = 0.0
            }) { (success) -> Void in
                self.removeFromSuperview()
        }
    }
    
    open func animate() {
        if dot1Height != nil {
            animateHeightLeftToRight(dot1Height)
        }
    }
    
    
    open func animateHeightLeftToRight(_ constraint:NSLayoutConstraint, max:Bool = true) {
        UIView.animate(withDuration: animationSpeed, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            if max {
                constraint.constant = self.maxDot
            }else {
                constraint.constant = self.minDot
            }
            self.layoutIfNeeded()
            
            }) { (success) -> Void in
                if max {
                    if constraint == self.dot1Height {
                        self.animateHeightLeftToRight(self.dot2Height)
                    }else if constraint == self.dot2Height {
                        self.animateHeightLeftToRight(self.dot3Height)
                    }else if constraint == self.dot3Height {
                        self.animateHeightLeftToRight(self.dot1Height, max:false)
                    }
                }else {
                    if constraint == self.dot1Height {
                        self.animateHeightLeftToRight(self.dot2Height, max:false)
                    }else if constraint == self.dot2Height {
                        self.animateHeightLeftToRight(self.dot3Height, max:false)
                    }else if constraint == self.dot3Height {
                        self.positionTopToBottom(self.dot1CenterX)
                    }
                }
        }
    }
    
    open func positionTopToBottom(_ constraint:NSLayoutConstraint) {
        UIView.animate(withDuration: animationSpeed, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            if constraint == self.dot1CenterX {
                self.dot1CenterX.constant = 0
                self.dot1CenterY.constant = -self.minDot - self.margin
                self.dot3CenterX.constant = 0
                self.dot3CenterY.constant = self.minDot + self.margin
            }
            
            self.layoutIfNeeded()
            
            }) { (success) -> Void in
                
                self.animateWidthTopToBottom(self.dot1Width)
                
                
        }
    }
    
    open func animateWidthTopToBottom(_ constraint:NSLayoutConstraint, max:Bool = true) {
        UIView.animate(withDuration: animationSpeed, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            if max {
                constraint.constant = self.maxDot
            }else {
                constraint.constant = self.minDot
            }
            self.layoutIfNeeded()
            
            }) { (success) -> Void in
                if max {
                    if constraint == self.dot1Width {
                        self.animateWidthTopToBottom(self.dot2Width)
                    }else if constraint == self.dot2Width {
                        self.animateWidthTopToBottom(self.dot3Width)
                    }else if constraint == self.dot3Width {
                        self.animateWidthTopToBottom(self.dot1Width, max:false)
                    }
                }else {
                    if constraint == self.dot1Width {
                        self.animateWidthTopToBottom(self.dot2Width, max:false)
                    }else if constraint == self.dot2Width {
                        self.animateWidthTopToBottom(self.dot3Width, max:false)
                    }else if constraint == self.dot3Width {
                        self.positionRightToLeft(self.dot1CenterX)
                    }
                }
        }
    }
    
    open func positionRightToLeft(_ constraint:NSLayoutConstraint) {
        UIView.animate(withDuration: animationSpeed, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            if constraint == self.dot1CenterX {
                self.dot1CenterX.constant = self.minDot + self.margin
                self.dot1CenterY.constant = 0
                self.dot3CenterX.constant = -self.minDot - self.margin
                self.dot3CenterY.constant = 0
            }
            
            self.layoutIfNeeded()
            
            }) { (success) -> Void in
                
                
                self.animateHeightRightToLeft(self.dot1Height)
                
        }
    }
    
    open func animateHeightRightToLeft(_ constraint:NSLayoutConstraint, max:Bool = true) {
        UIView.animate(withDuration: animationSpeed, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            if max {
                constraint.constant = self.maxDot
            }else {
                constraint.constant = self.minDot
            }
            self.layoutIfNeeded()
            
            }) { (success) -> Void in
                if max {
                    if constraint == self.dot1Height {
                        self.animateHeightRightToLeft(self.dot2Height)
                    }else if constraint == self.dot2Height {
                        self.animateHeightRightToLeft(self.dot3Height)
                    }else if constraint == self.dot3Height {
                        self.animateHeightRightToLeft(self.dot1Height, max:false)
                    }
                }else {
                    if constraint == self.dot1Height {
                        self.animateHeightRightToLeft(self.dot2Height, max:false)
                    }else if constraint == self.dot2Height {
                        self.animateHeightRightToLeft(self.dot3Height, max:false)
                    }else if constraint == self.dot3Height {
                        self.positionBottomToTop(self.dot1CenterX)
                    }
                }
        }
    }
    
    open func positionBottomToTop(_ constraint:NSLayoutConstraint) {
        UIView.animate(withDuration: animationSpeed, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            if constraint == self.dot1CenterX {
                self.dot1CenterX.constant = 0
                self.dot1CenterY.constant = self.minDot + self.margin
                self.dot3CenterY.constant = -self.minDot - self.margin
                self.dot3CenterX.constant = 0
            }
            
            self.layoutIfNeeded()
            
            }) { (success) -> Void in
                
                self.animateWidthBottomToTop(self.dot1Width)
                
        }
    }
    
    open func animateWidthBottomToTop(_ constraint:NSLayoutConstraint, max:Bool = true) {
        UIView.animate(withDuration: animationSpeed, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            if max {
                constraint.constant = self.maxDot
            }else {
                constraint.constant = self.minDot
            }
            self.layoutIfNeeded()
            
            }) { (success) -> Void in
                if max {
                    if constraint == self.dot1Width {
                        self.animateWidthBottomToTop(self.dot2Width)
                    }else if constraint == self.dot2Width {
                        self.animateWidthBottomToTop(self.dot3Width)
                    }else if constraint == self.dot3Width {
                        self.animateWidthBottomToTop(self.dot1Width, max:false)
                    }
                }else {
                    if constraint == self.dot1Width {
                        self.animateWidthBottomToTop(self.dot2Width, max:false)
                    }else if constraint == self.dot2Width {
                        self.animateWidthBottomToTop(self.dot3Width, max:false)
                    }else if constraint == self.dot3Width {
                        self.positionLeftToRight(self.dot1CenterX)
                    }
                }
        }
    }
    
    open func positionLeftToRight(_ constraint:NSLayoutConstraint) {
        UIView.animate(withDuration: animationSpeed, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            if constraint == self.dot1CenterX {
                self.dot1CenterX.constant = -self.minDot - self.margin
                self.dot1CenterY.constant = 0
                self.dot3CenterX.constant = self.minDot + self.margin
                self.dot3CenterY.constant = 0
            }
            
            self.layoutIfNeeded()
            
            }) { (success) -> Void in
                
                
                self.animateHeightLeftToRight(self.dot1Height)
        }
    }
    
}

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = coreImageColor
        return (color.red, color.green, color.blue, color.alpha)
    }
    func isLight() -> Bool
    {
        let comp0 = (components.red) * 299
        let comp1 = (components.green) * 587
        let comp2 = (components.blue) * 114
        let brightness = (comp0 + comp1 + comp2) / 1000
        
        if brightness < 0.5 {
            return false
        }
        else {
            return true
        }
    }
}
