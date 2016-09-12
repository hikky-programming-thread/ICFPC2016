# ヒッキープログラミングするスレ
#######################################################################################################
#
# ICFP Contest 2016
#
#######################################################################################################
#
# 方針
#
# 1. 全てのポリゴンの頂点の座標の平均をとる。これを座標Ａとする。
#
# 2. まだ折ってない折り紙の中央が座標Ａに来るように配置する。
#
# 3. 折り紙の頂点からのびる２辺に沿ってそれぞれに点を取りポリゴンの頂点を含まないところで三角形に折る。
#
# 4. 3.を繰り返しポリゴンを覆うようにする。
#
#######################################################################################################

# 入力処理

POLYGON_VERTEX_COUNT = ARGF.gets.to_i

polygon_vertexes = []

POLYGON_VERTEX_COUNT.times do
	
	vertex_count = ARGF.gets.to_i
	
	vertex_count.times do
		
		polygon_vertexes << ARGF.gets.strip.split(',').map(&:to_r)
		
	end
	
end

ARGF.read # 残りは使わないので捨てる。


# 座標Ａを計算する

positionA = polygon_vertexes.reduce([0.to_r, 0.to_r]) { |r, v|
	x0, y0 = r
	x1, y1 = v
	[x0 + x1, y0 + y1]
}.map { |z| z / polygon_vertexes.size.to_r }


# 折り紙の頂点の初期位置を設定する

origami_vertexes = [] # 各要素の左側がから、初期位置(x,y)、移動後の位置(x,y)。親配列の添え字が頂点番号に対応する。

origami_vertexes << [[0.to_r, 0.to_r], [0.to_r, 0.to_r]] # 座標(0, 0)の頂点
origami_vertexes << [[1.to_r, 0.to_r], [1.to_r, 0.to_r]] # 座標(1, 0)の頂点
origami_vertexes << [[1.to_r, 1.to_r], [1.to_r, 1.to_r]] # 座標(1, 1)の頂点
origami_vertexes << [[0.to_r, 1.to_r], [0.to_r, 1.to_r]] # 座標(0, 1)の頂点

# 折り紙の初期の中央を求める

central_position = origami_vertexes.map{ |_, mp| mp }.reduce([0.to_r, 0.to_r]) { |r, v|
	x0, y0 = r
	x1, y1 = v
	[x0 + x1, y0 + y1]
}.map { |z| z / origami_vertexes.size.to_r }

# 折り紙の移動後の位置を仮設定する

origami_vertexes.map! { |init_pos, moved_pos|
	x0, y0 = moved_pos
	x1, y1 = central_position
	x2, y2 = positionA
	[init_pos, [x0 - x1 + x2, y0 - y1 + y2]]
}

# 折り紙の面

origami_facets = [[0, 1, 2, 3]] # 反時計回り


# 折り目を計算する

# ここはまだ考え途中.


# 答えを出力する

STDOUT.puts origami_vertexes.size

origami_vertexes.each do |vertexes|

	STDOUT.puts vertexes[0] * ','
	
end

STDOUT.puts origami_facets.size

origami_facets.each do |facets|
	
	STDOUT.puts facets.size.to_s + ' ' + facets * ' '
	
end

origami_vertexes.each do |vertexes|

	STDOUT.puts vertexes[1] * ','
	
end

