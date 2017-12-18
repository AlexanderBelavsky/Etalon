package com.netcracker.devschool.dev4.etalon.repository;

import com.netcracker.devschool.dev4.etalon.entity.Head_of_practice;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface Head_of_practiceRepository extends JpaRepository<Head_of_practice, Integer> {
    @Query("select l from Head_of_practice l where concat(l.first_name, l.last_name, l.company,l.department)" +
            " like concat('%', :skey, '%') ")
    Page<Head_of_practice> findForTable(@Param("skey") String key, Pageable page);
}
