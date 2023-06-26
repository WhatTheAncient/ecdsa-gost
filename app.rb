require_relative 'lib/ecdsa'
require 'json'
require 'dotenv'

Dotenv.load

params_base = ENV.fetch('PARAMS_BASE').to_i

curve = Curve.new(
  a: ENV.fetch('CURVE_A').to_i(params_base),
  b: ENV.fetch('CURVE_B').to_i(params_base),
  mod: ENV.fetch('CURVE_MOD').to_i(params_base),
  n: ENV.fetch('CURVE_N').to_i(params_base),
  h: ENV.fetch('CURVE_H').to_i(params_base),
)

curve.generator = Point.new(
  ENV.fetch('GENERATOR_X').to_i(params_base),
  ENV.fetch('GENERATOR_Y').to_i(params_base),
  curve: curve
)

puts 'Please enter a message to sign: '
message = gets.chomp

signature = ECDSA.new(curve).sign(message)

puts "Please enter a message to verify its correctness with a #{signature} signature "
message_for_check = gets.chomp

result = ECDSA.new(curve).check_signature(message_for_check, signature)

if result
  puts 'The message being checked corresponds to the signed one'
else
  puts 'The message being checked does not match the signed one'
end