require 'rspec'
require 'ostruct'
require 'pry'

class BlackJack
	attr_reader :player, :dealer, :deck

	def initialize
		@dealer = OpenStruct.new(name: "Dealer", hand: [], bust: false)
		@player = OpenStruct.new(name: "Player", hand: [], bust: false)
		@active_player = @player
		@deck = Deck.new
	end

	def play
		initial_deal
		until finished?
			check_for_bust
			choose_to_hit
		end
		print_result
	end

	def choose_to_hit
		puts @active_player.name
		p @active_player.hand
		puts "Hit? (Y/N)"
		choice = gets.chomp.upcase
		if choice == "Y"
			draw_card
			choose_to_hit
		else
			change_active_player
		end
	end

	def change_active_player
		if @active_player == @player
			@active_player = @dealer
		else
			@active_player = @player
		end
	end

	def check_for_bust
		@active_player.bust = true if calculate_hand(@active_player) > 21
	end

	def calculate_hand(player)
		player.hand.map { |card| card.is_a?(String) ? 10 : card }.reduce(:+)
	end

	def draw_card
		@active_player.hand << @deck.cards.pop
	end

	def initial_deal
		2.times do
			@dealer.hand << @deck.cards.pop
			@player.hand << @deck.cards.pop
		end
	end

	def finished?
		calculate_hand(@player) == 21 || calculate_hand(@dealer) == 21 || @player.bust || @dealer.bust
	end

	def print_result
		if @player.bust 
			puts "Player is bust"
		elsif @dealer.bust
			puts "Dealer is bust"
		elsif calculate_hand(@player) == 21
			puts "Player has blackjack"
		elsif calculate_hand(@dealer) == 21
			puts "Dealer has blackjack"
		end	
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

game = BlackJack.new
game.play


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