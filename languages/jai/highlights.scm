; Includes

[
  (import)
  (load)
] @preproc


; Keywords
[
  ; from modules/Jai_Lexer
  "if"
  "xx"

  "ifx"
  "for"

  "then"
  "else"
  "null"
  "case"
  "enum"
  "true"
  "cast"

  "while"
  "break"
  "using"
  "defer"
  "false"
  "union"

  "return"
  "struct"
  "inline"
  "remove"

  ; "size_of"
  "type_of"
  ; "code_of"
  ; "context"

  "continue"
  "operator"

  ; "type_info"
  "no_inline"
  "interface"

  "enum_flags"

  ; "is_constant"

  "push_context"

  ; "initializer_of"
] @keyword

[
  "return"
] @keyword

[
  "if"
  "else"
  "case"
  "break"
] @keyword

((if_expression
  [
    "then"
    "ifx"
    "else"
  ] @keyword)
  (#set! "priority" 105))

; Repeats

[
  "for"
  "while"
  "continue"
] @keyword

; Variables

; (identifier) @variable
name: (identifier) @variable
argument: (identifier) @variable
named_argument: (identifier) @hint
(member_expression (identifier) @variable)
(parenthesized_expression (identifier) @variable)

((identifier) @variable.special
  (#any-of? @variable.special "context"))

; Namespaces

(import (identifier) @constant)

; Parameters

(parameter (identifier) @variable ":" "="? (identifier)? @constant)

; (call_expression argument: (identifier) @parameter "=")

; Functions

; (procedure_declaration (identifier) @function (procedure (block)))
(procedure_declaration (identifier) @function (block))

(call_expression function: (identifier) @function)

; Types

type: (types) @type
type: (identifier) @type
((types) @type)

modifier: (identifier) @keyword
keyword: (identifier) @keyword

((types (identifier) @type)
  (#any-of? @type
    "bool" "int" "string"
    "s8" "s16" "s32" "s64"
    "u8" "u16" "u32" "u64"
    "Type" "Any"))

(struct_declaration (identifier) @type ":" ":")

(enum_declaration (identifier) @type ":" ":")

; (const_declaration (identifier) @type ":" ":" [(array_type) (pointer_type)])

; ; I don't like this
; ((identifier) @type
;   (#lua-match? @type "^[A-Z][a-zA-Z0-9]*$")
;   (#not-has-parent? @type parameter procedure_declaration call_expression))

; Fields

(member_expression "." (identifier) @property)

(member_expression . "." (identifier) @property)

; Constants ( Assuming ALL CAPS are constants )
((identifier) @constant
 (#match? @constant "^[A-Z][A-Z0-9_]*$"))

(assignment_statement (identifier) @property "="?)
(update_statement (identifier) @variable)

(enum_declaration "{" (identifier) @constant)

; Literals

(integer) @number
(float) @number
(string) @string

;(character) @character

(string_contents (escape_sequence) @string.escape)

(boolean) @boolean

[
  (uninitialized)
  (null)
] @constant

; Operators
[
"`"
"*" 
] @punctuation.special

[
  ":"
  "="
  "+"
  "-"
  "/"
  "%"
  ">"
  ">="
  "<"
  "<="
  "=="
  "!="
  "|"
  "~"
  "&"
  "&~"
  "<<"
  ">>"
  "<<<"
  ">>>"
  "||"
  "&&"
  "!"
  ".."
  "+="
  "-="
  "*="
  "/="
  "%="
  "&="
  "|="
  "^="
  "<<="
  ">>="
  "<<<="
  ">>>="
  "||="
  "&&="
] @operator

; Punctuation

[ "{" "}" ] @punctuation.bracket

[ "(" ")" ] @punctuation.bracket

[ "[" "]" ] @punctuation.bracket

[
  "->"
  "."
  ","
  ":"
  ";"
] @punctuation.delimiter

; Comments

[
  (comment)
  (block_comment)
] @comment

; Errors

(ERROR) @text.literal

(block_comment) @comment
(comment) @comment

directive: ("#") @keyword ; #if
type: ("type_of") @type

(compiler_directive) @keyword
(heredoc_start) @punctuation.delimiter
(heredoc_end) @punctuation.delimiter
(heredoc_body) @string
(note) @string
