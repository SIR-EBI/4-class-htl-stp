package piCalculator;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

import static org.assertj.core.api.Assertions.*;

@SuppressWarnings("CallToThreadRun")
class PartialSumCalculatorTest {

    @Test
    void constructor_negativeMinimum_exception() {
        assertThatThrownBy(() -> new PartialSumCalculator(-1, 1));
    }

    @Test
    void constructor_maxSmallerMin_getSumReturns0() {
        PartialSumCalculator partialSumCalculator = new PartialSumCalculator(1, 0);

        partialSumCalculator.run();

        assertThat(partialSumCalculator.getSum()).isZero();
    }

    @ParameterizedTest
    @CsvSource({
            "0, 0, 1",
            "0, 1, 0.666666666666666",
            "0, 2, 0.866666666666666",
            "2, 2, 0.2",
            "2, 3, 0.057142857142857",
            "47, 1931, -0.00544794686752715",
            "0, 100000, 0.78540066337243"
    })
    void run_validValues_getSumReturnsResult(int min, int max, double expected) {
        PartialSumCalculator partialSumCalculator = new PartialSumCalculator(min, max);

        partialSumCalculator.run();

        assertThat(partialSumCalculator.getSum()).isCloseTo(expected, within(1e-15));
    }
}