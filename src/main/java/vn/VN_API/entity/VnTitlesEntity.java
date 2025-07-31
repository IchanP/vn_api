package vn.VN_API.entity;

import javax.print.attribute.standard.MediaSize.Other;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
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
  public static class VnTitleId {

    @JdbcTypeCode(SqlTypes.OTHER)
    @Column(name = "id")
    private String vnId;

    @JdbcTypeCode(SqlTypes.OTHER)
    @Column(name = "lang")
    private String language;
  }
}
