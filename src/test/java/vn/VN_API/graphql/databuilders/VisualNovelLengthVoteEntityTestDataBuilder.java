package vn.VN_API.graphql.databuilders;

import java.time.LocalDate;
import vn.VN_API.entity.VnLengthVotesEntity;
import vn.VN_API.entity.VnLengthVotesEntity.VnLengthVotesId;

public class VisualNovelLengthVoteEntityTestDataBuilder {
  String vid = "v1";
  String uid = "u1";
  Short length = 520;
  LocalDate date = null;
  Short speed = null;
  String notes = null;

  public static VisualNovelLengthVoteEntityTestDataBuilder aVnVote() {
    return new VisualNovelLengthVoteEntityTestDataBuilder();
  }

  public VisualNovelLengthVoteEntityTestDataBuilder withVid(String vid) {
    this.vid = vid;
    return this;
  }

  public VisualNovelLengthVoteEntityTestDataBuilder withUid(String uid) {
    this.uid = uid;
    return this;
  }

  public VisualNovelLengthVoteEntityTestDataBuilder withLength(Short length) {
    this.length = length;
    return this;
  }

  public VisualNovelLengthVoteEntityTestDataBuilder withDate(LocalDate date) {
    this.date = date;
    return this;
  }

  public VisualNovelLengthVoteEntityTestDataBuilder withSpeed(Short speed) {
    this.speed = speed;
    return this;
  }

  public VisualNovelLengthVoteEntityTestDataBuilder withNotes(String notes) {
    this.notes = notes;
    return this;
  }

  public VisualNovelLengthVoteEntityTestDataBuilder complete() {
    this.date = LocalDate.now();
    this.speed = 5;
    this.notes = "A test not for a vote.";
    return this;
  }

  public VnLengthVotesEntity build() {
    VnLengthVotesEntity entity = new VnLengthVotesEntity();
    VnLengthVotesId id = new VnLengthVotesId();
    id.setVid(vid);
    id.setUid(uid);

    entity.setId(id);
    entity.setLength(length);
    entity.setDate(date);
    entity.setSpeed(speed);
    entity.setNotes(notes);

    return entity;
  }
}
