package vn.VN_API.graphql.dataloader;

import java.util.List;
import java.util.concurrent.CompletionStage;
import org.dataloader.BatchLoader;
import vn.VN_API.entity.VnLengthVotesEntity;
import vn.VN_API.repository.VnLengthVoteRepository;

public class VnLengthBatchLoader implements BatchLoader<String, List<VnLengthVotesEntity>> {

  private final VnLengthVoteRepository repo;

  public VnLengthBatchLoader(VnLengthVoteRepository repo) {
    this.repo = repo;
  }

  @Override
  public CompletionStage<List<List<VnLengthVotesEntity>>> load(List<String> vnIds) {
    // TODO Auto-generated method stub
    throw new UnsupportedOperationException("Unimplemented method 'load'");
  }


}
