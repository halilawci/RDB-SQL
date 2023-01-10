/*
Assignments/Projects RDB/SQL-4 (Factorial Function)

Factorial Function

Create a scalar-valued function that returns the factorial of a number you gave it.

Faktöriyel Fonksiyon

Verdiğiniz bir sayının faktöriyelini döndüren skaler değerli bir işlev oluşturun.
*/

USE SampleRetail
GO

CREATE FUNCTION dbo.Factorial ( @fact int )
RETURNS INT
AS
BEGIN
DECLARE @i INT
IF @fact <= 1
SET @i = 1
ELSE
SET @i = @fact * dbo.Factorial (@fact - 1)
RETURN (@i)
END

SELECT dbo.factorial(4) AS Fact_Result