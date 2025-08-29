set -U fish_greeting

if status is-interactive
    set -U fish_key_bindings fish_vi_key_bindings
end
