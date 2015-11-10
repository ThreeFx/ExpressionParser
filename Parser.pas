UNIT Parser;

INTERFACE

        USES Node, Utils, StrUtils, SysUtils; // more to come

	FUNCTION ParseExpr(expr : String) : TNode; OVERLOAD;

        TYPE CharSet = Set of Char;
	
IMPLEMENTATION
	
	CONST Operators = ['+', '-', '*', '/'];

        FUNCTION Contains(arr : CharSet; element : Char) : Boolean;
        VAR
                val : Char;
        BEGIN
		result := false;
		FOR val IN arr DO
		BEGIN
			IF val = element THEN
			BEGIN
				result := true;
				exit;
			END;
		END;
	END;

	// 0 = no operator, 1 = unary op, 2 = binary op
	FUNCTION GetOpType(expr : String; index, lower : Integer) : Integer;
	BEGIN
		result := 0;
		IF Contains(Operators, expr[index]) THEN
		BEGIN
			// Unary operator per default
			result := 1;
			
			// But if the Character preceding it is not an operator, it is a binary operator
			// Ex. 5 * - 7
			IF (NOT (index = lower)) AND (NOT Contains(Operators, expr[index - 1])) THEN
			BEGIN
				result := 2;
			END;
		END;
	END;
	
	FUNCTION IsOp(expr : String; index, lower : Integer) : Boolean;
	BEGIN
		result := GetOpType(expr, index, lower) > 0;
	END;
	
	FUNCTION IsUnOp(expr : String; index, lower : Integer) : Boolean;
	BEGIN
		result := GetOpType(expr, index, lower) = 1;
        END;

	FUNCTION IsBinOp(expr : String; index, lower : Integer) : Boolean;
	BEGIN
		result := GetOpType(expr, index, lower) = 2;
	END;
	
	FUNCTION GetOperatorPrecedence(op : Char) : Integer;
	BEGIN
		CASE op OF
			'+': result := 1;
			'-': result := 1;
			'*': result := 2;
			'/': result := 2;
		END;
	END;
	
	FUNCTION HasNextBinaryOperator(expr : String; index, lower, upper : Integer) : Boolean; OVERLOAD;
	BEGIN
		IF index > upper THEN
			result := false
		ELSE IF IsBinOp(expr, index, lower) THEN
			result := true
		ELSE
			result := HasNextBinaryOperator(expr, index + 1, lower, upper);

        END;

        FUNCTION HasNextBinaryOperator(expr : String; lower, upper : Integer) : Boolean; OVERLOAD;
        BEGIN
                result := HasNextBinaryOperator(expr, lower, lower, upper);
        END;

	FUNCTION GetIndexOfNextBinaryOperator(expr : String; index, lower, upper : Integer) : Integer;
	BEGIN
		IF IsBinOp(expr, index, lower) THEN
                BEGIN
			result := index;
                END
		ELSE
                BEGIN
			result := GetIndexOfNextBinaryOperator(expr, index + 1, lower, upper);
                END;
	END;
	
	//FUNCTION GetIndexOfNextBinaryOperator(expr : String; lower, upper : Integer) : Integer; OVERLOAD;
	//BEGIN
	//	result := GetIndexOfNextBinaryOperator(expr, lower, lower, upper);
	//END;
	
	FUNCTION GetIndexOfNextOperator(expr : String; lower, upper : Integer) : Integer;
	VAR
		minimum : Integer;
		precedence : Integer;
		index : Integer;
	BEGIN
		index := lower;
		minimum := 100000;
		WHILE index <= upper DO
		BEGIN
			IF HasNextBinaryOperator(expr, index, upper) THEN
			BEGIN
				precedence := GetOperatorPrecedence(expr[GetIndexOfNextBinaryOperator(expr, index, lower, upper)]);
				IF precedence <= minimum THEN
				BEGIN
					minimum := precedence;
					result := index;
				END;
			END;
			Inc(index);
		END;
	END;
	
	FUNCTION CreateBinOperator(op : Char; leftChild, rightChild : TNode) : TNode;
	BEGIN
		CASE op OF
			'+': result := TAdd.Create(leftChild, rightChild);
			'-': result := TSub.Create(leftChild, rightChild);
			'*': result := TMul.Create(leftChild, rightChild);
			'/': result := TDiv.Create(leftChild, rightChild);
		END;
	END;
		
	FUNCTION ParseExpr(expr : String; lower, upper : Integer) : TNode;
	VAR
		nextBinOpIndex : Integer;
	BEGIN
		IF HasNextBinaryOperator(expr, lower, upper) THEN
		BEGIN
			nextBinOpIndex := GetIndexOfNextOperator(expr, lower, upper) + 1;
                        WriteLn(expr[nextBinOpIndex]);
                        //WriteLn(nextBinOpindex);
			result := CreateBinOperator(
				expr[nextBinOpIndex],
				ParseExpr(expr, lower, nextBinOpIndex - 1),
				ParseExpr(expr, nextBinOpIndex + 1, upper)
			);
		END
		ELSE IF expr[lower] = '-' THEN
		BEGIN
			result := TMin.Create(ParseExpr(expr, lower + 1, upper));
		END
		ELSE
                BEGIN
                        //WriteLn(Copy(expr, lower, upper - lower + 1));
			result := TValue.Create(StrToInt(Copy(expr, lower, upper - lower + 1)));
		END;
	END;
	
	FUNCTION ParseExpr(expr : String) : TNode; OVERLOAD;
	BEGIN
		result := ParseExpr(expr, 1, Length(expr));
	END;

BEGIN
END.
