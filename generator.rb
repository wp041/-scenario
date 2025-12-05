#! ruby -EUTF-8

require './to_tategaki'

# 引数: ファイル名 [モード]
# モードは1(デフォルト)または2
mode = (ARGV[1] || "1").to_i
puts to_tategaki(File.read(ARGV[0]), ARGV[0], mode)