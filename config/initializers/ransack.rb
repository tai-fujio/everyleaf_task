Ransack.configure do |config|
  config.add_predicate 'has_any_term',
  arel_predicate: 'matches_all',
  formatter: proc { |s| s.gsub("　", " ").split.map{|t| "%#{t}%"} }
end
