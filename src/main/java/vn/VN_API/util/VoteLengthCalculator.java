package vn.VN_API.util;

import java.util.List;
import vn.VN_API.entity.VnLengthVotesEntity;

public class VoteLengthCalculator {

  public static Integer calculateAverageLength(List<VnLengthVotesEntity> votes) {
    if (votes == null || votes.isEmpty())
      return null;

    int total = 0;

    int size = votes.size();
    for (VnLengthVotesEntity vote : votes) {
      if (vote != null) {
        total += vote.getLength();
      } else {
        size--;
      }
    }

    return total / size;
  }
}
