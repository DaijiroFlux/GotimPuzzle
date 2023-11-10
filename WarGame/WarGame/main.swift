//
//  main.swift
//  WarGame
//
//  Created by Daijiro Tsushima on 11/9/23.
//

struct Deck{
var deck: [Card] = []
}
struct Card{
var value: String
var Suit: String
}

var myDeck = Deck()

func shuffle(){
for x in ["2","3","4","5","6","7","8","9","10","Jack","Queen","King","Ace"]{
for y in ["Hearts", "Clubs", "Spades", "Diamonds"]{
myDeck.deck.append(Card(value: x, Suit: y))
}
}
myDeck.deck.shuffle()

player1.append(contentsOf: myDeck.deck.prefix(upTo: 26))
player2.append(contentsOf: myDeck.deck.suffix(from: 26))
}

var player1: [Card] = []
var player2: [Card] = []


func playGame(){

var battlefield: [Card] = []


while !player1.isEmpty && !player2.isEmpty{
    print("Player 1 played \(player1.first!.value) of \(player1.first!.Suit)")
    print("Player 2 played \(player2.first!.value) of \(player2.first!.Suit)")
    
    
    
    var card1 = player1.removeFirst()
    var card2 = player2.removeFirst()
    
    
    
    if card1.value != card2.value{
        battlefield.append(card1)
        battlefield.append(card2)
        
        if battle(battlefield: battlefield) == "Player1"{
            print("Player 1 wins")
            print("\n")
            player1 += battlefield.shuffled()
            battlefield = []
            
        }
        else{
            print("Player 2 wins")
            print("\n")
            player2 += battlefield.shuffled()
            battlefield = []
            
        }
    }
    else{
        battlefield.append(card1)
        battlefield.append(card2)
    }
}
if player1.isEmpty{
print("Player 2 won the game")
}
else{
print("Player 1 won the game")
}
}

func convertValue(cardValue: String) -> Int{
var values = ["null","null","2","3","4","5","6","7","8","9","10","Jack","Queen","King","Ace"]
var number = values.firstIndex(of: cardValue)!

return number
}

func battle(battlefield: [Card]) -> String{
var lastBattleField = battlefield.suffix(2)

if convertValue(cardValue: lastBattleField.last!.value) > convertValue(cardValue: lastBattleField.first!.value){
    return "Player2"
}
else{
    return "Player1"
}
}

shuffle()

playGame()
