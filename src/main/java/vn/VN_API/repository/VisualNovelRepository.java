package vn.VN_API.repository;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.VN_API.entity.VisualNovelEntity;

// NOTE - Supported query methods
// https://docs.spring.io/spring-data/jpa/reference/repositories/query-keywords-reference.html#appendix.query.method.subject
// https://docs.spring.io/spring-data/jpa/reference/repositories/query-methods-details.html#:~:text=CREATE%20attempts%20to%20construct%20a,construction%20in%20%E2%80%9CQuery%20Creation%E2%80%9D.
@Repository
public interface VisualNovelRepository extends JpaRepository<VisualNovelEntity, String> {
  List<VisualNovelEntity> findByTitle(String title);

  // Pagination
  Page<VisualNovelEntity> findByIdGreaterThan(String id, Pageable pageable);

  Page<VisualNovelEntity> findByIdLessThan(String id, Pageable pageable);
}
