Apex code for boolean expression evaluation

# Usage:
```java
ExpressionEvaluator.evaluateExpression(String expression, Boolean[] values){ ... });
```
So, the parameter 'expression' must be using ordinal numbers related to the parameter 'values'  (Examples below)

# EXAMPLES
```java
List<Boolean> values = new List<Boolean>{
true, false, true, true, false, true, true, true, true, false
};
String expression = '1 AND 2 AND (3 AND (4 OR 5)) AND 6 AND 7 AND 8 AND 9 AND 10';

ExpressionEvaluator.evaluateExpression(expression, values);
```
