require_relative 'point'

# TODO: Алгоритм Шуффа для вычисления порядка кривой по заданному количеству точек
#       Реализовать создание генератора G и вычисление H

class Curve
  attr_reader :a, :mod, :n, :h, :generator

  # @param a [Integer] The "a" param from elliptic curve equation.
  # @param b [Integer] The "b" param from elliptic curve equation.
  # @param mod [Integer] The module of an elliptic curve.
  # @param n [Integer] The rank of the cyclic subgroup of elliptic curve points
  # @param h [Integer] The rank of an elliptic curve group.
  def initialize(a:, b:, mod:, n:, h:)
    @a = a
    @b = b
    @mod = mod
    @n = n
    @h = h
  end

  # @param point [Point] The generator point for elliptic curve cyclic subgroup
  def generator= (point)
    @generator = point
  end
end