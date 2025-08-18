package vn.VN_API.util;

import java.util.List;
import vn.VN_API.entity.VnLengthVotesEntity;

public class VoteLengthCalculator {

  public static Integer calculateAverageLength(List<VnLengthVotesEntity> votes) {
    if (votes == null || votes.isEmpty())
      return null;

    int total = 0;

    for (VnLengthVotesEntity vote : votes) {
      total += vote.getLength();
    }

    return total / votes.size();
  }
}
