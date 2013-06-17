module ArenaBattle
  class Arena
    def initialize *bots
      bots.each do |bot|
        puts bot.name
      end
    end

    def new *args
      self.initialize args
      return self
    end
  end
end
