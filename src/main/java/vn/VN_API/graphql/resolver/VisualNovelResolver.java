package vn.VN_API.graphql.resolver;

import java.util.List;
import java.util.Optional;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;
import vn.VN_API.entity.VisualNovelEntity;
import vn.VN_API.entity.VnLengthVotesEntity;
import vn.VN_API.entity.VnTitlesEntity;
import vn.VN_API.graphql.model.DTO.VisualNovelData;
import vn.VN_API.graphql.model.Response.VisualNovelConnection;
import vn.VN_API.repository.VisualNovelRepository;
import vn.VN_API.repository.VisualNovelTitleRepository;
import vn.VN_API.repository.VnLengthVoteRepository;
import vn.VN_API.util.VoteLengthCalculator;

@Controller
public class VisualNovelResolver {
  private final VisualNovelRepository vnRepo;
  private final VisualNovelTitleRepository titleRepo;
  private final VnLengthVoteRepository voteRepo;

  public VisualNovelResolver(VisualNovelRepository vnRepository,
      VisualNovelTitleRepository titlesRepository, VnLengthVoteRepository voteRepository) {
    this.vnRepo = vnRepository;
    this.titleRepo = titlesRepository;
    this.voteRepo = voteRepository;
  }

  @QueryMapping
  public Optional<VisualNovelData> vn(@Argument String vnId) {
    Optional<VisualNovelEntity> vnEntity = vnRepo.findById(vnId);
    if (vnEntity.isEmpty()) {
      return Optional.empty();
    }

    List<VnTitlesEntity> titles = titleRepo.findByIdVnId(vnId);
    if (titles.size() == 0) {
      return Optional.empty();
    }

    List<VnLengthVotesEntity> votes = voteRepo.findByIdVnId(vnId);
    int length = VoteLengthCalculator.calculateAverageLength(votes);

    VisualNovelData data = new VisualNovelData(vnEntity.get(), titles, length);

    return Optional.of(data);
  }

  @QueryMapping
  public VisualNovelConnection vns(@Argument Integer first, @Argument String after,
      @Argument Integer last, @Argument String before
  // TODO - Implement visualNovelInput in Java @Argument VisualNovelInput input
  ) {
    // TODO: implement pagination logic... and also figure out about the batchloader...
    throw new UnsupportedOperationException("Not implemented yet");
  }
}
