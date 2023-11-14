package piCalculator;

public class PartialSumCalculator extends Thread {

    private double sum;

    private int min;
    private int max;

    public PartialSumCalculator(int min, int max) {
        if (min < 0 || max < 0) {
            throw new IllegalArgumentException("min < 0");
        }
        this.min = min;
        this.max = max;
        this.sum = 0;
    }

    @Override
    public void run() {
        System.out.println(Thread.currentThread().getName() + ": [" + min + ", " + max + "] => " + (max-min+1));

        for (int i = min; i <= max; i++) {
            this.sum += Math.pow(-1, i) / (2*i+1);
        }
    }

    public double getSum() {
        return sum;
    }

    public static void main(String[] args) {
        PartialSumCalculator part = new PartialSumCalculator(0,99999);
        part.run();
        System.out.println(part.getSum() * 4);
    }

}
