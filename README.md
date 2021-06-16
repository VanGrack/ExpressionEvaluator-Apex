Apex code for boolean expression evaluation

# Usage:
```java
public BooleanEvaluate(String expression, Boolean[] values){ ... }
```
So, the parameter 'expression' must be using ordinal numbers related to the parameter 'values'  (Examples below)

# EXAMPLES
```java
List<Boolean> values = new List<Boolean>{
true, false, true, true, false, true, true, true
};

BooleanEvaluate boolEval = new BooleanEvaluate('1 && ( ( 2 || 3 ) && 6 ) && ( 4 && 5 || ( 7 && 8 ) )', values);
boolEval.evaluate();
```
