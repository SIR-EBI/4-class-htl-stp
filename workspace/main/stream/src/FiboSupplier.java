import java.math.BigInteger;
import java.util.function.IntSupplier;
import java.util.function.Supplier;

public class FiboSupplier implements Supplier<BigInteger> {

    private int i;

    private BigInteger current = BigInteger.ONE;
    private BigInteger previous = BigInteger.ZERO;

    @Override
    public BigInteger get() {
        i++;

        BigInteger result = current;
        current = previous.add(current);
        previous = result;
        return result;
    }

    public int getI() {
        return i;
    }

}
