UNIT Node;

INTERFACE

	TYPE
	
		TNode = CLASS
			PUBLIC
				FUNCTION Evaluate() : Integer; VIRTUAL; ABSTRACT;
				DESTRUCTOR Destroy; VIRTUAL;
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
	
	FUNCTION TAdd.Create;
	BEGIN
		self.leftchild := a;
		self.rightchild := b;
	END;
		
	FUNCTION TSub.Create;
	BEGIN
		self.leftchild := a;
		self.rightchild := b;
	END;
		
	FUNCTION TMul.Create;
	BEGIN
		self.leftchild := a;
		self.rightchild := b;
	END;
		
	FUNCTION TDiv.Create;
	BEGIN
		self.leftchild := a;
		self.rightchild := b;
	END;
		
	FUNCTION TMin.Create;
	BEGIN
		self.child := a;
	END;
		
	FUNCTION TValue.Create;
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
