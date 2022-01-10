import Foundation

class Deck: NSObject {
	static let allSpades:[Card] = Value.allValues.map({Card(c:Color.Spade,v:$0)})
	static let allHearts:[Card] = Value.allValues.map({Card(c:Color.Heart,v:$0)})
	static let allClubs:[Card] = Value.allValues.map({Card(c:Color.Club, v:$0)})
	static let allDiamonds:[Card] = Value.allValues.map({Card(c:Color.Diamond, v:$0)})
	static let allCards:[Card] = allSpades + allHearts + allClubs + allDiamonds
	var cards: [Card] = Deck.allCards
	var discards: [Card] = []
	var outs: [Card] = []

	init(isSorted: Bool) {
		if isSorted {
			cards.shuffle()
		}
		super.init()
	}

	override var description: String {
		return (self.cards.description)
	}	

	func draw()->Card? {
		if !cards.isEmpty {
			let res =  cards[0]
			cards.remove(at: 0)
			outs.append(res)
			return res
		}
		return nil
	}

	func fold(c:Card) {
		for index in 0..<outs.count {
			if c == outs[index] {
				outs.remove(at:index)
				discards.append(c)
			}
		}
	}
}

extension Array {
	mutating func shuffle(){
		for index in 0..<self.count {
			let newIndex = Int(arc4random_uniform(UInt32(self.count)))
			self.swapAt(index, newIndex)
		}
	}
}
