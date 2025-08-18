package vn.VN_API.entity;

import java.time.LocalDate;
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
@Table(name = "vn_length_votes")
public class VnLengthVotesEntity {

  @EmbeddedId
  private VnLengthVotesId id;

  @Column(name = "date")
  private LocalDate date;

  @Column(name = "length")
  private Short length;

  @Column(name = "speed")
  private Short speed;

  @Column(name = "notes")
  private String notes;

  @Embeddable
  @Data
  @EqualsAndHashCode
  public static class VnLengthVotesId {

    @Column(name = "vid", columnDefinition = "vndbid")
    private String vid;

    @Column(name = "uid", columnDefinition = "vndbid")
    private String uid;
  }
}
