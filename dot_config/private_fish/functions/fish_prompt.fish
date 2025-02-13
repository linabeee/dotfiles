function fish_prompt
    set -f user "(test -n "$SSH_CLIENT"; and printf '%s ' (prompt_login))(test -n "$CONTAINER_ID"; and printf "[%s]" "$CONTAINER_ID")"
    printf '%s%s > ' $user (prompt_pwd)
end
