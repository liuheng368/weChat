import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    var method : FlutterMethodChannel?
    let imageVc = UIImagePickerController()
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    method = FlutterMethodChannel(name: "mine_page", binaryMessenger: self.window.rootViewController as! FlutterBinaryMessenger)
    method?.setMethodCallHandler({ (call, res) in
        if call.method == "open_picture" {
            self.imageVc.sourceType = .photoLibrary
            self.imageVc.delegate = self
            self.window.rootViewController?.present(self.imageVc, animated: true, completion: nil)
        }else if call.method == "vc-disminss"{
            self.imageVc.dismiss(animated: true, completion: nil)
        }
        res("ios——setMethodCallHandler")
    })
    
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if #available(iOS 11.0, *) {
            let picFile = (info[UIImagePickerController.InfoKey.imageURL] as! NSURL).absoluteString
            method?.invokeMethod("get_picture", arguments: picFile!, result: { (val) in
                print("ios - \(val)")
            })
        } else {
            // Fallback on earlier versions
        }
        
    }
}
