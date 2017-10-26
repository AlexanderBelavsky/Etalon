package com.netcracker.devschool.dev4.etalon.repository;
import com.netcracker.devschool.dev4.etalon.entity.Student;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentRepository extends JpaRepository<Student, Integer> {
}
