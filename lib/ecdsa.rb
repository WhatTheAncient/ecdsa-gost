require 'digest'
require_relative 'curve'

class ECDSA
  def initialize(curve)
    @curve = curve
  end

  def sign(message)
    e = hash(message).to_i(16) % curve.h
    k = rand(credentials_diapazon)
    c = curve.generator * k
    r = c.x % curve.h
    s = (r * sign_key + k * e) % curve.h
    { r: r, s: s, unsign_key_coordinates: { x: unsign_key.x, y: unsign_key.y } }
  end

  def check_signature(message, signature)
    return false unless signature.values_at(:r, :s).all? { |value| credentials_diapazon.include?(value) }

    e = hash(message).to_i(16) % curve.h
    v = e.mult_inverted(curve.h)

    generator_coeff = (signature[:s] * v) % curve.h
    unsign_coeff = (signature[:r] * v).sum_inverted(curve.h) % curve.h

    unsign_key = Point.new(*signature[:unsign_key_coordinates].values, curve: curve)
    c = curve.generator * generator_coeff + unsign_key * unsign_coeff

    c.x % curve.h == signature[:r]
  end

  private

  attr_reader :message, :curve

  def hash(message)
    Digest::SHA256.hexdigest(message)
  end

  def sign_key
    @sign_key ||= rand(credentials_diapazon)
  end

  def credentials_diapazon
    @credentials_diapazon ||= (1..(curve.h - 1))
  end

  def unsign_key
    curve.generator * sign_key
  end
end
