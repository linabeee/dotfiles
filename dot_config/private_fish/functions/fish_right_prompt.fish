function fish_right_prompt
  set -l laststatus $status
  if test $laststatus -ne 0
    set_color red
    printf '%s ' $laststatus
    set_color normal
  end
end
