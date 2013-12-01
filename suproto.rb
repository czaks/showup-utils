#!/usr/bin/ruby

def p_mini i
  #assert i < 100000000 and i >= 0

  a = []
  4.times do
    a << i%100
    i/=100
  end
  a.reverse.pack("CCCC")
end

def p_pkg pak, pid
  a = "\x00\x00" << p_mini(pid)

  cs = 0
  (pak+a).each_byte { |i| cs += i }
  "" << p_mini(pak.length+10) << p_mini(cs) << a << pak
end

def p_str str
  "" << p_mini(str.length) << str
end

def p_strary ary
  len = 0
  sum = ary.reduce(0) { |a,b| a + b.length + 4 }
  "" << p_mini(sum+4) << p_mini(ary.length) << ary.map { |str| p_str str }.join("")
end


require "socket"

randomhash = ""
32.times { randomhash << rand(16).to_s(16) }

s = TCPSocket.new(*ARGV[0].split(":"))
s.write p_pkg(p_strary([randomhash, ""]), 0)
s.write p_pkg(p_strary([ARGV[1]]), 2)
puts s.read[0x1a..0x39]
