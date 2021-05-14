import pyverilog.vparser.ast as vast
from pyverilog.ast_code_generator.codegen import ASTCodeGenerator

params = vast.Paramlist(())
clock = vast.Ioport(vast.Input("clock"))
reset = vast.Ioport(vast.Input("reset"))
width = vast.Width(
    vast.IntConst("7"),
    vast.IntConst("0")
)

LED = vast.Ioport(vast.Output("LED", width=width))
ports = vast.Portlist([clock, reset, LED])
items = (vast.Assign(vast.Identifier("LED"), vast.IntConst("8")), )
ast = vast.ModuleDef("top", params, ports, items)
codegen = ASTCodeGenerator()
result = codegen.visit(ast)

print(result)