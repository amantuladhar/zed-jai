(procedure_declaration  (identifier) @name ) @item

(struct_declaration (identifier) @name ) @item

(struct_or_union
    (struct_or_union_block "{" 
        (variable_declaration  name: (identifier) @name 
            ":"
            type: (types) @context
        ) @item
    ) 
) 

(enum_declaration name: (identifier) @name) @item
(enum_field (identifier) @name ) @item
(anonymous_enum_type)

(const_declaration (identifier) @name ) @item