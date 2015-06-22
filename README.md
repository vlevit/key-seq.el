# key-seq.el

key-seq.el provides a way to map pairs of sequentially but quickly
pressed keys to commands. It includes two interactive functions:
`key-seq-define-global` and `key-seq-define` which are complementary
to `key-chord-*` functions found in [key-chord.el]. The difference is
that `key-seq-*` functions produce bindings only in a defined key
order while bindings defined with `key-chord-*` are symmetrical.

The package depends on [key-chord.el] and it requires active
`key-chord-mode` to work. Add this line to your configuration:

    (key-chord-mode 1)

Then you can define key sequences like this:

    (key-seq-define-global "qd" 'dired)

    (key-seq-define text-mode-map "qf" 'flyspell-buffer)


For key delay and other customizations see [key-chord.el]
documentation.

[key-chord.el]: http://www.emacswiki.org/emacs/key-chord.el
