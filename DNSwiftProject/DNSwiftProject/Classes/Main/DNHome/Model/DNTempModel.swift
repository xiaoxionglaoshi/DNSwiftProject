

struct DNTempModel {
    let enums: [SomeEnums]
    let inner: InnerType
    init?(dictionary: [String: Any]?) {
        let parser = Parser(dictionary: dictionary)
        do {
            self.enums = try parser.fetchArray(key: "enums") { SomeEnums(rawValue: $0) }
            self.inner = try parser.fetch(key: "inner") { InnerType(dictionary: $0) }
        } catch {
            DNPrint(error)
            return nil
        }
    }
}

enum SomeEnums: String {
    case FirstCase = "first_case"
    case SecondCase = "second_case"
}

struct InnerType {
    let aString: String
    let anInt: Int
    let stringArray: [String]
    let anOptionalValue: String?
    
    init?(dictionary: [String: Any]?) {
        let parser = Parser(dictionary: dictionary)
        do {
            self.aString = try parser.fetch(key: "a_string")
            self.anInt = try parser.fetch(key: "an_int")
            self.stringArray = try parser.fetch(key: "string_array")
            self.anOptionalValue = try parser.fetchOptional(key: "bingo")
        } catch {
            DNPrint(error)
            return nil
        }
    }
}

/*
 let dic = ["enums": ["first_case","second_case"],
 "inner": ["a_string": "some_string",
 "an_int": 3,
 "string_array": ["a", "bunch", "of", "strings"],
 "bingo": "fff"
 ]] as [String : Any]
 
 let TempModel = DNTempModel(dictionary: dic)
 print(TempModel?.inner.stringArray as Any)
 */
