UNIT Parser;

USES Utils, SysUtils; // more to come

INTERFACE

	FUNCTION ParseExpr(expr : String) : TNode; OVERLOAD;
	
IMPLEMENTATION
	
	CONST Operators = ['+', '-', '*'];
	
	// 0 = no operator, 1 = unary op, 2 = binary op
	FUNCTION GetOpType(expr : String; index, lower, upper : Integer) : Integer;
	BEGIN
		result := 0;
		IF Contains<Char>(Operators, expr[index]) THEN
		BEGIN
			// Unary operator per default
			result := 1;
			
			// But if the Character preceding it is not an operator, it is a binary operator
			// Ex. 5 * - 7
			IF (NOT (index = lower)) AND (NOT IsOp(expr, index - 1)) THEN
			BEGIN
				result := 2;
			END;
		END;
	END;
	
	FUNCTION IsOp(expr : String; index, lower, upper : Integer) : Boolean;
	BEGIN
		result := GetOpType(expr, index, lower, upper) > 0;
	END;
	
	FUNCTION IsUnOp(expr : String; index, lower, upper : Integer) : Boolean;
	BEGIN
		result := GetOpType(expr, index, lower, upper) = 1;
	
	FUNCTION IsBinOp(expr : String; index : Integer)
	BEGIN
		result := GetOpType(expr, index, lower, upper) = 2;
	END;
	
	FUNCTION GetOperatorPrecedence(op : Char) : Integer;
	BEGIN
		CASE op OF
			'+': result := 1;
			'-': result := 1;
			'*': result := 2;
		END;
	END;
	
	FUNCTION HasNextBinaryOperator(expr : String; index, lower, upper : Integer) : Boolean;
	BEGIN
		IF index = upper + 1 THEN
			result := false
		ELSE IF IsBinOp(expr, index, lower, upper) THEN
			result := true
		ELSE
			result := HasNextBinaryOperator(expr, index + 1, lower, upper);
	
	FUNCTION GetIndexOfNextBinaryOperator(expr : String; lower, upper : Integer) : Integer;
	BEGIN
		IF IsBinOp(expr, lower) THEN
			result := index
		ELSE
			result := GetIndexOfNextBinaryOperator(expr, lower, upper);
	END;
	
	FUNCTION GetIndexOfNextOperator(expr : String; lower, upper : Integer) : Integer;
	VAR
		minimum : Integer;
		precedence : Integer;
		index : Integer;
	BEGIN
		index := lower;
		minimum := 100000;
		WHILE index <= Length(String) DO
		BEGIN
			IF HasNextBinaryOperator(expr, index, lower, upper) THEN
			BEGIN
				precedence := GetOperatorPrecedence([GetIndexOfNextBinaryOperator(expr, index, lower, upper)]);
				IF precedence < minimum THEN
				BEGIN
					minimum := precedence;
					result := index;
				END;
			END;
			Inc(index);
		END;
	END;
		
	FUNCTION ParseExpr(expr : String; lower, upper : Integer) : TNode;
	VAR
		nextBinOpIndex : Integer;
	BEGIN
		IF HasNextBinaryOperator(expr, lower, upper) THEN
		BEGIN
			nextBinOpIndex := 
			result := TBinaryOperator.Create(
											ParseExp(expr, lower, lower, index - 1),
											ParseExp(expr, index + 1, index + 1, ;
	END;
	
	FUNCTION ParseExpr(expr : String) : TNode; OVERLOAD;
	BEGIN
		result := ParseExpr(expr, 1, Length(expr));
	END;

BEGIN
END.
