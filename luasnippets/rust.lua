---@diagnostic disable: unused-local
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

return {
    s(
        {
            trig = "main",
            dscr = "fn main() { … }",
        },
        fmta(
            [[
            fn main() {
                <>
            }
            ]],
            { i(1, [[unimplemented!();]]) }
        )
    ),
    s(
        {
            trig = "tokio_main",
            dscr = "#[tokio::main]",
        },
        fmta(
            [[
            #[tokio::main]
            async fn main() {
                <>
            }
            ]],
            { i(1, [[unimplemented!();]]) }
        )
    ),
    s({
        trig = "tokio_add_head",
        dscr = "add #[tokio::main]",
    }, fmta("#[tokio::main]", {})),
    s(
        {
            trig = "tokio_test",
            dscr = "add #[tokio::test]",
        },
        fmta("#[tokio::test(<>worker_threads = <>)]", {
            i(1, [[flavor = "multi_thread", ]]),
            i(2, "10"),
        })
    ),
    s(
        {
            trig = "feature",
            dscr = "add #![feature(…)]",
        },
        fmta("#![feature(<>)]", {
            i(1, ""),
        })
    ),
    s(
        {
            trig = "extern-crate",
            dscr = "extern crate …;",
        },
        fmta("extern crate <>;", {
            i(1, "name"),
        })
    ),
    s(
        {
            trig = "extern-fn",
            dscr = 'extern "C" fn …(…) { … }',
        },
        fmta(
            [[
extern "C" fn []([]: []) -> [] {
    []
}
        ]],
            {
                i(1, "name"),
                i(2, "arg"),
                i(3, "Type"),
                i(4, "RetType"),
                i(5, "// add code here"),
            },
            { delimiters = "[]" }
        )
    ),
    s(
        {
            trig = "extern-mod",
            dscr = 'extern "C" { … }',
        },
        fmta(
            [[
extern "<>" {
    <>
}
        ]],
            {
                i(1, "C"),
                i(2, "// add code here"),
            }
        )
    ),
    s({
        trig = "alloc_add",
        dscr = "add extern crate alloc;",
    }, fmta("extern crate alloc;", {})),
    s(
        {
            trig = "static",
            dscr = "static …: … = …;",
        },
        fmta("static <>: <> = <>;", {
            i(1, "STATIC"),
            i(2, "Type"),
            i(3, "init"),
        })
    ),
    s(
        {
            trig = "fnr",
            dscr = "fn …(…) -> … { … }",
        },
        fmta(
            [[
            fn []([]) -> [] {
                []
            }
            ]],
            {
                i(1, "name"),
                i(2, ""),
                i(3, "RetType"),
                i(4, "unimplemented!()"),
            },
            { delimiters = "[]" }
        )
    ),
    s("prvar", {
        t([[println!(r##"(| ]]),
        d(4, function(args)
            return sn(nil, { i(1, args[1]) })
        end, { 1 }),
        t({ " |) " }),
        i(3, "->"),
        t({ " {" }),
        i(2, ":#?"),
        t({ [[}"##, ]] }),
        i(1, "variable"),
        t(");"),
    }),
    s(
        "dbg",
        fmta(
            [[
        #[cfg(debug_assertions)]
        dbg!(<>);
        ]],
            {
                i(1, "variable"),
            }
        )
    ),
    s(
        "dbgr",
        fmta(
            [[
        #[cfg(debug_assertions)]
        dbg!(&<>);
        ]],
            {
                i(1, "variable"),
            }
        )
    ),
    s(
        {
            trig = "eprintln",
            priority = 30000,
        },
        fmta([[eprintln!("<>"<>);]], {
            i(1, ""),
            i(2, ""),
        })
    ),
    s(
        {
            trig = "allow",
            dscr = "#![allow(…)]",
        },
        fmt("#![allow({})]", {
            i(1, ""),
        })
    ),
    s({
        trig = "cfg",
        dscr = "#[cfg(…)]",
    }, fmt("#[cfg({})]", { i(1, "") })),
    s(
        {
            trig = "cfg_attr",
            dscr = "#[cfg_attr(…, …)]",
        },
        fmt("#[cfg_attr({}, {})]", {
            i(1, ""),
            i(2, ""),
        })
    ),
    s(
        {
            trig = "const",
            dscr = "const …: … = …;",
        },
        fmt("const {}: {} = {};", {
            i(1, "CONST"),
            i(2, "Type"),
            i(3, "init"),
        })
    ),
    s({
        trig = "deny",
        dscr = "#![deny(…)]",
    }, fmt("#![deny({})]", { i(1, "") })),
    s({
        dscr = "#[derive(…)]",
        trig = "derive",
    }, fmt("#[derive({})]", { i(1, "") })),
    s(
        {
            trig = "enum",
            dscr = "enum … { … }",
        },
        fmta(
            [[
            #[derive(Clone, Copy)]
            #[derive(Debug)]
            #[derive(Default)]
            #[derive(PartialEq, Eq)]
            enum <> {
                <>,
            }
            ]],
            {
                i(1, "Name"),
                i(2, ""),
            }
        )
    ),
    s(
        {
            trig = "struct",
            dscr = "struct … { … }",
        },
        fmta(
            [[
            #[derive(Clone, Copy)]
            #[derive(Debug)]
            #[derive(Default)]
            #[derive(PartialEq, Eq)]
            pub struct <> {
                <>: <>,
            }
            ]],
            {
                i(1, "Name"),
                i(2, "field"),
                i(3, "Type"),
            }
        )
    ),
    s(
        {
            trig = "struct-tuple",
            dscr = "struct …(…);",
        },
        fmt([[
        #[derive(Clone, Copy)]
        #[derive(Debug)]
        #[derive(Default)]
        #[derive(PartialEq, Eq)]
        pub struct {}({});
        ]], {
            i(1, "Name"),
            i(2, "Type"),
        })
    ),
    s({
        trig = "struct-unit",
        dscr = "struct …;",
    }, fmt([[
    #[derive(Clone, Copy)]
    #[derive(Debug)]
    #[derive(Default)]
    #[derive(PartialEq, Eq)]
    pub struct {};
    ]], { i(1, "Name") })),
    s(
        {
            trig = "type",
            dscr = "type … = …;",
        },
        fmt("type {} = {};", {
            i(1, "Alias"),
            i(2, "Type"),
        })
    ),
    s({
        trig = "warn",
        dscr = "#[warn(…)]",
    }, fmt("#[warn({})]", { i(1, "") })),
    s(
        {
            dscr = "impl … { … }",
            trig = "impl",
        },
        fmta(
            [[
            impl <> {
                <>
            }
            ]],
            {
                i(1, "Type"),
                i(2, "// add code here"),
            }
        )
    ),
    s(
        {
            trig = "impl-trait",
            dscr = "impl … for … { … }",
        },
        fmta(
            [[
            impl <> for <> {
                <>
            }
            ]],
            {
                i(1, "Trait"),
                i(2, "Type"),
                i(3, "// add code here"),
            }
        )
    ),
    s({
        trig = "mod",
        dscr = "mod …;",
    }, fmt("mod {};", { i(1, "name") })),
    s(
        {
            trig = "mod-block",
            dscr = "mod … { … }",
        },
        fmta(
            [[
            mod <> {
                    <>,
            }
            ]],
            {
                i(1, "name"),
                i(2, "// add code here"),
            }
        )
    ),
    s({
        trig = "no_core",
        dscr = "#![no_core]",
    }, t("#![no_core]")),
    s({
        trig = "no_std",
        dscr = "#![no_std]",
    }, t("#![no_std]")),
    s(
        {
            trig = "repr",
            dscr = "#[repr(…)]",
        },
        fmta("#[repr(<>)]", {
            i(1, ""),
        })
    ),
    -- s(
    --     {
    --         trig = "tmod",
    --         dscr = "#[cfg(test) mod tests{…}]",
    --     },
    --     fmta(
    --         [[
    -- #[cfg(test)]
    -- mod tests {
    --     use super::*;
    --
    --     #[test]
    --     fn <>() {
    --
    --     }
    -- }
    -- ]],
    --         {
    --             i(1, "test_name"),
    --         }
    --     )
    -- ),
}

