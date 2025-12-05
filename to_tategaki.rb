#! ruby -EUTF-8

def to_tategaki(str, title, mode = 1)
	html_box = []
	
	# モードに応じた設定
	column_gap = mode == 2 ? "40px" : "400px"
	margin_top = mode == 2 ? "1rem" : "4rem"
	
	head = <<~EOS
<!DOCTYPE html>
<html lang=\"ja\">
<head>
	<meta charset=\"UTF-8\">
	<title>#{title}</title>
	<style>
body {
    margin-left: 2em;
    font-family: "Yu Mincho", "游明朝", YuMincho, serif;
    font-weight: 500;
    line-height: 1.5;
    font-feature-settings: "palt" 0;
}

article {
    width: 60em;
    max-width: 60em;
    height: 20rem;
    margin-top: #{margin_top};
    writing-mode: vertical-rl;
    letter-spacing: 0em;
    columns: 20rem;
    column-gap: #{column_gap};
    /* 文字間隔を完全に固定 */
    font-feature-settings: "palt" 0, "pkna" 0;
    text-spacing: none;
    /* 約物の自動調整を無効化 */
    text-autospace: no-autospace;
}
      h4{
      	margin-top: 1em;
      }

      section{
        margin-right: 1em;
      }

      div.scene{
        margin-right: 1em;
      }

      div.description{
        margin-top: 3em;
        text-indent: 0em;

      }
      div.line {
        margin-top: 1em;
        text-indent: -1em;
      }
      div.comment {
      	margin-top: 3em;
      	color: red;
      }

      span.del {
      	background: lightsalmon;
      	border: thin inset;

      } span.add {
      	background: lightskyblue;
      	font-weight: bolder;
      	border: thin outset;
      }

      span.before-change {
      	background: wheat;
      	border: thin inset;
      }

      span.after-change {
      	background: lightgreen;
      	font-weight: bolder;
      	border: thin outset;
      }
  </style>
</head>
<body>
<article>
EOS

  tail = <<~EOS
</article>
</body>
</html>
EOS

  html_box << head
  line_count = 0
  scene_flag = 0

  str.lines do |line|
	  case line
	  when /★(.*?)\n/
	  	html_box << %Q|<h4>#{$1}</h4>|

	  when /(○.*?)\n/
		  html_box << %Q|<section>|
		  html_box << %Q|<div class="scene">#{$1}</div>|
		  scene_flag = 1

	  when /＠(.*?)\n/
		  if line_count > 0
			  html_box << %Q|</div>|
		  	line_count = 0
		  end
		  html_box << %Q|<div class="description">#{$1}</div>|

		when /＃(.*?)\n/
		  if line_count > 0
			  html_box << %Q|</div>|
		  	line_count = 0
		  end
		  html_box << %Q|<div class="comment">#{$1}</div>|

	  when /(.*?」)\n/
		  if line_count == 0
		  	html_box << %Q|<div class="lines">|
		   	html_box << %Q|<div class="line">#{$1}</div>|
		  	line_count += 1
		  else
			  html_box << %Q|<div class="line">#{$1}</div>|
			  line_count += 1
		  end

	  when "\n"
		  if line_count > 0
			  html_box << %Q|</div>|
			  line_count = 0
		  end
		  if scene_flag == 1
			  html_box << %Q|</section>|
			  scene_flag = 0
		  end
		  html_box << "\n"
	  else
		  html_box << line
		end
	end

  html_box << tail
  html_box
end
