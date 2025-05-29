; Comments
(comment) @comment

; Functions
(proc_definition
  name: (identifier) @function)

; Function calls
(proc_call_expr
  function: (identifier) @function.call)

; New argument is most probably always type (AFAIK), so give it a @type tag
(proc_call_expr
  function: (identifier) @function.call
  arguments: (argument_list (identifier) @type)
  (#eq? @function.call "New"))

; Types
(struct_definition
  name: (identifier) @type)

(enum_definition
  name: (identifier) @type)

; Struct literal expressions
(struct_literal_expr
  (identifier) @type)

; Variable definitions with highlighting for both name and type
(variable
  name: (identifier) @variable.definition)

; Type in variable declarations
(variable
  (identifier) ; variable name
  ":"
  (_) @type) ; type name

; Return type declarations with named parameters
(proc_return_type_expr
  name: (identifier)
  type: (_) @type)

(proc_return_type_expr
  type: (_) @type)

; Struct field types - anything after colon but before an optional equals sign is type
(struct_field
  (identifier) ; field name
  ":"
  (_) @type) ; type

(parameter
  name: (identifier) @variable.parameter
  type: (_) @type)

; Constants (by convention)
((identifier) @constant
 (#match? @constant "^[A-Z][A-Z0-9_]*$"))

; Basic literals
(number) @number
(float) @number
(string) @string
(boolean) @boolean
(null) @constant.builtin

; Operators and punctuation
"=" @operator.assignment
"->" @operator
"::" @keyword.operator
";" @punctuation.delimiter
":" @punctuation.delimiter
"," @punctuation.delimiter
"." @punctuation.delimiter

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
