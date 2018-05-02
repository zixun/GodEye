//
//  AssistiveButton.swift
//  Pods
//
//  Created by zixun on 16/12/25.
//
//

import Foundation

//MARK: AssistiveButton
open class AssistiveButton: UIButton {
    
    //MARK: Public Var
    open var moveEnable = true
    
    open var didTap: (()->())?
    
    //MARK: Init
    public init(frame: CGRect,normalImage:UIImage,highlightedImage:UIImage? = nil) {
        super.init(frame: frame)
        
        self.setBackgroundImage(normalImage, for: .normal)
        self.setBackgroundImage(highlightedImage, for: .highlighted)
        self.adjustsImageWhenHighlighted = true
        
        self.addTarget(self, action: #selector(AssistiveButton.tap), for: .touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Action
    @objc fileprivate func tap() {
        if self.didMoved {
            return
        }
        
        self.didTap?()
    }
    
    
    //MARK: Override
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.didMoved = false
        
        super.touchesBegan(touches, with: event)
        
        guard self.moveEnable == true,
            let touch = touches.first else {
                return
        }
        
        self.beginPoint = touch.location(in: self)
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.didMoved = false
        
        guard self.moveEnable == true else {
            return
        }
        
        guard let superview = self.superview else {
            return
        }
        
        guard let touch = touches.first else {
            return
        }
        
        let currentPosition = touch.location(in: self)
        let offsetX = currentPosition.x - self.beginPoint.x
        let offsetY = currentPosition.y - self.beginPoint.y
        
        if fabsf(Float(offsetX)) > 0 || fabsf(Float(offsetY)) > 0 {
            self.didMoved = true
        }
        
        //center position after move
        self.center = CGPoint(x: self.center.x + offsetX, y: self.center.y + offsetY)
        
        //left and right limit coordinates of X axis
        if (self.center.x > (superview.frame.size.width-self.frame.size.width / 2)) {
            let x = superview.frame.size.width-self.frame.size.width / 2;
            self.center = CGPoint(x:x, y:self.center.y + offsetY);
        }else if (self.center.x < self.frame.size.width / 2){
            let x = self.frame.size.width / 2;
            self.center = CGPoint(x:x, y:self.center.y + offsetY);
        }
        
        //Upper and lower limit coordinates of Y axis
        if (self.center.y > (superview.frame.size.height-self.frame.size.height/2)) {
            let x = self.center.x;
            let y = superview.frame.size.height-self.frame.size.height/2;
            self.center = CGPoint(x:x, y:y);
        }else if (self.center.y <= self.frame.size.height/2){
            let x = self.center.x;
            let y = self.frame.size.height/2;
            self.center = CGPoint(x:x, y:y);
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard self.moveEnable == true else {
            return
        }
        
        guard let superview = self.superview else {
            return
        }
        
        if (self.center.x >= superview.frame.size.width/2) {//Move to the right
            //move animation
            UIView.beginAnimations("move", context: nil)
            UIView.setAnimationDuration(0.2)
            UIView.setAnimationDelegate(self)
            self.frame = CGRect(x: superview.frame.size.width - self.frame.size.width, y: self.center.y - self.frame.size.height / 2.0, width: self.frame.size.width, height: self.frame.size.height)
            UIView.commitAnimations()
        }else{//move to the left
            UIView.beginAnimations("move", context: nil)
            UIView.setAnimationDuration(0.2)
            UIView.setAnimationDelegate(self)
            self.frame = CGRect(x: 0, y: self.center.y - self.frame.size.height / 2.0, width: self.frame.size.width, height: self.frame.size.height)
            UIView.commitAnimations()
        }
        
        super.touchesEnded(touches, with: event)
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
    
    //MARK: Private Var
    fileprivate var beginPoint = CGPoint.zero
    
    fileprivate var didMoved = false
}
