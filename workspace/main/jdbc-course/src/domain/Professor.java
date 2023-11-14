package domain;


import java.util.Objects;

public class Professor {

    private final Integer id;
    private String lastName;
    private String firstName;

    private String telephoneNumber;
    private String email;

    public Professor(Integer id, String lastName, String firstName, String telephoneNumber, String email) {
        if (lastName == null || firstName == null || lastName.isEmpty() || firstName.isEmpty()) {
            throw new IllegalArgumentException("lastname or firstname is null");
        }

        this.id = id;
        this.lastName = lastName;
        this.firstName = firstName;
        this.telephoneNumber = telephoneNumber;
        this.email = email;
    }

    public Professor(Integer id, String lastName, String firstName) {
        if (lastName == null || firstName == null || lastName.isEmpty() || firstName.isEmpty()) {
            throw new IllegalArgumentException("lastname or firstname is null");
        }

        this.lastName = lastName;
        this.firstName = firstName;
        this.id = id;
    }

    public Professor(String lastName, String firstName) {
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
        Professor professor = (Professor) o;
        return Objects.equals(id, professor.id) && Objects.equals(lastName, professor.lastName) && Objects.equals(firstName, professor.firstName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, lastName, firstName);
    }

}
