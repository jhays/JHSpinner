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
    
    private var spinner = JHSpinner()
    fileprivate var overlay: JHSpinnerOverlay = .fullScreen
    fileprivate var overlayView = UIView()
    fileprivate var animating = false
    fileprivate var animationSpeed = 0.15
    fileprivate var maxDot = CGFloat(26)
    fileprivate var minDot = CGFloat(6)
    fileprivate var margin = CGFloat(4)
    fileprivate var circle: CAShapeLayer?
  
    open var progress = CGFloat(0) {
        didSet{
            if let circle = circle {
                circle.removeFromSuperlayer()
                self.addCircleBorder(spinner.bgColor, progress: progress)
            }
        }
    }
  
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
    open class func showOnView(_ view:UIView, spinnerColor:UIColor? = nil, overlay:JHSpinnerOverlay = .fullScreen, overlayColor:UIColor? = nil, fullCycleTime:Double = 2.55, text:String? = nil, textColor:UIColor? = nil) -> JHSpinnerView {
        
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
      
      let spinnerView = JHSpinnerView(frame:view.bounds)
      spinnerView.spinner = JHSpinner(frame:spinnerView.bounds)
      
      spinnerView.spinner.bgColor = mySpinnerColor
      spinnerView.spinner.overlay = overlay
      spinnerView.spinner.overlayBgColor = myOverlayColor
      spinnerView.spinner.layoutOverlayView()
      spinnerView.spinner.fullCycleTime = fullCycleTime
      
        if let text = text {
            spinnerView.spinner.messageLabel.text = text
            
            if let textColor = textColor {
                spinnerView.spinner.messageLabel.textColor = textColor
            }else {
                if myOverlayColor.isLight() {
                    spinnerView.spinner.messageLabel.textColor = defaultBlack
                }else {
                    spinnerView.spinner.messageLabel.textColor = defaultWhite
                }
            }
            spinnerView.spinner.messageLabel.isHidden = false
            spinnerView.spinner.bringSubview(toFront: spinnerView.spinner.messageLabel)
            spinnerView.spinner.layoutIfNeeded()
        }
        
        spinnerView.animate()
        spinnerView.addSubview(spinnerView.spinner)
        view.addSubview(spinnerView)
        
        return spinnerView
    }
    
    open class func showOnView(_ view:UIView, spinnerColor:UIColor? = nil, overlay:JHSpinnerOverlay = .fullScreen, overlayColor:UIColor? = nil, fullCycleTime:Double = 2.55, attributedText:NSAttributedString) -> JHSpinnerView {
        
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
      
      let spinnerView = JHSpinnerView(frame:view.bounds)
      spinnerView.spinner = JHSpinner(frame:spinnerView.bounds)
      
      spinnerView.spinner.bgColor = mySpinnerColor
      spinnerView.spinner.overlay = overlay
      spinnerView.spinner.overlayBgColor = myOverlayColor
      spinnerView.spinner.layoutOverlayView()
      spinnerView.spinner.fullCycleTime = fullCycleTime
      
      spinnerView.spinner.messageLabel.attributedText = attributedText
        
      spinnerView.spinner.messageLabel.isHidden = false
      spinnerView.spinner.bringSubview(toFront: spinnerView.spinner.messageLabel)
      spinnerView.spinner.layoutIfNeeded()
      
      spinnerView.animate()
      spinnerView.addSubview(spinnerView.spinner)
      view.addSubview(spinnerView)
      
      return spinnerView

  }
  
    open class func showDeterminiteSpinnerOnView(_ view:UIView, spinnerColor:UIColor? = nil, backgroundColor:UIColor? = nil, fullCycleTime:Double = 2.55, initialProgress:CGFloat = 0.0) -> JHSpinnerView {
        
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
      
     
      
      let spinnerView = JHSpinnerView(frame:view.bounds)
      spinnerView.spinner = JHSpinner(frame:spinnerView.bounds)
      
      spinnerView.spinner.bgColor = mySpinnerColor

      spinnerView.spinner.overlay = .circular
      spinnerView.spinner.overlayBgColor = myOverlayColor
      spinnerView.spinner.layoutOverlayView()
      spinnerView.spinner.fullCycleTime = fullCycleTime
      
      
      spinnerView.spinner.messageLabel.isHidden = true
      spinnerView.spinner.bringSubview(toFront: spinnerView.spinner.messageLabel)
      spinnerView.spinner.layoutIfNeeded()
      
      spinnerView.animate()
      spinnerView.addSubview(spinnerView.spinner)
      view.addSubview(spinnerView)
      
      let size = Int(spinnerView.spinner.overlayView.bounds.width)
      spinnerView.spinner.overlayView.frame = CGRect(x: Int(spinnerView.spinner.center.x) - (size/2), y: Int(spinnerView.spinner.center.y) - (size/2), width: size, height: size)
      spinnerView.spinner.overlayView.layer.cornerRadius = CGFloat(size/2)
      spinnerView.addCircleBorder(mySpinnerColor, progress: initialProgress)
        
      return spinnerView
    }
    
    open func addCircleBorder(_ color:UIColor, progress:CGFloat) {
        let radius = self.spinner.overlayView.frame.width/2
        // Create the circle layer
        self.circle = CAShapeLayer()
        let borderWidth = CGFloat(2)
        
        if let circle = self.circle {
            
            // Set the center of the circle to be the center of the view
            let center = CGPoint(x: self.spinner.overlayView.frame.midX - radius, y: self.spinner.overlayView.frame.midY - radius)
            circle.position = CGPoint(x: (self.spinner.overlayView.frame.width - borderWidth)/2, y: (self.spinner.overlayView.frame.height - borderWidth)/2)
            
            func rad(_ degrees:CGFloat) -> CGFloat {
                return (degrees * CGFloat(Double.pi))/180
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
            self.spinner.layer.addSublayer(circle)
            
        }
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        
        spinner.layoutOverlayView()
      
    }
    
    open func dismiss() {
        spinner.shouldStopAnimation = true
        UIView.animate(withDuration: self.animationSpeed, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.alpha = 0.0
            }) { (success) -> Void in
                self.removeFromSuperview()
        }
    }
    
    open func animate() {
      
      spinner.shouldStopAnimation = false
      spinner.animate()
    }
  
}

private class JHSpinner : UIView {
  
  var bgColor : UIColor = .red {
    didSet {
      line1.backgroundColor = bgColor
      line2.backgroundColor = bgColor
      line3.backgroundColor = bgColor
    }
  }
  
  var overlayBgColor : UIColor = .black {
    didSet {
      overlayView.backgroundColor = overlayBgColor
    }
  }
  
  var overlay : JHSpinnerOverlay = .roundedSquare
  
  var fullCycleTime : Double = 2.55
  
  var messageLabel = UILabel()
  
  fileprivate var shouldStopAnimation = true
  
  fileprivate let overlayView = UIView()
  private let containerView = UIView()
  
  private let line1 = UIView()
  private let line2 = UIView()
  private let line3 = UIView()
  
  private let lineWidth = CGFloat(6.0)
  private let lineHeight = CGFloat(6.0)
  private let lineMax = CGFloat(26.0)
  private let xMargin = CGFloat(4.0)
  
  private var animationTime : Double {
    get {
      return fullCycleTime / 17
    }
  }
  
  private var midX = CGFloat(0)
  private var midY = CGFloat(0)
  
  private var animationCounter = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.containerView.frame = frame
    addSubview(containerView)
    setup()
  }
  
  required init?(coder:NSCoder) {
    super.init(coder: coder)
  }
  
  private func setup() {
    midX = containerView.frame.width/2
    midY = containerView.frame.height/2
    
    overlayView.center = center
    addSubview(overlayView)
    
    line1.frame = CGRect(x: midX - ((lineWidth / 2) + lineWidth + xMargin), y: midY - (lineHeight/2), width: lineWidth, height: lineHeight)
    line1.backgroundColor = .red
    line1.layer.cornerRadius = lineWidth/2.0
    containerView.addSubview(line1)
    
    
    line2.frame = CGRect(x: CGFloat(midX - (lineWidth / 2)), y: midY - (lineHeight/2), width: lineWidth, height: lineHeight)
    line2.backgroundColor = .red
    line2.layer.cornerRadius = lineWidth/2.0
    containerView.addSubview(line2)
    
    line3.frame = CGRect(x: midX + ((lineWidth / 2) + xMargin), y: midY - (lineHeight/2), width: lineWidth, height: lineHeight)
    line3.backgroundColor = .red
    line3.layer.cornerRadius = lineWidth/2.0
    containerView.addSubview(line3)
    
    bringSubview(toFront: containerView)
   
    overlayView.addSubview(messageLabel)
    
    messageLabel.backgroundColor = .clear
    messageLabel.textColor = .white
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    messageLabel.text = ""
    messageLabel.isHidden = true
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let yPos = (overlayView.bounds.height / 2) + (lineMax / 2) + 8
    let height = overlayView.bounds.height - yPos
    messageLabel.frame = CGRect(x: 0, y: yPos, width: overlayView.bounds.width, height: height)
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
  
  func animate() {
    animateOpenVertical()
  }
  
  private func animateOpenVertical() {
    animationCounter += 1
    UIView.animate(withDuration: self.animationTime, animations: {
      var f = self.line1.frame
      f.size.height = self.lineMax
      f.origin.y = self.midY - ((self.lineMax)/2)
      self.line1.frame = f
    }) { (done) in
      UIView.animate(withDuration: self.animationTime, animations: {
        var f = self.line2.frame
        f.size.height = self.lineMax
        f.origin.y = self.midY - ((self.lineMax)/2)
        self.line2.frame = f
      }) { (done) in
        UIView.animate(withDuration: self.animationTime, animations: {
          var f = self.line3.frame
          f.size.height = self.lineMax
          f.origin.y = self.midY - ((self.lineMax)/2)
          self.line3.frame = f
        }) { (done) in
          if !self.shouldStopAnimation {
            self.animateClosedVertical()
          }
        }
        
      }
      
    }
  }
  
  private func animateClosedVertical() {
    animationCounter += 1
    UIView.animate(withDuration: self.animationTime, animations: {
      var f = self.line1.frame
      f.size.height = self.lineHeight
      f.origin.y = self.midY - (self.lineHeight/2)
      self.line1.frame = f
    }) { (done) in
      UIView.animate(withDuration: self.animationTime, animations: {
        var f = self.line2.frame
        f.size.height = self.lineHeight
        f.origin.y = self.midY - (self.lineHeight/2)
        self.line2.frame = f
      }) { (done) in
        UIView.animate(withDuration: self.animationTime, animations: {
          var f = self.line3.frame
          f.size.height = self.lineHeight
          f.origin.y = self.midY - (self.lineHeight/2)
          self.line3.frame = f
        }) { (done) in
          if !self.shouldStopAnimation {
            if self.animationCounter == 2 {
              self.animateVertical()
            }else {
              self.animateVerticalReverse()
            }
          }
        }
        
      }
      
    }
  }
  
  private func animateVertical() {
    animationCounter += 1
    UIView.animate(withDuration: self.animationTime, animations: {
      var f1 = self.line1.frame
      var f3 = self.line3.frame
      f1.origin.x = CGFloat(self.midX - (self.lineWidth / 2))
      f3.origin.x = CGFloat(self.midX - (self.lineWidth / 2))
      f1.origin.y = self.midY - ((self.lineHeight / 2) + self.lineWidth + self.xMargin)
      f3.origin.y = self.midY + ((self.lineHeight / 2) + self.xMargin)
      self.line1.frame = f1
      self.line3.frame = f3
    }) { (done) in
      if !self.shouldStopAnimation {
        self.animateOpenHorizontal()
      }
    }
  }
  
  private func animateOpenHorizontal() {
    animationCounter += 1
    UIView.animate(withDuration: self.animationTime, animations: {
      var f = self.line1.frame
      f.size.width = self.lineMax
      f.origin.x = self.midX - ((self.lineMax)/2)
      self.line1.frame = f
    }) { (done) in
      UIView.animate(withDuration: self.animationTime, animations: {
        var f = self.line2.frame
        f.size.width = self.lineMax
        f.origin.x = self.midX - ((self.lineMax)/2)
        self.line2.frame = f
      }) { (done) in
        UIView.animate(withDuration: self.animationTime, animations: {
          var f = self.line3.frame
          f.size.width = self.lineMax
          f.origin.x = self.midX - ((self.lineMax)/2)
          self.line3.frame = f
        }) { (done) in
          if !self.shouldStopAnimation {
            self.animateClosedHorizontal()
          }
        }
      }
    }
  }
  
  private func animateClosedHorizontal() {
    animationCounter += 1
    UIView.animate(withDuration: self.animationTime, animations: {
      var f = self.line1.frame
      f.size.width = self.lineWidth
      f.origin.x = self.midX - (self.lineWidth/2)
      self.line1.frame = f
    }) { (done) in
      UIView.animate(withDuration: self.animationTime, animations: {
        var f = self.line2.frame
        f.size.width = self.lineWidth
        f.origin.x = self.midX - (self.lineWidth/2)
        self.line2.frame = f
      }) { (done) in
        UIView.animate(withDuration: self.animationTime, animations: {
          var f = self.line3.frame
          f.size.width = self.lineWidth
          f.origin.x = self.midX - (self.lineWidth/2)
          self.line3.frame = f
        }) { (done) in
          if !self.shouldStopAnimation {
            if self.animationCounter == 5 {
              self.animateHorizontalReverse()
            }else {
              self.animateHorizontal()
            }
          }
        }
      }
    }
  }
  
  private func animateHorizontalReverse() {
    animationCounter += 1
    UIView.animate(withDuration: self.animationTime, animations: {
      var f1 = self.line1.frame
      var f3 = self.line3.frame
      f1.origin.x = self.midX + ((self.lineWidth / 2) + self.xMargin)
      f3.origin.x = self.midX - ((self.lineWidth / 2) + self.lineWidth + self.xMargin)
      f1.origin.y = self.midY - (self.lineHeight/2)
      f3.origin.y = self.midY - (self.lineHeight/2)
      self.line1.frame = f1
      self.line3.frame = f3
    }) { (done) in
      if !self.shouldStopAnimation {
        self.animateOpenVertical()
      }
    }
  }
  
  private func animateVerticalReverse() {
    animationCounter += 1
    UIView.animate(withDuration: self.animationTime, animations: {
      var f1 = self.line1.frame
      var f3 = self.line3.frame
      f1.origin.x = CGFloat(self.midX - (self.lineWidth / 2))
      f3.origin.x = CGFloat(self.midX - (self.lineWidth / 2))
      f1.origin.y = self.midY + ((self.lineHeight / 2) + self.xMargin)
      f3.origin.y = self.midY - ((self.lineHeight / 2) + self.lineWidth + self.xMargin)
      self.line1.frame = f1
      self.line3.frame = f3
    }) { (done) in
      if !self.shouldStopAnimation {
        self.animateOpenHorizontal()
      }
    }
  }
  
  private func animateHorizontal() {
    animationCounter += 1
    UIView.animate(withDuration: self.animationTime, animations: {
      var f1 = self.line1.frame
      var f3 = self.line3.frame
      f1.origin.x = self.midX - ((self.lineWidth / 2) + self.lineWidth + self.xMargin)
      f3.origin.x = self.midX + ((self.lineWidth / 2) + self.xMargin)
      f1.origin.y = self.midY - (self.lineHeight/2)
      f3.origin.y = self.midY - (self.lineHeight/2)
      self.line1.frame = f1
      self.line3.frame = f3
    }) { (done) in
      self.animationCounter = 0
      if !self.shouldStopAnimation {
        self.animateOpenVertical()
      }
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
