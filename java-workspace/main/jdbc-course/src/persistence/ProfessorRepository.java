package persistence;


import domain.Professor;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

public interface ProfessorRepository {

    List<Professor> findAll() throws SQLException;

    Optional<Professor> findById(int id) throws SQLException;

    Professor save(Professor professor) throws SQLException;

    void delete(Professor professor) throws SQLException;

}
