/*
* Credit: Enrico Borba
* added trim()
*/
import Foundation

extension String {
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
    }
	
	func length() -> Int {
		return count(self)
	}
	
	func reverse() -> String {
		var reverseStr = ""
		for character in self {
			reverseStr = "\(character)\(reverseStr)"
		}
		return reverseStr
	}
	
	mutating func reverseSelf() {
		self = self.reverse()
	}
	
	func substringFrom(start: Int) -> String {
		return self.substring(start: start, end: self.length())
	}
	
	func substringTo(end: Int) -> String {
		return self.substring(start: 0, end: end)
	}
	
	func substring (var #start: Int, var end: Int) -> String {
		var flipped = false
		
		if start > end {
			swap(&start, &end)
			flipped = true
		}
		
		let substring = (self as NSString).substringWithRange(NSMakeRange(start, end - start))
		
		if flipped {
			return substring.reverse()
		}
		
		return substring
	}
	
	func substring (#start: String, end: String) -> String {
		return self[start, end]
	}
	
	subscript(start: Int, end: Int) -> String {
		return self.substring(start: start, end: end)
	}
	
	subscript (var i: Int) -> Character {
		if i < 0 {
			return self.reverse()[-(i + 1)]
		}
		
		assert( i < self.length(), "Index is beyond range")
		
		return self[advance(self.startIndex, i)]
	}
	
	subscript (str: String) -> Int {
		
		let possibleIndex = self.rangeOfString(str)?.startIndex
		
		assert(possibleIndex != nil, "No substring found")
		
		return "\(self.rangeOfString(str)!.startIndex)".toInt()!
	}
	
	subscript (str_start: String, str_end: String) -> String {
		return self.substringWithRange(Range<String.Index>(start: self.rangeOfString(str_start)!.endIndex, end: self.rangeOfString(str_end)!.startIndex))
	}
}