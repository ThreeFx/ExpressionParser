UNIT ExpressionStack;

USES StackElement;

INTERFACE

	TYPE
		TExpressionStack = CLASS
			PRIVATE
				underlying : ARRAY OF TStackElement;
				FUNCTION pop() : TStackElement;
			PUBLIC
				CONSTRUCTOR Create();
				DESTRUCTOR Dispose();
	
				PROCEDURE Push(elem : TStackElement);
				FUNCTION Evaluate() : Integer;
		END;

IMPLEMENTATION

	CONSTRUCTOR TExpressionStack.Create();
	BEGIN
		SetLength(underlying, 0);
	END;
	
	DESTRUCTOR TExpressionStack.Dispose()
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
		SetLenngth(underlying, Length(underlying) + 1);
		underlying[High(underlying)] := elem;
	END;
	
	PROCEDURE TExpressionStack.Evaluate() : Integer;
	VAR
		pending : ARRAY OF TStackValue;
		current : TStackElement
	BEGIN
		SetLength(pending, 0);
		WHILE Length(underlying) > 1 DO
		BEGIN
			current := pop();
			IF current IS TStackOperator THEN
			BEGIN
				Push(TStackValue.Create(current.Evaluate(pending)));
			END
			ELSE BEGIN
				SetLength(pending, Length(pending) + 1);
				pending[High(pending)] := current;
			END;
		END;
		result := (pop() AS TStackValue).GetValue();
	END;
