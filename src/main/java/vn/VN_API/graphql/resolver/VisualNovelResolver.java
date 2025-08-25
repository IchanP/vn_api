package vn.VN_API.graphql.resolver;

import java.util.List;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.graphql.data.method.annotation.SchemaMapping;
import org.springframework.stereotype.Controller;
import graphql.schema.DataFetchingEnvironment;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
@Slf4j
@RequiredArgsConstructor
public class VisualNovelResolver {
  private final VisualNovelRepository vnRepo;
  private final VisualNovelTitleRepository titleRepo;
  private final VnLengthVoteRepository voteRepo;

  // https://docs.spring.io/spring-graphql/reference/controllers.html#controllers.schema-mapping
  // https://claude.ai/chat/b0b84218-1163-4dd7-a8a0-d2b1b9b2c0c0

  @QueryMapping
  public Optional<VisualNovelEntity> vn(@Argument String id) {
    return vnRepo.findByVndbId(id);
    // TODO - Clean this up...

    // List<VnLengthVotesEntity> votes = voteRepo.findByIdVid(id);
    // int length = VoteLengthCalculator.calculateAverageLength(votes);

  }

  // TODO add dataLoader and datafetchingenvironment to here...
  // https://claude.ai/chat/b0b84218-1163-4dd7-a8a0-d2b1b9b2c0c0
  @SchemaMapping(typeName = "VisualNovel", field = "titles")
  public CompletableFuture<List<VnTitlesEntity>> titleWithContext(VisualNovelEntity vn) {
    List<VnTitlesEntity> titles = titleRepo.findByIdVnId(vn.getId());
    return CompletableFuture.completedFuture(titles);
  }

  @SchemaMapping(typeName = "Title", field = "language")
  public String language(VnTitlesEntity title) {
    return title.getId().getLanguage();
  }

  @SchemaMapping(typeName = "VisualNovel", field = "length")
  public int length(VisualNovelEntity vn) {
    List<VnLengthVotesEntity> votes = voteRepo.findByIdVid(vn.getId());
    return VoteLengthCalculator.calculateAverageLength(votes);
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
