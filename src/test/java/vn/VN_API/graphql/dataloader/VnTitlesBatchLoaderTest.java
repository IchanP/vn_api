package vn.VN_API.graphql.dataloader;

import static org.mockito.BDDMockito.given;
import static org.mockito.BDDMockito.verify;
import static org.assertj.core.api.Assertions.assertThat;


import java.util.List;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import vn.VN_API.entity.VnTitlesEntity;
import vn.VN_API.entity.VnTitlesEntity.VnTitleId;
import vn.VN_API.repository.VisualNovelTitleRepository;

@ExtendWith(MockitoExtension.class)
public class VnTitlesBatchLoaderTest {

  @Mock
  private VisualNovelTitleRepository repo;

  @InjectMocks
  private VnTitlesBatchLoader batchLoader;

  @Test
  void filterTitlesById() {
    List<String> vnIds = List.of("v1", "v2");
    // TODO add another V1
    String v2Title = "v2_title";
    List<VnTitlesEntity> titleResponse = List.of(createTestEntity("v1", "en", "TITLE", true),
        createTestEntity("v1", "jp", "JPTITLE", true), createTestEntity("v2", "jp", v2Title, false),
        createTestEntity("v3", "en", "TITLE", true), createTestEntity("v4", "jp", "TITLE", false));

    given(repo.findByIdVnIdIn(vnIds)).willReturn(titleResponse);

    List<List<VnTitlesEntity>> response = batchLoader.load(vnIds).toCompletableFuture().join();
    assertThat(response).isNotNull();
    assertThat(response.size()).isEqualTo(2);
    // Assert that we have both v1s
    assertThat(response.get(0).size()).isEqualTo(2);
    assertThat(response.get(1).get(0).getTitle()).isEqualTo(v2Title);
  }

  private VnTitlesEntity createTestEntity(String vnId, String lang, String title,
      boolean official) {
    VnTitlesEntity entity = new VnTitlesEntity();
    VnTitleId id = new VnTitleId();

    id.setVnId(vnId);
    id.setLanguage(lang);

    entity.setId(id);
    entity.setTitle(title);
    entity.setOfficial(official);

    return entity;
  }
}
