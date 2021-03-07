; Variables
(identifier) @variable

;; Identifier naming conventions
((identifier) @type
 (#match? @type "^[A-Z]"))

(function_type) @type
(product_type) @type
(inductive_type) @type

(instance
  class: (identifier) @type)
(instance_field
  return_type: (identifier) @type)

;; Definitions

(def
  name: (identifier) @function)

(def
  attributes: (identifier) @function)

(apply
  name: (identifier) @function)

(field_of
  name: (identifier) @method)

(parameters
  type: (identifier) @type)

(inductive_constructor) @constructor

["if" "then" "else"] @conditional

["for"] @repeat

(import) @include

; Tokens

[
  "!"
  "$"
  "%"
  "&&"
  "*"
  "+"
  "++"
  "-"
  "/"
  "::"
  ":="
  "|>"
  "|>."
  "<|"
  "<|>"
  "="
  "=="
  "=>"
  ">"
  "@"
  "^"
  "||"
  "←"
  "→"
  "↔"
  "∧"
  "∨"
  "≠"
] @operator

[
  "by"
  "class"
  "constant"
  "def"
  "do"
  "else"
  "end"
  "example"
  "export"
  "for"
  "fun"
  "in"
  "inductive"
  "instance"
  "let"
  "match"
  "namespace"
  "open"
  "partial"
  "private"
  "protected"
  "return"
  "section"
  "structure"
  "theorem"
  "universe"
  "unsafe"
  "variable"
  "where"
  "with"
  "λ"
  (hash_command)
  (prelude)
  (sorry)
] @keyword

[
  "catch"
  "exact"
  "finally"
  "rewrite"
  "try"
] @keyword

[
  "throw"
  "mut"
] @keyword

[(true) (false)] @boolean

(number) @number
(float) @float

(comment) @comment
(char) @number
(string) @string
(interpolated_string) @string

; Reset highlighing in string interpolation
(interpolation) @none

["(" ")" "[" "]" "{" "}" "⟨" "⟩"] @punctuation.bracket

(interpolation
  "{" @punctuation.special
  "}" @punctuation.special)

["," "." ":"] @punctuation.delimiter

(sorry) @error

;; Error
(ERROR) @error
