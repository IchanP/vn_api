package vn.VN_API.graphql.databuilders;

import vn.VN_API.entity.VnTitlesEntity;
import vn.VN_API.entity.VnTitlesEntity.VnTitleId;

public class VisualNovelTitleEntityTestDataBuilder {
  String vnId = "v1";
  String language = "jp";
  Boolean official = false;
  String title = "Test Title";
  String latin = null;

  public static VisualNovelTitleEntityTestDataBuilder aVnTitle() {
    return new VisualNovelTitleEntityTestDataBuilder();
  }

  public VisualNovelTitleEntityTestDataBuilder withId(String vnId) {
    this.vnId = vnId;
    return this;
  }

  public VisualNovelTitleEntityTestDataBuilder withLanguage(String language) {
    this.language = language;
    return this;
  }

  public VisualNovelTitleEntityTestDataBuilder withOfficial(Boolean official) {
    this.official = official;
    return this;
  }

  public VisualNovelTitleEntityTestDataBuilder withTitle(String title) {
    this.title = title;
    return this;
  }

  public VisualNovelTitleEntityTestDataBuilder withLatin(String latin) {
    this.latin = latin;
    return this;
  }

  public VisualNovelTitleEntityTestDataBuilder complete() {
    this.latin = "Test latin title";
    return this;
  }


  public VnTitlesEntity build() {
    VnTitlesEntity entity = new VnTitlesEntity();
    VnTitleId id = new VnTitleId();

    id.setVnId(vnId);
    id.setLanguage(language);
    entity.setId(id);
    entity.setOfficial(official);
    entity.setTitle(title);
    entity.setLatin(latin);

    return entity;
  }

}
