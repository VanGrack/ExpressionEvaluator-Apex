@IsTest
private without sharing class ExpressionEvaluatorTests {


    @IsTest
    private static void evaluateBooleanExpressions() {
        System.assertEquals(
                true,
                ExpressionEvaluator.evaluateExpression(
                        '1 AND 2 AND (3 OR 4)',
                        new List<Boolean> {
                                true, true, false, true
                        }
                )
        );
        System.assertEquals(
                true,
                ExpressionEvaluator.evaluateExpression(
                        null,
                        new List<Boolean> {
                                true, true, true
                        }
                )
        );
    }

    @IsTest
    private static void evaluateExpressions() {
        System.assertEquals(true, ExpressionEvaluator.evaluate('2 > 1'));
        System.assertEquals(true, ExpressionEvaluator.evaluate('1 < 2'));
        System.assertEquals(true, ExpressionEvaluator.evaluate('2 >= 1'));
        System.assertEquals(true, ExpressionEvaluator.evaluate('1 <= 2'));
        System.assertEquals(false, ExpressionEvaluator.evaluate('1 > 2'));
        System.assertEquals(false, ExpressionEvaluator.evaluate('2 < 1'));
        System.assertEquals(false, ExpressionEvaluator.evaluate('1 >= 2'));
        System.assertEquals(false, ExpressionEvaluator.evaluate('2 <= 1'));

        System.assertEquals(true, ExpressionEvaluator.evaluate('Cow = Cow'));
        System.assertEquals(false, ExpressionEvaluator.evaluate('Cow = Dog'));
    }
}