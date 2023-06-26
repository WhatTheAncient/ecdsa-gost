class Integer
  def mult_inverted(mod)
    result = self % mod

    result.pow(mod - 2, mod)
  end

  def sum_inverted(mod)
    mod - self % mod 
  end
end