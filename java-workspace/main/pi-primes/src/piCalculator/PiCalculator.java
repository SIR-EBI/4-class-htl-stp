package piCalculator;

public class PiCalculator {

    public static double calcPiWithNThreads(int limit, int threadCnt) {
        double sum = 0;

        int stepSize = limit/threadCnt;
        int rest = limit%threadCnt;
        int rangeDone = 0;

        for (int counter = 0; counter < threadCnt; counter++) {
            PartialSumCalculator thread;
            if (rest>=0) {
                thread = new PartialSumCalculator(rangeDone, rangeDone+=stepSize);
                rest--;
            } else {
                thread = new PartialSumCalculator(rangeDone, rangeDone+=stepSize-1);
            }
            rangeDone+=1;

            thread.start();
            try {
                thread.join();
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }

            sum+=thread.getSum();
        }
        return sum * 4;
    }

    public static void main(String[] args) {
        System.out.println("pi = " + calcPiWithNThreads(99999,7));
    }

}
