import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,FlutterStreamHandler {
    
    
    let imageVc = UIImagePickerController()
    
    var method : FlutterMethodChannel?
    
    var basicChannel : FlutterBasicMessageChannel?
    
    var eventChannel : FlutterEventChannel?
    var eventSink : FlutterEventSink?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    //MethodChannel
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
    
    
    //BasicChannel
    basicChannel = FlutterBasicMessageChannel(name: "flutter_basic_channel", binaryMessenger: self.window.rootViewController as! FlutterBinaryMessenger)
    basicChannel!.setMessageHandler { (obj, rep) in
        print((obj as! String) + "-->iOS")
        rep("iOS-->reply-->")
    }
    
    //eventChannel
    eventChannel = FlutterEventChannel(name: "flutter_event_channel", binaryMessenger: self.window.rootViewController as! FlutterBinaryMessenger)
    //设置channel代理
    eventChannel?.setStreamHandler(self)
    FlutterMethodChannel(name: "flutter_method_channel", binaryMessenger: self.window.rootViewController as! FlutterBinaryMessenger).setMethodCallHandler { (call, _) in
        if call.method == "get_battery" {
            let device = UIDevice()
            //主动发送数据
            self.eventSink!("\(device.systemVersion)")
        }
    }
    
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    //MARK: imagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if #available(iOS 11.0, *) {
            let picFile = (info[UIImagePickerController.InfoKey.imageURL] as! NSURL).absoluteString
            method?.invokeMethod("get_picture", arguments: picFile!, result: { (val) in
                print("ios - \(val!)")
            })
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    //MARK: eventChannel-delegate
    //获取消息发送器
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
}
