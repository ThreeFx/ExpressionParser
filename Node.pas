UNIT Node;

INTERFACE

	TYPE
	
		TNode = CLASS
			PUBLIC
				FUNCTION Evaluate() : Integer; VIRTUAL; ABSTRACT;
				DESTRUCTOR Destroy; VIRTUAL; ABSTRACT;
		END;
		
		TBinaryOperator = CLASS(TNode)
			PROTECTED
				leftChild, rightChild: TNode;
			PUBLIC
				DESTRUCTOR Destroy; OVERRIDE;
		END;
		
		TAdd = CLASS(TBinaryOperator)
			PUBLIC
				CONSTRUCTOR Create(a,b: TNode);
				FUNCTION Evaluate() : Integer; OVERRIDE;
		END;
		
		TSub = CLASS(TBinaryOperator)
			PUBLIC
				CONSTRUCTOR Create(a,b: TNode);
				FUNCTION Evaluate() : Integer; OVERRIDE;
		END;
		
		TDiv = CLASS(TBinaryOperator)
			PUBLIC
				CONSTRUCTOR Create(a,b: TNode);
				FUNCTION Evaluate() : Integer; OVERRIDE;
		END;
		
		TMul = CLASS(TBinaryOperator)
			PUBLIC
				CONSTRUCTOR Create(a,b: TNode);
				FUNCTION Evaluate() : Integer; OVERRIDE;
		END;
		
		TValue = CLASS(TNode)
			PRIVATE
				wert: Integer;
			PUBLIC
				CONSTRUCTOR Create(a: Integer);
				DESTRUCTOR Destroy;
				FUNCTION Evaluate() : Integer; OVERRIDE;
		END;
		
		TUnaryOperator = CLASS(TNode)
			PROTECTED
				child: TNode;
			PUBLIC
				DESTRUCTOR Destroy; OVERRIDE;
		END;
		
		TMin = CLASS(TUnaryOperator)
			PROTECTED
			PUBLIC
				CONSTRUCTOR Create(a: TNode);
				FUNCTION Evaluate() : Integer; OVERRIDE;
		END;
		
IMPLEMENTATION
	
	CONSTRUCTOR TAdd.Create(a,b : TNode);
	BEGIN
		self.leftchild := a;
		self.rightchild := b;
	END;
		
	CONSTRUCTOR TSub.Create(a,b : TNode);
	BEGIN
		self.leftchild := a;
		self.rightchild := b;
	END;
		
	CONSTRUCTOR TMul.Create(a,b : TNode);
	BEGIN
		self.leftchild := a;
		self.rightchild := b;
	END;
		
	CONSTRUCTOR TDiv.Create(a,b : TNode);
	BEGIN
		self.leftchild := a;
		self.rightchild := b;
	END;
		
	CONSTRUCTOR TMin.Create(a : TNode);
	BEGIN
		self.child := a;
	END;
		
	CONSTRUCTOR TValue.Create(a : Integer);
	BEGIN
		self.wert := a;
	END;
	
	DESTRUCTOR TBinaryOperator.Destroy;
	BEGIN
		leftchild.Destroy;
		rightchild.Destroy;
	END;
	
	DESTRUCTOR TUnaryOperator.Destroy;
	BEGIN
		child.Destroy;
	END;
	
	DESTRUCTOR TValue.Destroy;
	BEGIN
	END;
	
	FUNCTION TAdd.Evaluate(): Integer;
	BEGIN
		result := leftchild.Evaluate + rightchild.Evaluate;
	END;
	
	FUNCTION TSub.Evaluate(): Integer;
	BEGIN
		result := leftchild.Evaluate - rightchild.Evaluate;
	END;
	
	FUNCTION TDiv.Evaluate(): Integer;
	BEGIN
		result := leftchild.Evaluate DIV rightchild.Evaluate;
	END;
	
	FUNCTION TMul.Evaluate(): Integer;
	BEGIN
		result := leftchild.Evaluate * rightchild.Evaluate;
	END;
	
	FUNCTION TValue.Evaluate(): Integer;
	BEGIN
		result := self.wert;
	END;
	
	FUNCTION TMin.Evaluate(): Integer;
	BEGIN
		result := -child.Evaluate;
	END;
	
BEGIN
END.                                     
