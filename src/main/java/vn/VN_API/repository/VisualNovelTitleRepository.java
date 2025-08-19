package vn.VN_API.repository;

import java.util.Collection;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.VN_API.entity.VnTitlesEntity;
import vn.VN_API.entity.VnTitlesEntity.VnTitleId;

// NOTE - Supported query methods
// https://docs.spring.io/spring-data/jpa/reference/repositories/query-keywords-reference.html#appendix.query.method.subject
// https://docs.spring.io/spring-data/jpa/reference/repositories/query-methods-details.html#:~:text=CREATE%20attempts%20to%20construct%20a,construction%20in%20%E2%80%9CQuery%20Creation%E2%80%9D.
@Repository
public interface VisualNovelTitleRepository extends JpaRepository<VnTitlesEntity, VnTitleId> {
  // Needs to be set to optional as it may be null...

  @Query(value = "SELECT * FROM vn_titles WHERE id = CAST(:id AS vndbid)", nativeQuery = true)
  List<VnTitlesEntity> findByIdVnId(@Param("id") String id);

  // To fetch several at once for paged queries.
  List<VnTitlesEntity> findByIdVnIdIn(Collection<String> vnIds);
}
