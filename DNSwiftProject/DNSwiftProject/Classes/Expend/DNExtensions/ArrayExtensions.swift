
// 所有扩展来自EZSwiftExtensions整理 https://github.com/goktugyil/EZSwiftExtensions

public func == <T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case (.some(let lhs), .some(let rhs)):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}

extension Array {
    
    ///EZSE: 获取指定范围内的元素
    public func get(at range: ClosedRange<Int>) -> Array {
        var subArray = Array()
        let lowerBound = range.lowerBound > 0 ? range.lowerBound : 0
        let upperBound = range.upperBound > self.count - 1 ? self.count - 1 : range.upperBound
        for index in lowerBound...upperBound {
            subArray.append(self[index])
        }
        return subArray
    }
    
    /// EZSE: 是否包含某种类型
    public func containsType<T>(of element: T) -> Bool {
        let elementType = type(of: element)
        return first { type(of: $0) == elementType} != nil
    }
    
    /// EZSE: 将数组分解成第一个元素和其他元素组成的元组
    public func decompose() -> (head: Iterator.Element, tail: SubSequence)? {
        return (count > 0) ? (self[0], self[1..<count]) : nil
    }
    
    /// EZSE: 遍历数组,返回元素及其下标
    public func forEachEnumerated(_ body: @escaping (_ offset: Int, _ element: Element) -> ()) {
        self.enumerated().forEach(body)
    }
    
    /// EZSE: 获取指定下标的元素
    public func get(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
    
    /// EZSE: 在数组第一个位置插入元素
    public mutating func insertFirst(_ newElement: Element) {
        insert(newElement, at: 0)
    }
    
    /// EZSE: 随机取一个元素
    public func random() -> Element? {
        guard count > 0 else { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
    /// EZSE: 反向索引,例:reverseIndex(1),返回从后往前1位元素的Index
    public func reverseIndex(_ index: Int) -> Int? {
        guard index >= 0 && index < count else { return nil }
        return Swift.max(self.count - 1 - index, 0)
    }
    
    /// EZSE: 打乱数组的排列顺序Fisher-Yates-Durstenfeld算法
    public mutating func shuffle() {
        guard self.count > 1 else { return }
        var j: Int
        for i in 0..<(self.count-2) {
            j = Int(arc4random_uniform(UInt32(self.count - i)))
            if i != i+j { swap(&self[i], &self[i+j]) }
        }
    }
    
    /// EZSE: 打乱数组并返回打乱后的数组
    public func shuffled() -> Array {
        var result = self
        result.shuffle()
        return result
    }
    
    /// EZSE: 从数组中取出给定数量的元素
    public func takeMax(_ n: Int) -> Array {
        return Array(self[0..<Swift.max(0, Swift.min(n, count))])
    }
    
    /// EZSE: .数组元素自我测试返回真假
    public func testAll(_ body: @escaping (Element) -> Bool) -> Bool {
        return self.first { !body($0) } == nil
    }
    
    /// EZSE: 检查数组中所有元素是真或假
    public func testAll(is condition: Bool) -> Bool {
        return testAll { ($0 as? Bool) ?? !condition == condition }
    }
}

extension Array where Element: Equatable {
    
    /// EZSE: 检查数组中是否包含参数数组
    public func contains(_ array: [Element]) -> Bool {
        return array.testAll { self.index(of: $0) ?? -1 >= 0 }
    }
    
    /// EZSE: 检查数组中是否包含参数元素
    public func contains(_ elements: Element...) -> Bool {
        return elements.testAll { self.index(of: $0) ?? -1 >= 0 }
    }
    
    /// EZSE: 返回参数元素的下标
    public func indexes(of element: Element) -> [Int] {
        return self.enumerated().flatMap { ($0.element == element) ? $0.offset : nil }
    }
    
    /// EZSE: 返回最后一个索引元素
    public func lastIndex(of element: Element) -> Int? {
        return indexes(of: element).last
    }
    
    /// EZSE: 删除第一个索引元素
    public mutating func removeFirst(_ element: Element) {
        guard let index = self.index(of: element) else { return }
        self.remove(at: index)
    }
    
    // EZSE: 删除所有参数元素
    public mutating func removeAll(_ elements: Element...) {
        for element in elements {
            for index in self.indexes(of: element).reversed() {
                self.remove(at: index)
            }
        }
    }
    
    /// EZSE: 数组跟参数数组不同的元素
    public func difference(_ values: [Element]...) -> [Element] {
        var result = [Element]()
        elements: for element in self {
            for value in values {
                if value.contains(element) {
                    continue elements
                }
            }
            result.append(element)
        }
        return result
    }
    
    /// EZSE: 数组跟参数数组相同的元素
    public func intersection(_ values: [Element]...) -> Array {
        var result = self
        var intersection = Array()
        for (i, value) in values.enumerated() {
            if i > 0 {
                result = intersection
                intersection = Array()
            }
            value.forEach { (item: Element) -> Void in
                if result.contains(item) {
                    intersection.append(item)
                }
            }
        }
        return intersection
    }
    
    /// EZSE: 数组+参数数组中不同的元素的 如["a", "b"].union(["b", "c"]) = ["a", "b", "c"]
    public func union(_ values: [Element]...) -> Array {
        var result = self
        for array in values {
            for value in array {
                if !result.contains(value) {
                    result.append(value)
                }
            }
        }
        return result
    }
    
    /// EZSE: 返回一个不重复的数组
    public func unique() -> Array {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
}

