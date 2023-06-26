require_relative 'integer'

class Point
  attr_reader :x, :y, :curve

  # @param x [Integer] X coordinate of the point
  # @param y [Integer] Y coordinate of the point
  # @param curve [Curve] The curve that the point belongs to
  def initialize(x, y, curve:)
    @x = x
    @y = y
    @curve = curve
  end

  def self.zero(curve:)
    new(0, 0, curve: curve)
  end

  def * (number)
    result = Point.zero(curve: curve)
    additive = self

    number.to_s(2).reverse.each_char do |bit|  
      result += additive if bit.to_i == 1

      additive = additive + additive
    end

    result
  end

  def + (other_point)
    return self.class.new(0, 0, curve: curve) if reflected?(other_point)
    return self if other_point.zero?
    return other_point if self.zero?

    m = m(other_point)
    sum_x = diff(m**2, x, other_point.x) % curve.mod
    sum_y = (y + m * diff(sum_x, x)).sum_inverted(curve.mod)

    self.class.new(sum_x, sum_y, curve: curve)
  end

  def zero?
    x == 0 && y == 0
  end

  def equal?(other_point)
    x == other_point.x && y == other_point.y
  end

  private

  def m(other_point)
    result = if equal?(other_point)
               (3 * x**2 + curve.a) * (2 * y).mult_inverted(curve.mod)
             else
               diff(y, other_point.y) * diff(x, other_point.x).mult_inverted(curve.mod)
             end

    result % curve.mod
  end

  def diff(a, *args)
    (a + args.map { |arg| arg.sum_inverted(curve.mod) }.sum) % curve.mod
  end

  def reflected?(other_point)
    [
      x == diff(0, other_point.x) && (y == other_point.y || y == diff(0, other_point.y)),
      (x == other_point.x || x == diff(0, other_point.x)) && y == diff(0, other_point.y)
    ].any?
  end
end
