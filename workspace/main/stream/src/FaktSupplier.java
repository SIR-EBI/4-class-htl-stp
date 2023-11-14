import java.math.BigInteger;
import java.util.function.Supplier;

class FaktSupplier implements Supplier<BigInteger> {

    private int i = 0;
    private BigInteger faktorielle = BigInteger.ONE;

    @Override
    public BigInteger get() {
        faktorielle = faktorielle.multiply(BigInteger.valueOf(++i));
        return faktorielle;
    }

    public int getI() {
        return i;
    }

}
