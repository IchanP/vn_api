package vn.VN_API.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@Table(name = "vn_titles")
public class VnTitlesEntity {

  @EmbeddedId
  private VnTitleId id;

  @Column(name = "official")
  private boolean official;

  @Column(name = "title")
  private String title;

  @Column(name = "latin")
  private String latin;

  @Embeddable
  @Data
  @EqualsAndHashCode
  public static class VnTitleId {

    @Column(name = "id", columnDefinition = "vndbid")
    private String vnId;

    @Column(name = "lang", columnDefinition = "language")
    private String language;
  }
}
