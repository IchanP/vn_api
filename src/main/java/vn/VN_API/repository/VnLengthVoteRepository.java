package vn.VN_API.repository;

import java.util.Collection;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import vn.VN_API.entity.VnLengthVotesEntity;
import vn.VN_API.entity.VnLengthVotesEntity.VnLengthVotesId;

public interface VnLengthVoteRepository
    extends JpaRepository<VnLengthVotesEntity, VnLengthVotesId> {
  // Needs to be set to optional as it may be null...

  @Query(value = "SELECT * FROM vn_length_votes WHERE vid = CAST(:id AS vndbid)",
      nativeQuery = true)
  List<VnLengthVotesEntity> findByIdVid(@Param("id") String id);

  // To fetch several at once for paged queries.
  List<VnLengthVotesEntity> findByIdVidIn(Collection<String> vnIds);
}
