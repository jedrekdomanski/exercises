class Tree
  def self.draw(num)
    (1..num).map do |i|
      ("*" * i * 2).center(80)
    end
  end
end

puts tree = Tree.draw(6)