
//var card1:Card = Card(c: Color.Spade, v:Value.Two)
//let card2: Card = Card(c: Color.Diamond, v:Value.Ace)
//let deck = Deck()
//var temp = Deck.allCards
//temp.shuffle()
//print(temp)
var deck = Deck(isSorted: false)

for _ in 0...57 {
//	print("cards:\(deck)")
	if let card = deck.draw() {
		print("move to outs card:\(card)")
		print("outs:\n\(deck.outs)")
		print("discards:\n\(deck.discards)")
		print("move card:\(card) from outs to discard")
		deck.fold(c:card)
		print("outs:\n\(deck.outs)")
		print("discards:\n\(deck.discards)\n")
	} else {
		print("nil")
	}
}

