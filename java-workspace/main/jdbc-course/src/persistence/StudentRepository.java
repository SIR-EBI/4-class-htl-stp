package persistence;


import domain.Student;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface StudentRepository {

    List<Student> findAll() throws SQLException;

    Optional<Student> findById(int id) throws SQLException;

    Student save(Student student) throws SQLException;

    void update(Student student) throws SQLException;

    void delete(Student student) throws SQLException;

}
