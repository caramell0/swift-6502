import Foundation

extension Byte {
    var hex: String {
        String(format:"%02X", self)
    }
}
