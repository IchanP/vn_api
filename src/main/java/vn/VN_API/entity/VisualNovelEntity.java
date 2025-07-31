package vn.VN_API.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor;

// TODO - https://www.w3resource.com/PostgreSQL/snippets/postgresql-spring-boot.php

@Entity
@Data
@Table(name = "vn")
@NoArgsConstructor
public class VisualNovelEntity {

  @Id
  @Column(name = "id")
  private String id;

  // Image fields are FKs
  @Column(name = "image")
  private String image;

  @Column(name = "c_image")
  private String cImage;

  @Column(name = "olang")
  private String originalLanguage;

  @Column(name = "l_wikidata")
  private Integer wikidataId;

  @Column(name = "c_votecount")
  private Integer voteCount;

  @Column(name = "c_rating")
  private Short rating;

  @Column(name = "c_average")
  private Short average;

  @Column(name = "length")
  private Short length;

  @Column(name = "devstatus")
  private Short developmentStatus;

  @Column(name = "alias")
  private String alias;

  @Column(name = "l_renai")
  private String renaiData;

  @Column(name = "description")
  private String description;
}
