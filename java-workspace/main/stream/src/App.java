import java.io.BufferedReader;
import java.io.FileReader;
import java.util.*;
import java.util.stream.*;

public class App {

    public static void main(String[] args) {
        /**
         *      1. a)
         */
        System.out.println("1. a)");

        IntStream.rangeClosed(0,20)
                        .filter(i -> i%2==1)
                        .map(i -> i*i)
                        .forEach(System.out::println);

        System.out.println("---------------");

        /**
         *      1. b)
         */
        System.out.println("1. b)");

        Double sum = IntStream.rangeClosed(1,100).asDoubleStream()
                        .map(e -> 1 / ((e + 1) * (e + 2)))
                        .sum();
        System.out.println(sum);

        System.out.println("---------------");

        /**
         *      1. c)
         */

        System.out.println("1. c)");

        List<Integer> lottoNumbers =  new Random()
                        .ints(0,45)
                        .limit(6).boxed().collect(Collectors.toList());

        System.out.println(lottoNumbers);

        System.out.println("---------------");

        /**
         *      1. d)
         */

        System.out.println("1. d)");

        List<Integer> numbers = Arrays.asList(new Integer[] {1,10,4,101,56,101,1,4,5});
        numbers.stream()
                        .distinct()
                        .filter(i -> i%2==1)
                        .map(i -> i*i)
                        .forEach(System.out::println);

        System.out.println("---------------");

        /**
         *      1. e)
         */

        System.out.println("1. e)");

        Long fac = LongStream.rangeClosed(1,20)
                        .reduce(1, (x, y) -> x * y);

        System.out.println(fac);

        System.out.println("---------------");

        /**
         *      1. f)
         */

        System.out.println("1. f)");


        System.out.println(
                Arrays.stream(IntStream.rangeClosed(1,1000)
                                .mapToObj(i -> String.valueOf(i))
                                .collect(Collectors.joining("", "", ""))
                                .split(""))
                                .filter(element -> element.equals("1"))
                                .count()
        );

        System.out.println("---------------");

        /**
         *      1. g)
         */

        System.out.println("1. g)");

        LongStream.iterate(1, i -> i * (i + 1))
                        .limit(6)
                        .forEach(System.out::println); //1 - 2 - 6 - 42 - 1806 - 3263442

        System.out.println("---------------");

        /**
         *      1. h)
         */

        System.out.println("1. h)");

        System.out.println(
                Stream.generate(new FaktSupplier())
                        .filter(element -> (""+element).length() >= 99)
                        .limit(1)
                        .findFirst().get()
                );

        System.out.println("---------------");

        /**
         *      1. h.i)
         */

        System.out.println("1. h.i)");

        FaktSupplier faktSupplier = new FaktSupplier();

        Stream.generate(faktSupplier)
                        .filter(element -> (""+element).length() >= 10_001)
                        .limit(1)
                        .findFirst();

        System.out.println(faktSupplier.getI());

        System.out.println("---------------");

        /**
         *      1. h.j)
         */

        System.out.println("1. h.j)");

        FiboSupplier fiboSupplier = new FiboSupplier();

        Stream.generate(fiboSupplier)
                .filter(element -> (""+element).length() >= 25)
                .limit(1)
                .findFirst();

        System.out.println(fiboSupplier.getI());

        System.out.println("---------------");

        /**
         *      2. a)
         */

        System.out.println("2. a)");

        try {
            BufferedReader reader = new BufferedReader(new FileReader("main/stream/resources/schueler.csv"));
            System.out.println(
                    reader.lines()
                            .map(line -> new Schueler(line))
                            .filter(schueler -> schueler.getGeschlecht().equals("W"))
                            .count()
            );
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("---------------");

        /**
         *      2. b)
         */

        System.out.println("2. b)");

        try {
            BufferedReader reader = new BufferedReader(new FileReader("main/stream/resources/schueler.csv"));
            List<String> weiblicheSchueler = reader.lines()
                                                        .map(line -> new Schueler(line))
                                                        .filter(schueler -> schueler.getGeschlecht().equals("W"))
                                                        .map(schueler -> schueler.getVorname())
                                                        .collect(Collectors.toList());
            System.out.println(weiblicheSchueler);
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("---------------");

        /**
         *      2. c)
         */

        System.out.println("2. c)");

        try {
            BufferedReader reader = new BufferedReader(new FileReader("main/stream/resources/schueler.csv"));
            reader.lines()
                                    .map(line -> new Schueler(line))
                                    .sorted()
                                    .forEach(System.out::println);

        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("---------------");
    }

}


