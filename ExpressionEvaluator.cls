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

    public static Boolean evaluate(String expression) {
        String[] tokens = expression.split(' ');
        switch on tokens[1] {
            when '>' {
                return Double.valueOf(tokens[0]) > Double.valueOf(tokens[2]);
            } when '<' {
                return Double.valueOf(tokens[0]) < Double.valueOf(tokens[2]);
            } when '>=' {
                return Double.valueOf(tokens[0]) >= Double.valueOf(tokens[2]);
            } when '<=' {
                return Double.valueOf(tokens[0]) <= Double.valueOf(tokens[2]);
            } when '=' {
                return tokens[0] == tokens[2];
            }
        }

        return false;
    }
}