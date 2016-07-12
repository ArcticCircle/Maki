///////////////////////////////////////////////////////////////////////////
// TINY KRISTY ENGINE FOR SWIFT
// CREATED BY KELIN.SASHA
///////////////////////////////////////////////////////////////////////////
import Foundation
import SystemConfiguration
import UIKit
import SpriteKit
///////////////////////////////////////////////////////////////////////////
public let ReachabilityChangedNotification = "ReachabilityChangedNotification"
///////////////////////////////////////////////////////////////////////////
/** Return a random number below. */
func KErandom(i:Int)->(Int)
{
    if(i<1)
    {
        return(0)
    }
    let k:Int=Int(arc4random()%UInt32(i))
    return(k)
}
func KEr()->(Int)
{
    if(KErandom(2)==0)
    {
        return(1)
    }else{
        return(-1)
    }
}
///////////////////////////////////////////////////////////////////////////
/** Return middle point of a SpriteKit scene. */
func KEmiddleScreen(s:SKScene)->(CGPoint)
{
    let p=CGPoint(x:CGRectGetMidX(s.frame), y:CGRectGetMidY(s.frame))
    return(p)
}
///////////////////////////////////////////////////////////////////////////
extension UIButton
{
    /** Set title and its color. */
    func KEsetTitle(t:String,color:UIColor,Alpha:Float)
    {
        self.setTitle("\(t)", forState: UIControlState.Normal)
        self.setTitleColor(color, forState: UIControlState.Normal)
        self.alpha=CGFloat(Alpha)
    }
}
///////////////////////////////////////////////////////////////////////////
/** NSDate -> String */
func KEgetDateString(date:NSDate)->(String)
{
    let dateFormatter=NSDateFormatter()
    dateFormatter.dateStyle=NSDateFormatterStyle.MediumStyle
    dateFormatter.timeStyle=NSDateFormatterStyle.MediumStyle
    return(dateFormatter.stringFromDate(date))
}
///////////////////////////////////////////////////////////////////////////
/** String -> NSDate */
func KEgetDate(date:String)->(NSDate)
{
    let dateFormatter=NSDateFormatter()
    dateFormatter.dateStyle=NSDateFormatterStyle.MediumStyle
    dateFormatter.timeStyle=NSDateFormatterStyle.MediumStyle
    return(dateFormatter.dateFromString(date)!)
}
///////////////////////////////////////////////////////////////////////////
/** Return the distance of 2 CGPoints */
func KEpointDistance(p1:CGPoint,p2:CGPoint)->(CGFloat)
{
    let x:CGFloat=p1.x-p2.x
    let y:CGFloat=p1.y-p2.y
    let r:CGFloat=sqrt(x*x+y*y)
    return(r)
}
///////////////////////////////////////////////////////////////////////////
/** Used for flash image numbers */
func numTochar(num:Int)->(String)
{
    var numstr:String="\(num)"
    for _ in numstr.characters.count..<4
    {
        numstr="0\(numstr)"
    }
    return(numstr)
}
///////////////////////////////////////////////////////////////////////////
/** Used for init the len of the SKScene */
func ProjectWindow(WX:CGFloat,WY:CGFloat,TX:Int,TY:Int) -> (CGFloat)
{
    let k:CGFloat = CGFloat(TX) / CGFloat(TY)
    let NWX:CGFloat = CGFloat(WY)*k
    var len:CGFloat = 0
    if NWX < WX
    {
        len = CGFloat(WY) / CGFloat(TY)
    }else{
        len = CGFloat(WX) / CGFloat(TX)
    }
    return len
}
///////////////////////////////////////////////////////////////////////////
/** Download advertisements */
func KEgetAdvertisement(name:String,lastNumber:Int)
{
    return/*
    let reachability=Reachability.reachabilityForInternetConnection()
    if(reachability!.isReachable()==true)
    {
        for i in (lastNumber-5)..<50
        {
            let url:NSURL=NSURL(string:"http://www.stonegatekeeper.me/~kelinsasha/AppAdvertisement/\(name)\(i).png")!
            print(url.host)
            continue
            var data=NSData()
            do
            {
                data=try NSData(contentsOfURL:url)!
            }catch{
                print("asd")
            }
            
            if(url==url)
            {
                print("http://www.stonegatekeeper.me/~kelinsasha/AppAdvertisement/WhiteHorror\(i).png")
                print("It is nil...")
            }else{
                print("http://www.stonegatekeeper.me/~kelinsasha/AppAdvertisement/WhiteHorror\(i).png")
                print("It is OK...")
                break
            }
        }
    }
    //let data:NSData=NSData(contentsOfURL:url)!
    //var image = UIImage(data:data, scale: 1.0)*/
}
///////////////////////////////////////////////////////////////////////////
/** Load atlas */
func loadAtlas(name:String,startnum:Int,endnum:Int,time:NSTimeInterval)->(SKAction)
{
    var Atlas:[SKTexture]=[]
    for i in startnum...endnum
    {
        let imageName:String="\(name)\(numTochar(i))"
        let newAtlas:SKTexture=SKTexture(imageNamed: imageName)
        newAtlas.filteringMode = .Nearest
        Atlas.append(newAtlas)
    }
    let Anim:SKAction=SKAction.animateWithTextures(Atlas,
        timePerFrame:time)
    return(Anim)
}
func disloadAtlas(name:String,startnum:Int,endnum:Int,time:NSTimeInterval)->(SKAction)
{
    var Atlas:[SKTexture]=[]
    for i in startnum...endnum
    {
        let imageName:String="\(name)\(numTochar(i))"
        let newAtlas:SKTexture=SKTexture(imageNamed: imageName)
        newAtlas.filteringMode = .Nearest
        Atlas.insert(newAtlas, atIndex: 0)
    }
    let Anim:SKAction=SKAction.animateWithTextures(Atlas,
                                                   timePerFrame:time)
    return(Anim)
}
///////////////////////////////////////////////////////////////////////////
func callback(reachability:SCNetworkReachability, flags: SCNetworkReachabilityFlags, info: UnsafeMutablePointer<Void>) {
    let reachability = Unmanaged<Reachability>.fromOpaque(COpaquePointer(info)).takeUnretainedValue()
    
    dispatch_async(dispatch_get_main_queue()) {
        reachability.reachabilityChanged(flags)
    }
}
///////////////////////////////////////////////////////////////////////////
public class Reachability: NSObject {
    public typealias NetworkReachable = (Reachability) -> ()
    public typealias NetworkUnreachable = (Reachability) -> ()
    public enum NetworkStatus: CustomStringConvertible {
        case NotReachable, ReachableViaWiFi, ReachableViaWWAN
        public var description: String {
            switch self {
            case .ReachableViaWWAN:
                return "Cellular"
            case .ReachableViaWiFi:
                return "WiFi"
            case .NotReachable:
                return "No Connection"
            }
        }
    }
    public var whenReachable: NetworkReachable?
    public var whenUnreachable: NetworkUnreachable?
    public var reachableOnWWAN: Bool
    public var notificationCenter = NSNotificationCenter.defaultCenter()
    public var currentReachabilityStatus: NetworkStatus {
        if isReachable() {
            if isReachableViaWiFi() {
                return .ReachableViaWiFi
            }
            if isRunningOnDevice {
                return .ReachableViaWWAN
            }
        }
        return .NotReachable
    }
    public var currentReachabilityString: String {
        return "\(currentReachabilityStatus)"
    }
    required public init?(reachabilityRef: SCNetworkReachability?) {
        reachableOnWWAN = true
        self.reachabilityRef = reachabilityRef
    }
    public convenience init?(hostname: String) {
        let nodename = (hostname as NSString).UTF8String
        let ref = SCNetworkReachabilityCreateWithName(nil, nodename)
        self.init(reachabilityRef: ref)
    }
    public class func reachabilityForInternetConnection() -> Reachability? {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let ref = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        return Reachability(reachabilityRef: ref)
    }
    public class func reachabilityForLocalWiFi() -> Reachability? {
        var localWifiAddress: sockaddr_in = sockaddr_in(sin_len: __uint8_t(0), sin_family: sa_family_t(0), sin_port: in_port_t(0), sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        localWifiAddress.sin_len = UInt8(sizeofValue(localWifiAddress))
        localWifiAddress.sin_family = sa_family_t(AF_INET)
        let address: UInt32 = 0xA9FE0000
        localWifiAddress.sin_addr.s_addr = in_addr_t(address.bigEndian)
        let ref = withUnsafePointer(&localWifiAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        return Reachability(reachabilityRef: ref)
    }
    public func startNotifier() -> Bool {
        if notifierRunning { return true }
        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        context.info = UnsafeMutablePointer(Unmanaged.passUnretained(self).toOpaque())
        if SCNetworkReachabilitySetCallback(reachabilityRef!, callback, &context) {
            if SCNetworkReachabilitySetDispatchQueue(reachabilityRef!, reachabilitySerialQueue) {
                notifierRunning = true
                return true
            }
        }
        stopNotifier()
        return false
    }
    public func stopNotifier() {
        if let reachabilityRef = reachabilityRef {
            SCNetworkReachabilitySetCallback(reachabilityRef, nil, nil)
            SCNetworkReachabilitySetDispatchQueue(reachabilityRef, nil)
        }
        notifierRunning = false
    }
    public func isReachable() -> Bool {
        return isReachableWithTest({ (flags: SCNetworkReachabilityFlags) -> (Bool) in
            return self.isReachableWithFlags(flags)
        })
    }
    public func isReachableViaWWAN() -> Bool {
        if isRunningOnDevice {
            return isReachableWithTest() { flags -> Bool in
                if self.isReachable(flags) {
                    if self.isOnWWAN(flags) {
                        return true
                    }
                }
                return false
            }
        }
        return false
    }
    public func isReachableViaWiFi() -> Bool {
        return isReachableWithTest() { flags -> Bool in
            if self.isReachable(flags) {
                if self.isRunningOnDevice {
                    if self.isOnWWAN(flags) {
                        return false
                    }
                }
                return true
            }
            return false
        }
    }
    private var isRunningOnDevice: Bool = {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return false
        #else
            return true
        #endif
    }()
    private var notifierRunning = false
    private var reachabilityRef: SCNetworkReachability?
    private let reachabilitySerialQueue = dispatch_queue_create("uk.co.ashleymills.reachability", DISPATCH_QUEUE_SERIAL)
    private func reachabilityChanged(flags: SCNetworkReachabilityFlags) {
        if isReachableWithFlags(flags) {
            if let block = whenReachable {
                block(self)
            }
        } else {
            if let block = whenUnreachable {
                block(self)
            }
        }
        notificationCenter.postNotificationName(ReachabilityChangedNotification, object:self)
    }
    private func isReachableWithFlags(flags: SCNetworkReachabilityFlags) -> Bool {
        let reachable = isReachable(flags)
        if !reachable {
            return false
        }
        if isConnectionRequiredOrTransient(flags) {
            return false
        }
        if isRunningOnDevice {
            if isOnWWAN(flags) && !reachableOnWWAN {
                return false
            }
        }
        return true
    }
    private func isReachableWithTest(test: (SCNetworkReachabilityFlags) -> (Bool)) -> Bool {
        if let reachabilityRef = reachabilityRef {
            var flags = SCNetworkReachabilityFlags(rawValue: 0)
            let gotFlags = withUnsafeMutablePointer(&flags) {
                SCNetworkReachabilityGetFlags(reachabilityRef, UnsafeMutablePointer($0))
            }
            if gotFlags {
                return test(flags)
            }
        }
        return false
    }
    private func isConnectionRequired() -> Bool {
        return connectionRequired()
    }
    private func connectionRequired() -> Bool {
        return isReachableWithTest({ (flags: SCNetworkReachabilityFlags) -> (Bool) in
            return self.isConnectionRequired(flags)
        })
    }
    private func isConnectionOnDemand() -> Bool {
        return isReachableWithTest({ (flags: SCNetworkReachabilityFlags) -> (Bool) in
            return self.isConnectionRequired(flags) && self.isConnectionOnTrafficOrDemand(flags)
        })
    }
    private func isInterventionRequired() -> Bool {
        return isReachableWithTest({ (flags: SCNetworkReachabilityFlags) -> (Bool) in
            return self.isConnectionRequired(flags) && self.isInterventionRequired(flags)
        })
    }
    private func isOnWWAN(flags: SCNetworkReachabilityFlags) -> Bool {
        #if os(iOS)
            return flags.contains(.IsWWAN)
        #else
            return false
        #endif
    }
    private func isReachable(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags.contains(.Reachable)
    }
    private func isConnectionRequired(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags.contains(.ConnectionRequired)
    }
    private func isInterventionRequired(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags.contains(.InterventionRequired)
    }
    private func isConnectionOnTraffic(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags.contains(.ConnectionOnTraffic)
    }
    private func isConnectionOnDemand(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags.contains(.ConnectionOnDemand)
    }
    func isConnectionOnTrafficOrDemand(flags: SCNetworkReachabilityFlags) -> Bool {
        return !flags.intersect([.ConnectionOnTraffic, .ConnectionOnDemand]).isEmpty
    }
    private func isTransientConnection(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags.contains(.TransientConnection)
    }
    private func isLocalAddress(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags.contains(.IsLocalAddress)
    }
    private func isDirect(flags: SCNetworkReachabilityFlags) -> Bool {
        return flags.contains(.IsDirect)
    }
    private func isConnectionRequiredOrTransient(flags: SCNetworkReachabilityFlags) -> Bool {
        let testcase:SCNetworkReachabilityFlags = [.ConnectionRequired, .TransientConnection]
        return flags.intersect(testcase) == testcase
    }
    private var reachabilityFlags: SCNetworkReachabilityFlags {
        if let reachabilityRef = reachabilityRef {
            var flags = SCNetworkReachabilityFlags(rawValue: 0)
            let gotFlags = withUnsafeMutablePointer(&flags) {
                SCNetworkReachabilityGetFlags(reachabilityRef, UnsafeMutablePointer($0))
            }
            if gotFlags {
                return flags
            }
        }
        return []
    }
    override public var description: String {
        var W: String
        if isRunningOnDevice {
            W = isOnWWAN(reachabilityFlags) ? "W" : "-"
        } else {
            W = "X"
        }
        let R = isReachable(reachabilityFlags) ? "R" : "-"
        let c = isConnectionRequired(reachabilityFlags) ? "c" : "-"
        let t = isTransientConnection(reachabilityFlags) ? "t" : "-"
        let i = isInterventionRequired(reachabilityFlags) ? "i" : "-"
        let C = isConnectionOnTraffic(reachabilityFlags) ? "C" : "-"
        let D = isConnectionOnDemand(reachabilityFlags) ? "D" : "-"
        let l = isLocalAddress(reachabilityFlags) ? "l" : "-"
        let d = isDirect(reachabilityFlags) ? "d" : "-"
        return "\(W)\(R) \(c)\(t)\(i)\(C)\(D)\(l)\(d)"
    }
    deinit {
        stopNotifier()
        reachabilityRef = nil
        whenReachable = nil
        whenUnreachable = nil
    }
}
///////////////////////////////////////////////////////////////////////////