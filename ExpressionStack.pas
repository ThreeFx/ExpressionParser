 UNIT ExpressionStack;



INTERFACE
        USES StackElement;

	TYPE
		TExpressionStack = CLASS
			PRIVATE
				underlying : ARRAY OF TStackElement;
				FUNCTION pop() : TStackElement;
                FUNCTION operatorOnTop() : Boolean;
                FUNCTION Print() : String;
			PUBLIC
				CONSTRUCTOR Create();
				DESTRUCTOR Dispose();

				PROCEDURE Push(elem : TStackElement);
				FUNCTION Evaluate() : Integer;

		END;

IMPLEMENTATION USES SysUtils;

	CONSTRUCTOR TExpressionStack.Create();
	BEGIN
		SetLength(underlying, 0);
	END;

	DESTRUCTOR TExpressionStack.Dispose();
	VAR
		elem : TStackElement;
	BEGIN
		FOR elem IN underlying DO
		BEGIN
			elem.Dispose();
		END;
		SetLength(underlying, 0);
	END;

	FUNCTION TExpressionStack.pop() : TStackElement;
	BEGIN
		result := underlying[High(underlying)];
		SetLength(underlying, Length(underlying) - 1);
	END;

	PROCEDURE TExpressionStack.Push(elem : TStackElement);
	BEGIN
		SetLength(underlying, Length(underlying) + 1);
		underlying[High(underlying)] := elem;
	END;

	FUNCTION TExpressionStack.operatorOnTop() : Boolean;
	BEGIN
		result := underlying[High(underlying)] IS TStackOperator;
	END;

	FUNCTION TExpressionStack.Print() : String;
	VAR
		elem : TStackElement;
	BEGIN
		result := '';
		FOR elem IN underlying DO
		BEGIN
			IF elem IS TStackValue THEN
			BEGIN
				result := result + IntToStr((elem AS TStackValue).GetValue());
			end
			ELSE BEGIN
				result := result + 'Op';
			END;
			result := result + ' ';
		END;
	END;

	FUNCTION TExpressionStack.Evaluate() : Integer;
	VAR
		pending : ARRAY OF TStackValue;
		current : TStackElement;
	BEGIN
		SetLength(pending, 0);
		WHILE (Length(underlying) > 1) OR (operatorOnTop) DO
		BEGIN
			WriteLn(Print);
			current := pop();
			IF current IS TStackOperator THEN
			BEGIN
				Push(TStackValue.Create((current AS TStackOperator).Evaluate(pending)));
				SetLength(pending, 0);
			END
			ELSE BEGIN
				SetLength(pending, Length(pending) + 1);
				pending[High(pending)] := (current AS TStackValue);
			END;
		END;
		result := (pop() AS TStackValue).GetValue();
	END;
BEGIN
END.
