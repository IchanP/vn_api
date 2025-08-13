package vn.VN_API.graphql.resolver;

import java.util.Optional;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;
import vn.VN_API.entity.VisualNovelEntity;
import vn.VN_API.graphql.model.DTO.VisualNovelData;
import vn.VN_API.graphql.model.Response.VisualNovelConnection;
import vn.VN_API.repository.VisualNovelRepository;
import vn.VN_API.repository.VisualNovelTitleRepository;
import vn.VN_API.repository.VnLengthVoteRepository;

@Controller
public class VisualNovelResolver {
  private final VisualNovelRepository vnRepo;
  private final VisualNovelTitleRepository titleRepo;
  private final VnLengthVoteRepository lengthRepo;

  public VisualNovelResolver(VisualNovelRepository vnRepository,
      VisualNovelTitleRepository titlesRepository, VnLengthVoteRepository lengthRepository) {
    this.vnRepo = vnRepository;
    this.titleRepo = titlesRepository;
    this.lengthRepo = lengthRepository;
  }

  @QueryMapping
  public Optional<VisualNovelData> vn(@Argument String id) {
    Optional<VisualNovelEntity> entity = vnRepo.findById(id);
    if (entity.isEmpty()) {
      return Optional.empty();
    }

    return null;
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
