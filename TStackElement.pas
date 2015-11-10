UNIT StackElement;

INTERFACE
	TYPE
		Operator = FUNCTION(operands : ARRAY OF TStackValue) : Integer;
	
		TStackElement = CLASS
		END;
	
		TStackValue = CLASS(TStackElement)
			PRIVATE
				theValue : Integer;
				
			PUBLIC
				CONSTRUCTOR Create(val : Integer);
				FUNCTION GetValue() : Integer;
		END;
		
		TStackOperator = CLASS(TStackElement)
			PRIVATE
				CLASS VAR Plus, Minus, Times, DividedBy, UnaryMinus : TStackOperator;
			
			PUBLIC
				CLASS FUNCTION OpPlus() : TStackOperator;
				CLASS FUNCTION OpMinus() : TStackOperator;
				CLASS FUNCTION OpTimes() : TStackOperator;
				CLASS FUNCTION OpDividedBy() : TStackOperator;
				CLASS FUNCTION OpUnaryMinus() : TStackOperator;
			
			
		END;

IMPLEMENTATION

	FUNCTION Add(operands : ARRAY OF TStackValue) : Integer;
	BEGIN
		result := operands[0].GetValue() + operands[1].GetValue();
	END;
	
	FUNCTION Sub(operands : ARRAY OF TStackValue) : Integer;
	BEGIN
		result := operands[0].GetValue() + operands[1].GetValue();
	END;
	
	FUNCTION Mul(operands : ARRAY OF TStackValue) : Integer;
	BEGIN
		result := operands[0].GetValue() + operands[1].GetValue();
	END;
	
	FUNCTION Div(operands : ARRAY OF TStackValue) : Integer;
	BEGIN
		result := operands[0].GetValue() + operands[1].GetValue();
	END;
	
	FUNCTION Neg(operands : ARRAY OF TStackValue) : Integer;
	BEGIN
		result := operands[0].GetValue() + operands[1].GetValue();
	END;
