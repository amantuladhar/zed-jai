(comment) @comment

(proc_definition
  name: (identifier) @function)

(proc_call_expr
  function: (identifier) @function)

(proc_call_expr
  function: (identifier) @function.call
  arguments: (argument_list (identifier) @type)
  (#eq? @function.call "New"))

(struct_definition
  name: (identifier) @type)

(enum_definition
  name: (identifier) @type)

(struct_literal_expr
  (identifier) @type)

(variable
  name: (identifier) @variable)

(variable
  (identifier) 
  ":"
  (_) @type) 

(proc_return_type_expr
  name: (identifier)
  type: (_) @type)

(proc_return_type_expr
  type: (_) @type)

(parameter
  name: (identifier) @variable
  type: (_) @type)

(named_argument 
    name: (identifier) @hint
    value: (_) @identifier ) 

(struct_literal_expr 
  (struct_initialize_with_field 
    (identifier) @hint
    (identifier)))

(struct_field
    name: (identifier) @identifier
    type: (_) @type )

(union_body
    (struct_field
        name: (identifier) @identifier 
        type: (_))
)

((identifier) @constant
 (#match? @constant "^[A-Z][A-Z0-9_]*$"))

(number) @number
(float) @number
(string) @string
(boolean) @boolean
(null) @constant

"=" @operator.assignment
"->" @operator
"::" @keyword.operator
";" @punctuation.delimiter
":" @punctuation.delimiter
"," @punctuation.delimiter
"." @punctuation.delimiter
"*" @punctuation.special
".." @punctuation

; Brackets
"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket

; Keywords
"xx" @keyword
"if" @keyword.control
"else" @keyword.control
"for" @keyword.control
"while" @keyword.control
"return" @keyword.control
"struct" @keyword
"enum" @keyword
"using" @keyword
"union" @keyword
"defer" @keyword
"continue" @keyword
"break" @keyword
"case" @keyword
"ifx" @keyword
"then" @keyword
"#if" @keyword
"inline" @keyword
"#char" @keyword.directive
"#caller_location" @keyword.directive
"#complete" @keyword.directive
"#run" @keyword.directive


; Built-in types
"bool" @type.builtin
"string" @type.builtin
"int" @type.builtin
"float" @type.builtin
"float64" @type.builtin
"float32" @type.builtin
"s64" @type.builtin
"s32" @type.builtin
"s16" @type.builtin
"s8" @type.builtin
"u64" @type.builtin
"u32" @type.builtin
"u16" @type.builtin
"u8" @type.builtin
"void" @type.builtin
"Any" @type.builtin

; Special identifiers
((identifier) @keyword.builtin
 (#eq? @keyword.builtin "context"))
((identifier) @keyword.builtin
 (#eq? @keyword.builtin "push_context"))



; Directives
(directive) @keyword.directive
(import_directive) @keyword.directive
(scope_module) @keyword.directive
(scope_file) @keyword.directive
(scope_export) @keyword.directive
(code_directive "#code" @keyword.directive)
(insert_directive "#insert" @keyword.directive)
(assert_directive "#assert" @keyword.directive)
