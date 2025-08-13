package vn.VN_API.graphql.resolver;


import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.verify;
import java.util.Optional;
import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
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
    // TODO implement
  }

}
