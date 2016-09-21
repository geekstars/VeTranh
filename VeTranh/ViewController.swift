//
//  ViewController.swift
//  VeTranh
//
//  Created by Hoàng Minh Thành on 9/19/16.
//  Copyright © 2016 Hoàng Minh Thành. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var lastPoint: CGPoint = CGPoint(x: 0, y: 0)
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var baseImage = UIImage()
    let imgColors = ["Black","Grey","Red","Blue","LightBlue","DarkGreen","LightGreen","Brown","DarkOrange","Yellow"]
    let colors:[(CGFloat, CGFloat, CGFloat)] = [
                (0, 0, 0),
                (105.0/255.0, 105.0/255.0, 105.0/255.0),
                (1.0, 0, 0),
                (0, 0, 1.0),
                (51.0/255.0, 204.0/255/0, 1.0),
                (102.0/255.0, 204.0/255, 0),
                (102.0/255, 1.0, 0),
                (160.0/255.0, 82.0/255.0, 45.0/255.0),
                (1.0, 120.0/255.0, 0),
                (1.0, 1.0, 0),
                (1.0, 1.0, 1.0)
    ]
    @IBOutlet weak var mainView: UIImageView!
    
    @IBAction func reset(_ sender: AnyObject) {
        mainView.image = baseImage
    }
    
    @IBAction func album(_ sender: AnyObject) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imgPicker, animated: true, completion: nil)
    }
    @IBAction func save(_ sender: AnyObject) {
        
        UIImageWriteToSavedPhotosAlbum(mainView.image!, self, nil, nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage:UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage
        {
            baseImage = pickedImage
            mainView.image = baseImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func buttonClick(_ sender: AnyObject) {
        let index = Int(sender.tag)
        switch (index)
        {
            case 0: brushWidth = 5
            case 1: brushWidth = 10
            case 2: brushWidth = 30
            case 3: (red, green, blue) = colors[10]
            default: break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touches = touches.first
        {
            lastPoint = touches.location(in: view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first
        {
            let currentPoint = touch.location(in: mainView)
            drawLineFome(fromPoint: lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!swiped)
        {
            drawLineFome(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }
    
    var line = 0
    
    @IBAction func draw_round(_ sender: UIButton) {
        line = 1
    }
    
    @IBAction func draw_butt(_ sender: UIButton) {
        line = 2
    }
    
    @IBAction func draw_small(_ sender: UIButton) {
        line = 3
    }
    
    @IBAction func draw_square(_ sender: UIButton) {
        line = 4
    }
    
    func drawLineFome(fromPoint: CGPoint, toPoint: CGPoint)
    {
        UIGraphicsBeginImageContext(mainView.frame.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        mainView.image?.draw(in: CGRect(x: 0, y: 0, width: mainView.frame.size.width, height: mainView.frame.size.height))
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        
        switch line {
        case 1: context?.setLineCap(CGLineCap.round)
        case 2: context?.setLineCap(CGLineCap.butt)
        case 3: context?.setLineCap(CGLineCap.init(rawValue: 2)!)
        case 4: context?.setLineCap(CGLineCap.square)
        default:
            context?.setLineCap(CGLineCap.round)
        }
        
        context?.setLineWidth(CGFloat(brushWidth))

        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        context?.setBlendMode(CGBlendMode.normal)
        
        context?.strokePath()
        
        mainView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        mainView.alpha = opacity
        
        UIGraphicsEndImageContext()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CellCustomize
        
        //cell.filteredImageView.image = UIImage(named: imgColors[indexPath.item])!
        cell.filteredImageView.image = UIImage(named: imgColors[(indexPath as NSIndexPath).item])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        (red,green,blue) = colors[indexPath.item]
    }
}

