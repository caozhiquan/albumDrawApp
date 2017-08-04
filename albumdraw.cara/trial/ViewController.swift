//
//  ViewController.swift
//  trial
//
//  Created by chuangke-15 on 2017/8/1.
//  Copyright © 2017年 makeschool. All rights reserved.
//
//
//
import UIKit









class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    

    
    @IBAction func startoverButton(_ sender: UIButton) {
        tempImageView.image = nil
        
    }
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var tempImageView: UIImageView!
    var lastPoint = CGPoint.zero
    var red: CGFloat = 204/255
    var green: CGFloat = 153/255
    var blue: CGFloat = 51/255
    var brushWidth: CGFloat = 5.0
    var opacity: CGFloat = 1.0
    var swiped = false

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            
            lastPoint = touch.location(in: self.view)
        }
        //super.touchesBegan(touches, with: event)
    }

    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        
        tempImageView.image?.draw(in: view.bounds)
        
        let context = UIGraphicsGetCurrentContext()
        //override func drawLineFrom(_ fromPoint: CGPoint, toPoint: CGPoint) {
        
        
        // 1
        //UIGraphicsBeginImageContext(view.frame.size)
        
        //tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        // 2
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        // 3
        //context?.setLineCap(CGLineCap.round)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
        //context.setBlendMode(kCGBlendModeNormal)
        context?.setBlendMode(CGBlendMode.normal)
        
        // 4
        context?.strokePath()
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first as? UITouch {
            
            let currentPoint = touch.location(in: view)
            //drawLineFrom(lastPoint, toPoint: currentPoint)
            //drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
            drawLine( from: lastPoint, to: currentPoint)
            // 7
            lastPoint = currentPoint
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //super.touchesEnded(touches, with: event)
        if !swiped {
            // draw a single point
            drawLine( from: lastPoint, to: lastPoint)
            
            //drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        //        // Merge tempImageView into mainImageView
        //        UIGraphicsBeginImageContext(mainImageView.frame.size)
        //        mainImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        //        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
        //        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        //        UIGraphicsEndImageContext()
        //
        //        tempImageView.image = nil
        
    }

    
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var myImageView: UIImageView!
    
    let picker = UIImagePickerController()
    
    @IBAction func photoFromLibrary(_ sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        //?
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
        //?
        picker.popoverPresentationController?.barButtonItem = sender
        
    }
    
    @IBAction func shootPhoto(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    func noCamera(){
    
            let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        
        
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
        
    }
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        myImageView.contentMode = .scaleAspectFit //3
        myImageView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}



