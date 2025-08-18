package vn.VN_API.graphql.model.DTO;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import vn.VN_API.entity.VisualNovelEntity;
import vn.VN_API.entity.VnTitlesEntity;

@Data
@AllArgsConstructor
public class VisualNovelData {
  private VisualNovelEntity visualNovel;
  private List<VnTitlesEntity> titles;
  private int length; // Minutes
}
