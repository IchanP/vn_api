package vn.VN_API.graphql.resolver;

import static org.mockito.BDDMockito.given;
import static org.mockito.BDDMockito.willReturn;
import static org.mockito.Mockito.verify;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import static org.assertj.core.api.Assertions.assertThat;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import vn.VN_API.entity.VisualNovelEntity;
import vn.VN_API.entity.VnLengthVotesEntity;
import vn.VN_API.entity.VnTitlesEntity;
import vn.VN_API.graphql.databuilders.VisualNovelEntityTestDataBuilder;
import vn.VN_API.graphql.databuilders.VisualNovelLengthVoteEntityTestDataBuilder;
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

  private VisualNovelEntity vnEntity;

  private String vnId;
  private String imageId;
  private String cImageId;

  @BeforeEach
  void setupCommonData() {
    vnId = "v2";
    imageId = "cv2";
    cImageId = "cv3";
    vnEntity = VisualNovelEntityTestDataBuilder.aVisuaLNovel().withId(vnId).withImage(imageId)
        .withCImage(cImageId).build();
    given(vnRepo.findById(vnId)).willReturn(Optional.of(vnEntity));
  }

  @Test
  void singularResolvesToEmpty() {
    String id = "v2";
    given(vnRepo.findById(id)).willReturn(Optional.empty());
    Optional<VisualNovelData> shouldBeEmpty = resolver.vn(id);

    verify(vnRepo).findById(id);
    assertThat(shouldBeEmpty).isEmpty();
  }

  @Test
  void resolvesWithTitlesAndVotes() {
    setupTitles("jp");
    setupVotes(List.of((short) 10, (short) 20));

    Optional<VisualNovelData> data = resolver.vn(vnId);

    assertThat(data).isPresent();
    VisualNovelData vnData = data.get();
    assertThat(vnData.getLength()).isNotNull();
    assertThat(vnData.getTitles().get(0).getId().getLanguage()).isEqualTo("jp");
    assertThat(vnData.getVisualNovel().getId()).isEqualTo(vnId);
  }


  @Test
  void handlesEmptyTitlesList() {
    // TODO - is this how we want it to act?
    setupVotes(List.of((short) 15));
    given(titleRepo.findByIdVnId(vnId)).willReturn(List.of());

    Optional<VisualNovelData> data = resolver.vn(vnId);

    assertThat(data).isPresent();
    assertThat(data.get().getTitles()).isEmpty();
  }


  @Test
  void calculatesLengthFromVotesCorrectly() {
    setupTitles("en");
    Short shortest = 5;
    Short medium = 15;
    Short longest = 25;

    setupVotes(List.of((short) shortest, (short) medium, (short) longest));

    Optional<VisualNovelData> data = resolver.vn(vnId);

    int expectedCalculatedLength = (shortest + medium + longest) / 3;

    assertThat(data).isPresent();
    // Assert the length calculation (average? median?)
    assertThat(data.get().getLength()).isEqualTo(expectedCalculatedLength);
  }

  private void setupTitles(String language) {
    VnTitlesEntity titleEntity = VisualNovelTitleEntityTestDataBuilder.aVnTitle().withId(vnId)
        .withLanguage(language).build();
    given(titleRepo.findByIdVnId(vnId)).willReturn(List.of(titleEntity));
  }

  private void setupVotes(List<Short> lengths) {
    List<VnLengthVotesEntity> votes = lengths.stream().map(
        length -> VisualNovelLengthVoteEntityTestDataBuilder.aVnVote().withLength(length).build())
        .toList();
    given(voteRepo.findByIdVnId(vnId)).willReturn(votes);
  }

}
