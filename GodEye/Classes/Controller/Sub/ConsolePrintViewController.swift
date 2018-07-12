//
//  ConsolePrintViewController.swift
//  Pods
//
//  Created by zixun on 16/12/28.
//
//

import Foundation
import ESPullToRefresh
import SwViewCapture

class ConsolePrintViewController: UIViewController {
    
    private var type:RecordType!
    
    init(type:RecordType) {
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        
        self.type = type
        self.dataSource = RecordTableViewDataSource(type: type)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = []
        self.navigationController?.navigationBar.barStyle = .black
        self.view.backgroundColor = UIColor.niceBlack()
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .trash,
                                                                   target: self,
                                                                   action: #selector(ConsolePrintViewController.handleDeleteButtonTap)),UIBarButtonItem(barButtonSystemItem: .action,
                                                                   target: self,
                                                                   action: #selector(ConsolePrintViewController.handleSharedButtonTap))]
        
        self.view.addSubview(self.recordTableView)
        self.view.addSubview(self.inputField)
        
        self.recordTableView.es.addPullToRefresh { [weak self] in
            guard let sself = self else {
                return
            }
            
            let result = sself.dataSource.loadPrePage()
            if result == true {
                sself.recordTableView.reloadData()
            }
            sself.recordTableView.es.stopPullToRefresh()
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ConsolePrintViewController.keyboardWillShow(noti:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ConsolePrintViewController.keyboardWillHide(noti:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var rect = self.view.bounds
        if self.type == .command {
            let height: CGFloat = 28.0
            var rect = self.view.bounds
            rect.origin.x = 5
            rect.origin.y = rect.size.height - height - 5
            rect.size.width -= rect.origin.x * 2
            rect.size.height = height
            self.inputField.frame = rect
            
            self.recordTableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.inputField.frame.minY)
        }else {
           self.recordTableView.frame = rect
            self.inputField.frame = CGRect.zero
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.recordTableView.smoothReloadData(need: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.recordTableView.scrollToBottom(animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true

    }
    
    func addRecord(model:RecordORMProtocol) {
        
        self.dataSource.addRecord(model: model)
        
        if self.view.superview != nil {
            self.recordTableView.smoothReloadData(need: false)
        }
    }
    
    @objc private func handleSharedButtonTap() {
        
        let image = self.recordTableView.swContentCapture { [unowned self] (image:UIImage?) in
            
            let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            if let popover = activity.popoverPresentationController {
                popover.sourceView = self.view
                popover.permittedArrowDirections = .up
            }
            self.present(activity, animated: true, completion: nil)
        }
    }
    
    @objc private func handleDeleteButtonTap() {
        self.type.model()?.delete(complete: { [unowned self] (finish:Bool) in
            self.dataSource.cleanRecord()
            self.recordTableView.reloadData()
        })
    }
    
    private lazy var recordTableView: RecordTableView = { [unowned self] in
        let new = RecordTableView()
        new.delegate = self.dataSource
        new.dataSource = self.dataSource
        return new
    }()
    
    private lazy var inputField: UITextField = { [unowned self] in
        let new = UITextField(frame: CGRect.zero)
        new.borderStyle = .roundedRect
        new.font = UIFont.courier(with: 12)
        new.autocapitalizationType = .none
        new.autocorrectionType = .no
        new.returnKeyType = .done
        new.enablesReturnKeyAutomatically = false
        new.clearButtonMode = .whileEditing
        new.contentVerticalAlignment = .center
        new.placeholder = "Enter command..."
        new.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        new.delegate = self
        return new
    }()
    
    private var dataSource: RecordTableViewDataSource!
    
    fileprivate var originRect: CGRect = CGRect.zero
}


extension ConsolePrintViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        guard text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "" else {
            return
        }
        
        GodEyeController.shared
            .configuration
            .command
            .execute(command: text) { [unowned self] (model:CommandRecordModel) in
                
                model.insert(complete: { (true:Bool) in
                    self.addRecord(model: model)
                })
        }
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    @objc fileprivate func keyboardWillShow(noti:NSNotification) {
        guard let userInfo = noti.userInfo else {
            return
        }
        
        guard let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        guard let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UIViewAnimationCurve.RawValue else {
            return
        }
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(duration)
        UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve)!)
        
        var bounds = self.view.frame
        self.originRect = bounds
        switch UIApplication.shared.statusBarOrientation {
            
        case .portraitUpsideDown:
            bounds.origin.y += frame.size.height
            bounds.size.height -= frame.size.height
            
        case .landscapeLeft:
            bounds.size.width -= frame.size.width
            
        case .landscapeRight:
            bounds.origin.x += frame.size.width
            bounds.size.width -= frame.size.width
            
        default:
            bounds.size.height -= frame.size.height
        }
        self.view.frame = bounds
        
        UIView.commitAnimations()
    }
    
    @objc fileprivate func keyboardWillHide(noti:NSNotification) {
        guard let userInfo = noti.userInfo else {
            return
        }
        
        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        guard let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UIViewAnimationCurve.RawValue else {
            return
        }
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(duration)
        UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve)!)
        self.view.frame = self.originRect
        UIView.commitAnimations()
    }
}
