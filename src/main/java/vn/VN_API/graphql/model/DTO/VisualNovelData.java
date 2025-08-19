package vn.VN_API.graphql.model.DTO;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import vn.VN_API.entity.VnTitlesEntity;

@Data
@AllArgsConstructor
@Getter
public class VisualNovelData {
  private String id;
  private String description;
  private List<VnTitlesEntity> titles;
  private int length; // Minutes
}
