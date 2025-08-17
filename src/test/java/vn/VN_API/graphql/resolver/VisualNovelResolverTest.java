package vn.VN_API.graphql.resolver;

import vn.VN_API.graphql.resolver.VisualNovelEntityTestDataBuilder;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.verify;
import java.util.Optional;
import static org.assertj.core.api.Assertions.assertThat;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import vn.VN_API.entity.VisualNovelEntity;
import vn.VN_API.graphql.model.DTO.VisualNovelData;
import vn.VN_API.repository.VisualNovelRepository;
import vn.VN_API.repository.VisualNovelTitleRepository;
import vn.VN_API.repository.VnLengthVoteRepository;

@ExtendWith(MockitoExtension.class)
public class VisualNovelResolverTest {

  @Mock
  private VisualNovelTitleRepository titleRepo;

  @Mock
  private VisualNovelRepository vnRepo;

  @Mock
  private VnLengthVoteRepository voteRepo;

  @InjectMocks
  private VisualNovelResolver resolver;

  @Test
  void singularResolvesToEmpty() {
    String id = "v2";
    given(vnRepo.findById(id)).willReturn(Optional.empty());
    Optional<VisualNovelData> shouldBeEmpty = resolver.vn(id);

    verify(vnRepo).findById(id);
    assertThat(shouldBeEmpty).isEmpty();
  }

  @Test
  void singularResolvesToExpectedFields() {
    String id = "v2";
    String imageId = "c2";
    String cImageId = "c3";

    VisualNovelEntity entity = VisualNovelEntityTestDataBuilder.aVisuaLNovel().withId(id)
        .withImage(imageId).withCImage(cImageId).build();

    given(vnRepo.findById(id)).willReturn(Optional.of(entity));
  }

}
