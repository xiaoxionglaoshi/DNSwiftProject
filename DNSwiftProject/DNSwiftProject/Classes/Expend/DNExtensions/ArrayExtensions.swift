
// 来自EZSwiftExtensions https://github.com/goktugyil/EZSwiftExtensions
import Foundation

extension Array {
    public func get(at range: ClosedRange<Int>) -> Array {
        var subArray = Array()
        let lowerBound = range.lowerBound > 0 ? range.lowerBound : 0
        let upperBound = range.upperBound > self.count - 1 ? self.count - 1 : range.upperBound
        for index in lowerBound...upperBound {
            subArray.append(self[index])
        }
        return subArray
    }
}
