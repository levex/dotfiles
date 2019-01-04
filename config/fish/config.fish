alias vim=nvim
alias pbcopy="xclip -selection c"
alias fvim="vim (fzf)"
set -gx PATH /home/lkurusa/go/bin/ $PATH
set -gx PATH /home/lkurusa/bin/ $PATH
set -gx PATH /home/lkurusa/.local/bin/ $PATH
set -gx PATH /home/lkurusa/.cargo/bin/ $PATH
set -gx PATH /home/lkurusa/.gem/ruby/2.5.0/bin/ $PATH
set -gx PATH /data/cross-compilers/prefix/bin $PATH
set -gx RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src
set -gx BAT_THEME TwoDark
