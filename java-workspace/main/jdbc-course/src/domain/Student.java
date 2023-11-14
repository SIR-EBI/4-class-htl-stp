package domain;


import java.util.Objects;

public class Student {

    private final Integer id;
    private String lastName;
    private String firstName;

    private String telephoneNumber;
    private String email;

    public Student(Integer id, String lastName, String firstName, String telephoneNumber, String email) {
        if (lastName == null || firstName == null || lastName.isEmpty() || firstName.isEmpty()) {
            throw new IllegalArgumentException("lastname or firstname is null");
        }

        this.id = id;
        this.lastName = lastName;
        this.firstName = firstName;
        this.telephoneNumber = telephoneNumber;
        this.email = email;
    }

    public Student(Integer id, String lastName, String firstName) {
        if (lastName == null || firstName == null || lastName.isEmpty() || firstName.isEmpty()) {
            throw new IllegalArgumentException("lastname or firstname is null");
        }

        this.id = id;
        this.lastName = lastName;
        this.firstName = firstName;
    }

    public Student(String lastName, String firstName) {
        this(null, lastName, firstName);
    }

    public Integer getId() {
        return id;
    }
    public String getLastName() {
        return lastName;
    }
    public String getFirstName() {
        return firstName;
    }
    public String getTelephoneNumber() {
        return telephoneNumber;
    }
    public String getEmail() {
        return email;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public void setTelephoneNumber(String telephoneNumber) {
        this.telephoneNumber = telephoneNumber;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Student student = (Student) o;
        return Objects.equals(id, student.id) && Objects.equals(lastName, student.lastName) && Objects.equals(firstName, student.firstName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, lastName, firstName);
    }

}
