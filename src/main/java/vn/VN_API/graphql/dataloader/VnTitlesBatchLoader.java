package vn.VN_API.graphql.dataloader;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionStage;
import java.util.stream.Collectors;
import org.dataloader.BatchLoader;
import vn.VN_API.entity.VnTitlesEntity;
import vn.VN_API.repository.VisualNovelTitleRepository;

public class VnTitlesBatchLoader implements BatchLoader<String, List<VnTitlesEntity>> {

  private final VisualNovelTitleRepository vnTitleRepository;

  public VnTitlesBatchLoader(VisualNovelTitleRepository repository) {
    this.vnTitleRepository = repository;
  }

  @Override
  public CompletionStage<List<List<VnTitlesEntity>>> load(List<String> vnIds) {
    List<VnTitlesEntity> allTitles = this.vnTitleRepository.findByIdVnIdIn(vnIds);

    return CompletableFuture.supplyAsync(() -> vnIds
        .stream().map(vnId -> allTitles.stream()
            .filter(title -> title.getId().getVnId().equals(vnId)).collect(Collectors.toList()))
        .collect(Collectors.toList()));
  }
}
