package vn.VN_API.repository;

import java.util.Collection;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import vn.VN_API.entity.VnLengthVotesEntity;
import vn.VN_API.entity.VnLengthVotesEntity.VnLengthVotesId;

public interface VnLengthVoteRepository
    extends JpaRepository<VnLengthVotesEntity, VnLengthVotesId> {
  // Needs to be set to optional as it may be null...
  List<VnLengthVotesEntity> findByIdVid(String id);

  // To fetch several at once for paged queries.
  List<VnLengthVotesEntity> findByIdVidIn(Collection<String> vnIds);
}
