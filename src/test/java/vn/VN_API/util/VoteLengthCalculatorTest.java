package vn.VN_API.util;

import static org.assertj.core.api.Assertions.assertThat;
import java.util.List;
import org.junit.jupiter.api.Test;
import vn.VN_API.entity.VnLengthVotesEntity;
import vn.VN_API.graphql.databuilders.VisualNovelLengthVoteEntityTestDataBuilder;

public class VoteLengthCalculatorTest {
    @Test
    void calculatesAverageCorrectly() {
        List<VnLengthVotesEntity> votes = List.of(voteWithLength((short) 10),
                voteWithLength((short) 20), voteWithLength((short) 30));

        Integer result = VoteLengthCalculator.calculateAverageLength(votes);

        assertThat(result).isEqualTo(20);
    }

    @Test
    void handlesEmptyVotesList() {
        Integer result = VoteLengthCalculator.calculateAverageLength(List.of());
        assertThat(result).isNull();
    }

    private VnLengthVotesEntity voteWithLength(Short length) {
        return VisualNovelLengthVoteEntityTestDataBuilder.aVnVote().withLength(length).build();
    }
}
