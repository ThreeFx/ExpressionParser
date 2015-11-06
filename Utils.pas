UNIT Utils;

INTERFACE

	FUNCTION Contains<T>(arr : Array OF T; element : T) : Boolean;

IMPLEMENTATION

	FUNCTION Contains<T>(arr : Array OF T; element : T) : Boolean;
	BEGIN
		result := false;
		FOR value IN arr
		BEGIN
			IF value = element THEN
			BEGIN
				result := true;
				exit;
			END;
		END;
	END;

BEGIN
END.
