PROGRAM test;

USES StackElement, Node, Parser, ExpressionStack, SysUtils;

VAR
	tree : TNode;
BEGIN
	tree := ParseExpr('1*1');
	WriteLn('Jep');
	WriteLn(IntToStr(tree.Evaluate));
	WriteLn('Jep');
	WriteLn(IntToStr(TExpressionStack.FromTree(tree).Evaluate));
END.
