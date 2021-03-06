UNIT StackElement;

INTERFACE
	TYPE
		TStackElement = CLASS
			PUBLIC
				DESTRUCTOR Dispose;
		END;

		TStackValue = CLASS(TStackElement)
			PRIVATE
				theValue : Integer;

			PUBLIC
				CONSTRUCTOR Create(val : Integer);
				FUNCTION GetValue() : Integer;
		END;

		OpPtr = FUNCTION(operands : ARRAY OF TStackValue) : Integer;

		TStackOperator = CLASS(TStackElement)
			PRIVATE
				func : OpPtr;
				CLASS VAR Plus, Minus, Times, DividedBy, UnaryMinus : TStackOperator;
				CONSTRUCTOR Create(op : OpPtr);
			PUBLIC
				FUNCTION Evaluate(values : ARRAY OF TStackvalue) : Integer;
				CLASS FUNCTION OpPlus() : TStackOperator;
				CLASS FUNCTION OpMinus() : TStackOperator;
				CLASS FUNCTION OpTimes() : TStackOperator;
				CLASS FUNCTION OpDividedBy() : TStackOperator;
				CLASS FUNCTION OpUnaryMinus() : TStackOperator;
		END;

IMPLEMENTATION

	DESTRUCTOR TStackElement.Dispose();
	BEGIN

	END;

	CONSTRUCTOR TStackOperator.Create(op : OpPtr);
	BEGIN
		func := op;
	END;

	FUNCTION TStackOperator.Evaluate(values : ARRAY OF TStackValue) : Integer;
	BEGIN
		result := func(values);
	END;

	CONSTRUCTOR TStackValue.Create(val : Integer);
	BEGIN
		theValue := val;
	END;

	FUNCTION TStackValue.GetValue() : Integer;
	BEGIN
		result := theValue;
	END;

	FUNCTION Add(operands : ARRAY OF TStackValue) : Integer;
	BEGIN
		result := operands[0].GetValue() + operands[1].GetValue();
	END;

	FUNCTION Sub(operands : ARRAY OF TStackValue) : Integer;
	BEGIN
		result := operands[0].GetValue() - operands[1].GetValue();
	END;

	FUNCTION Mul(operands : ARRAY OF TStackValue) : Integer;
	BEGIN
		result := operands[0].GetValue() * operands[1].GetValue();
	END;

	FUNCTION Divi(operands : ARRAY OF TStackValue) : Integer;
	BEGIN
		result := operands[0].GetValue() div operands[1].GetValue();
	END;

	FUNCTION Neg(operands : ARRAY OF TStackValue) : Integer;
	BEGIN
		result := -operands[0].GetValue();
	END;

	CLASS FUNCTION TStackOperator.OpMinus() : TStackOperator;
	BEGIN
		result := Minus;
	END;

	CLASS FUNCTION TStackOperator.OpPlus() : TStackOperator;
	BEGIN
		result := Plus;
	END;

	CLASS FUNCTION TStackOperator.OpDividedBy() : TStackOperator;
	BEGIN
		result := DividedBy;
	END;

	CLASS FUNCTION TStackOperator.OpTimes() : TStackOperator;
	BEGIN
		result := Times;
	END;


	CLASS FUNCTION TStackOperator.OpUnaryMinus() : TStackOperator;
	BEGIN
		result := UnaryMinus;
	END;

	BEGIN
		TStackOperator.Plus := TStackOperator.Create(@Add);
		TStackOperator.Minus := TStackOperator.Create(@Sub);
		TStackOperator.Times := TStackOperator.Create(@Mul);
		TStackOperator.DividedBy := TStackOperator.Create(@Divi);
		TStackOperator.UnaryMinus := TStackOperator.Create(@Neg);
	END.
