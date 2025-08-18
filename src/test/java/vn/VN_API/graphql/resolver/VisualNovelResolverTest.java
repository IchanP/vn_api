package vn.VN_API.graphql.resolver;

import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.verify;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import static org.assertj.core.api.Assertions.assertThat;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import vn.VN_API.entity.VisualNovelEntity;
import vn.VN_API.entity.VnTitlesEntity;
import vn.VN_API.graphql.databuilders.VisualNovelEntityTestDataBuilder;
import vn.VN_API.graphql.databuilders.VisualNovelTitleEntityTestDataBuilder;
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

    // Setup VN return
    String id = "v2";
    String imageId = "c2";
    String cImageId = "c3";

    VisualNovelEntity vnEntity = VisualNovelEntityTestDataBuilder.aVisuaLNovel().withId(id)
        .withImage(imageId).withCImage(cImageId).build();

    given(vnRepo.findById(id)).willReturn(Optional.of(vnEntity));

    // Setup title return
    String language = "jp";

    VnTitlesEntity titleEntity =
        VisualNovelTitleEntityTestDataBuilder.aVnTitle().withId(id).withLanguage(language).build();
    List<VnTitlesEntity> titleList = new ArrayList<>();
    titleList.add(titleEntity);

    given(titleRepo.findByIdVnId(id)).willReturn(titleList);

    // Setup Vote return



    Optional<VisualNovelData> data = resolver.vn(id);

  }

}
