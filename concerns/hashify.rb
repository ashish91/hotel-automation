module Hashify
  def build_map(list, identifier: :identifier)
    Hash[
      list.map do |object|
        [ object.send(identifier), object ]
      end
    ]
  end
end