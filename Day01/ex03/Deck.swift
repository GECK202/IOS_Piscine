import Foundation

class Deck: NSObject {
	static let allSpades:[Card] = Value.allValues.map({Card(c:Color.Spade,v:$0)})
	static let allHearts:[Card] = Value.allValues.map({Card(c:Color.Heart,v:$0)})
	static let allClubs:[Card] = Value.allValues.map({Card(c:Color.Club, v:$0)})
	static let allDiamonds:[Card] = Value.allValues.map({Card(c:Color.Diamond, v:$0)})
	static let allCards:[Card] = allSpades + allHearts + allClubs + allDiamonds
}

extension Array {
	mutating func shuffle(){
		for index in 0..<self.count {
			let newIndex = Int(arc4random_uniform(UInt32(self.count)))
			self.swapAt(index, newIndex)
		}
	}
}
