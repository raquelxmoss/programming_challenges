require 'rspec'
require 'ostruct'

class BlackJack
	attr_reader :player, :dealer, :deck

	def initialize
		@dealer = OpenStruct.new(hand: [], bust: false, turns: 0)
		@player = OpenStruct.new(hand: [], bust: false, turns: 0)
		@active_player = @player
		@deck = Deck.new
	end

	def play
		initial_deal
	end

	def draw_card
		@active_player.hand << @deck.cards.pop
	end

	def initial_deal
		2.times do
			@dealer.hand << draw_card
			@player.hand << draw_card
		end
	end

	def won?
	end
end

class Deck
	attr_reader :cards

	def initialize
		@cards = generate_cards.shuffle
	end

	def generate_cards
		simple_cards = (2..10).to_a * 4
		face_cards = %w(A K Q J) * 4
		simple_cards + face_cards
	end
end


describe BlackJack do
	
	it 'initializes with a player and a dealer' do
		@game = BlackJack.new
		expect(@game.player).to eq(OpenStruct.new(hand: [],bust: false, turns: 0, active: true))
		expect(@game.dealer).to eq(OpenStruct.new(hand: [],bust: false, turns: 0, active: false))
	end

	it 'contains a deck of 52 cards' do
		@game = BlackJack.new
		expect(@game.deck).to_not be(nil)
		expect(@game.deck.cards.length).to eq(52)
	end

	it 'removes a card from the deck' do
		@game = BlackJack.new
		expect{@game.draw_card}.to change{@game.deck.cards.length}.by(-1)
	end

	it 'deals the dealer and player 2 cards each' do
		game = BlackJack.new
		game.initial_deal
		expect(game.player.hand.length).to eq(2)
		expect(game.dealer.hand.length).to eq(2)
	end

end