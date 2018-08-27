

import Foundation

public class SwiftSMSAnalyzer {
    
    private static let gsm7bitChars = "@£$¥èéùìòÇØøÅåΔ_ΦΓΛΩΠΨΣΘΞÆæßÉ!\"#¤%&'()*+,-./0123456789:;<=>?¡ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÑÜ§¿abcdefghijklmnopqrstuvwxyzäöñüà \u{000A}\u{000D}"
    private static let gsm7bitExChar = "\\^{}[~]|€\u{008E}\u{21A1}"
    
    private static let gsm7bitRegExp = NSPredicate(format:"SELF MATCHES %@", "^[" + SwiftSMSAnalyzer.gsm7bitChars + "]*$")
    private static let gsm7bitExRegExp = NSPredicate(format:"SELF MATCHES %@", "^[" + SwiftSMSAnalyzer.gsm7bitChars + SwiftSMSAnalyzer.gsm7bitExChar + "]*$")
    private static let gsm7bitExOnlyRegExp = NSPredicate(format:"SELF MATCHES %@", "^[\\" + SwiftSMSAnalyzer.gsm7bitExChar + "]*$")
    
    public static let GSM_7BIT = "GSM_7BIT"
    public static let GSM_7BIT_EX = "GSM_7BIT_EX"
    public static let UTF16 = "UTF16"
    
    private static let messageLength = [
        GSM_7BIT: 160,
        GSM_7BIT_EX: 160,
        UTF16: 70
    ]
    
    private static let multiMessageLength = [
        GSM_7BIT: 153,
        GSM_7BIT_EX: 153,
        UTF16: 67
    ]
    
    public static func analyze(text: String) -> (encoding: String, length: Int, perMessage: Int, remaining: Int, messages: Int) {
        var encoding: String, length: Int, messages: Int, perMessage: Int, remaining: Int
        encoding = SwiftSMSAnalyzer.detectEncoding(text: text)
        length = (text as NSString).length
        if (encoding == SwiftSMSAnalyzer.GSM_7BIT_EX) {
            length += SwiftSMSAnalyzer.countGsm7bitEx(text: text)
        }
        else if encoding == SwiftSMSAnalyzer.UTF16 {
            length = text.count
        }
        perMessage = SwiftSMSAnalyzer.messageLength[encoding]!
        if (length > perMessage) {
            perMessage = SwiftSMSAnalyzer.multiMessageLength[encoding]!
        }
        messages = Int(ceil(Double(length)/Double(perMessage)))
        remaining = Int((perMessage * messages) - length)
        if(remaining == 0 && messages == 0){
            remaining = Int(perMessage)
        }
        return (encoding: encoding, length: length, perMessage: perMessage, remaining: remaining, messages: messages)
    }
    
    static func detectEncoding(text: String) -> String {
        switch (true) {
        case SwiftSMSAnalyzer.gsm7bitRegExp.evaluate(with: text):
            return SwiftSMSAnalyzer.GSM_7BIT
        case SwiftSMSAnalyzer.gsm7bitExRegExp.evaluate(with: text):
            return SwiftSMSAnalyzer.GSM_7BIT_EX
        default:
            return SwiftSMSAnalyzer.UTF16
        }
    }
    
    private static func countGsm7bitEx(text: String) -> Int {
        var char2: Character!
        var chars: String = ""
        chars = {
            let _len = (text as NSString).length
            var _results: String = ""
            for _i in 0..<_len {
                char2 = text[_i]
                if (SwiftSMSAnalyzer.gsm7bitExOnlyRegExp.evaluate(with: String.init(char2))) {
                    _results.append(char2)
                }
            }
            return _results
        }()
        return (chars as NSString).length
    }
}


private extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}
