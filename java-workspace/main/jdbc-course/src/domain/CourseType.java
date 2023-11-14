package domain;


import java.util.Objects;

public class CourseType {

    private final char id;
    private final String description;

    public CourseType(char id, String description) {
        if (description.isBlank())
            throw new IllegalArgumentException();
        this.id = id;
        this.description = description;
    }

    public char getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CourseType that = (CourseType) o;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

}
