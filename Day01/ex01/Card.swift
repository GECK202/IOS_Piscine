import Foundation

class Card : NSObject {
	var color : Color
	var value : Value

	init (c: Color, v : Value) {
		color = c
		value = v
		super.init()
	}

	override var description: String {
		return "(\(value.rawValue), \(color.rawValue))"
	}

	static func ==(card1:Card, card2:Card)-> Bool {
		return (card1.color == card2.color) && 
		(card1.value == card2.value)
	}

	override func isEqual(_ object: Any?) -> Bool {
		if let other = object as? Card {
			return (self == other)
		}
		return false
	}
}
