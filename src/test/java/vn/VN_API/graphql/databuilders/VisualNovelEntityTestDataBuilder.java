package vn.VN_API.graphql.databuilders;

import vn.VN_API.entity.VisualNovelEntity;

public class VisualNovelEntityTestDataBuilder {

  String id = "v1";
  String image = "ci2"; // TODO make this match real data...
  String cImage = "c2"; // TODO make this match real data....
  String originalLanguage = "jp";
  Integer wikidataId = null;
  Integer voteCount = null;
  Short rating = null;
  Short average = null;
  Short length = null;
  Short developmentStatus = null;
  String alias = null;
  String renaiData = null;
  String description = null;

  public static VisualNovelEntityTestDataBuilder aVisuaLNovel() {
    return new VisualNovelEntityTestDataBuilder();
  }

  public VisualNovelEntityTestDataBuilder withId(String id) {
    this.id = id;
    return this;
  }

  public VisualNovelEntityTestDataBuilder withImage(String image) {
    this.image = image;
    return this;
  }

  public VisualNovelEntityTestDataBuilder withCImage(String cImage) {
    this.cImage = cImage;
    return this;
  }

  public VisualNovelEntityTestDataBuilder withOriginalLanguage(String originalLanguage) {
    this.originalLanguage = originalLanguage;
    return this;
  }

  public VisualNovelEntityTestDataBuilder withWikidataId(Integer wikidataId) {
    this.wikidataId = wikidataId;
    return this;
  }

  public VisualNovelEntityTestDataBuilder withVoteCount(Integer voteCount) {
    this.voteCount = voteCount;
    return this;
  }

  public VisualNovelEntityTestDataBuilder withRating(Short rating) {
    this.rating = rating;
    return this;
  }

  public VisualNovelEntityTestDataBuilder withLength(Short length) {
    this.length = length;
    return this;
  }

  public VisualNovelEntityTestDataBuilder withDevelopmentStatus(Short developmentStatus) {
    this.developmentStatus = developmentStatus;
    return this;
  }

  public VisualNovelEntityTestDataBuilder withAlias(String alias) {
    this.alias = alias;
    return this;
  }

  public VisualNovelEntityTestDataBuilder withRenaiData(String renaiData) {
    this.renaiData = renaiData;
    return this;
  }

  public VisualNovelEntityTestDataBuilder withDescription(String description) {
    this.description = description;
    return this;
  }


  public VisualNovelEntityTestDataBuilder complete() {
    // TODO look over data to make sure this mimics internal data...
    this.wikidataId = 123456;
    this.voteCount = 50;
    this.rating = 80;
    this.average = 80;
    this.length = 3;
    this.developmentStatus = 2;
    this.alias = "Test VN";
    this.description = "A test visual novel";
    return this;
  }


  public VisualNovelEntity build() {
    VisualNovelEntity entity = new VisualNovelEntity();
    entity.setId(id);
    entity.setImage(image);
    entity.setCImage(cImage);
    entity.setOriginalLanguage(originalLanguage);
    entity.setWikidataId(wikidataId);
    entity.setVoteCount(voteCount);
    entity.setRating(rating);
    entity.setAverage(average);
    entity.setLength(length);
    entity.setDevelopmentStatus(developmentStatus);
    entity.setAlias(alias);
    entity.setRenaiData(renaiData);
    entity.setDescription(description);

    return entity;
  }

}


