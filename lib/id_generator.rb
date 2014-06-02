class IdGenerator

  def self.generate
    ('a'..'z').to_a.shuffle[0, 25].join
  end

end