public with sharing class ExpressionEvaluator {
    private static final String ANDv = 'AND';
    private static final String ORv = 'OR';
    private static final String OPEN = '(';
    private static final String CLOSE = ')';


    //TODO might want to overload this with the fully simplified expression?
    public static Boolean evaluateExpression(String expression, Boolean[] booleans) {
        if (expression == null) {
            expression = String.join(booleans, ' AND ');
        } else {
            for (Integer i = booleans.size(); i >= 1; i--) {
                expression = expression.replaceAll(String.valueOf(i), String.valueOf(booleans.get(i - 1)));
            }
        }

        return evaluateBooleanExpression(expression);
    }

    private static Boolean evaluateBooleanExpression(String expression) {
        if (!expression.contains(OPEN)) {
            return evaluateSimpleExpression(expression);
        }

        Integer indexOfOpen = -1;
        Integer indexOfClose = -1;

        String[] chars = expression.split('');
        for (Integer i = 0; i < chars.size(); i++) {
            if (chars[i] == OPEN) {
                indexOfOpen = i;
                continue;
            }

            if (chars[i] == CLOSE) {
                indexOfClose = i;
                break;
            }
        }

        String innerExpression = expression.substring(indexOfOpen + 1, indexOfClose);
        expression = expression.replace(OPEN + innerExpression + CLOSE, String.valueOf(evaluateBooleanExpression(innerExpression)));
        return evaluateBooleanExpression(expression);
    }

    private static Boolean evaluateSimpleExpression(String expression) {
        Boolean result = false;
        for (String conj : expression.split(ORv)) {
            Boolean b = true;
            for (String single : conj.split(ANDv)) {
                b &= Boolean.valueOf(single.trim());
            }

            result |= b;
        }

        return result;
    }

    public static Boolean evaluate(Expression expression) {
        switch on expression.operator {
            when '>' {
                return Double.valueOf(expression.arg1) > Double.valueOf(expression.arg2);
            } when '<' {
                return Double.valueOf(expression.arg1) < Double.valueOf(expression.arg2);
            } when '>=' {
                return Double.valueOf(expression.arg1) >= Double.valueOf(expression.arg2);
            } when '<=' {
                return Double.valueOf(expression.arg1) <= Double.valueOf(expression.arg2);
            } when '=' {
                return expression.arg1 == expression.arg2;
            }
        }

        return false;
    }


    public class Expression {
        Object arg1 { get; private set; }
        Object arg2 { get; private set; }
        String operator { get; private set; }

        public Expression(Object arg1, Object arg2, String operator) {
            this.arg1 = arg1;
            this.arg2 = arg2;
            this.operator = operator;
        }
    }
}