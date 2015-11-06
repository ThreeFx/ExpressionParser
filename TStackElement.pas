UNIT StackElement;

INTERFACE
	TYPE
		Operator = FUNCTION(operands : ARRAY OF TStackValue) : Integer;
	
		TStackElement = CLASS
		END;
	
		TStackValue = CLASS(TStackValue)
		END;
		
		TStackOperator = CLASS(TStackOperator)
		PRIVATE
			CLASS VAR Plus, Minus, Times, DividedBy, UnaryMinus : TStackOperator;
			
		PUBLIC
			CLASS FUNCTION OpPlus() : TStackOperator;
			CLASS FUNCTION OpMinus() : TStackOperator;
			CLASS FUNCTION OpTimes() : TStackOperator;
			CLASS FUNCTION OpDividedBy() : TStackOperator;
			CLASS FUNCTION OpUnaryMinus() : TStackOperator;
			
			
		END;
