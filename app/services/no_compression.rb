# frozen_string_literal: true

class NoCompression
  def compress(string)
    # TODO: Remove this either when Sprockets compressor will work, or when removing Sprockets
    string
  end
end
