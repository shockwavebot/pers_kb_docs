const IN06: &str = "rqwqtwwrmrqqrcrtrpppjrjgrgjgqgttgbbhppftpfpdpmpsstffqvfqvvdjjpllltqltqtrrzlllbldbdsdqqgpqggzccgbgnnmjmljmljldjldjjlnnhndhdmmslmslmlhmmntnrtnrnbrbqrqhqfftwftfsfzfcfrrzllchcwwtwstwwjwrjjfwwgzwzqzpzhzqhqbhqhssltsszhsszdssrwssdppjcpjjrwjwnwjnnzjjhsjhsjsjvvtffffqfflglwglgbgpbgbgghfghfhdfhdfhfssqppvlvslltwwhwvwpwgggnpnnmqnntqnnlhhdbhdbbtvvcrrcgrrdrvrjvvlmlnmndnmnrncnznsnsqnsswrwzwmwzzbpbhphqhpqpbpqpjpjvpvwpvwppdvdhdccqbccfncctrcrjcjjdsdhdnhhwpwlwwbmbhmbhhpzhhccvffqqnsqqmnnspnnpfpzppspgsppgbbdwbbdcchfhgfhfllljtllnjlnlddvcdvdqvvqwqppprtpthtthqqfbqqpfpzfpfcfsscrsccbgbngbbgdbbpgpqqlmqlmmgffqqqsbqbtblbwbqqvbqvbqvvnzvzpvvqhvqqtltptllbflbflbflltddlblflvfvbffmsffhlhshmmgbbgjjdndqqmqllzjzvvhjhnhcnchhznnhhppwqpwpffwvwzzppwpfwftwtnnqbnqnrnrzznffzzblzlvzlzrrszscsqcssbggcgvvddsttgqqgwgcclzzszddlvddvbddrlrcllrblrrhlldzdtdccqllsblsszlszzdllhjljhhhzhffdwfdwfddwdtdrtdtntddldsllqffdvdhdpdhdrdprprrhggdqgghggmwgmghhchlhmllrnrdrcrqccbqqfbqbccjpjhhvppcwpwffmmzzfqflfjfdfbfqqtmthmttwftwwpmpzplzzpvvgppsbpbccbtcbcddzbzwwmsscrcctgtgjgtjthhjzzcqqmmmvccwjcwjwzzwnnwgwtgwwbsbvbccrscccnggfjfwfjfrfsfddncdncndnqqwzzmssbdsbswswdddpdqdbddcvcmmwwssrtrrlddndmdtmtdmttwwmsmffwqwvwbwhbbqfqqgcqcmctctntjntnbnrbrmbbqtqccqbcbvbnbqnnghgbbmfmwmdwmdmpmwppdwpdwwnzwnwrnwrnntqnttcmcqqbrqrttsjtstcscpcspsnswsggrhggjrjjbhhbnbmmdlmddtqdtdrdwwjvjgjjdhjdddbwwsfflppbwbcbpbjjzqznnrwnnvmvjvwvqqrlljgjmjjqhjhwjhwjjsvsnvvlwlqqjpjjbsjjcddtfthffrqfrqrfqfrfllfzzqllztltnltntpttqmmgwmwwwjjdrjrzrlrwlwzzzzphpphvphvphvpvdvfdflljgglrlrqlrrfpfqpqnpqpmmblbflbfbpfpwpjwpjpbjpjmjljblldbllnrnjjjljrlrcrrgzgbbzrznzzhnzhhtmhmqhmqqnzzvfzvzfftjftfvvpmvppwzzhnzhzvvwzwwqcwctwwgrrtgglgngsgvgwvwpvpbbrvrvwrvwvbwwpsprrrcbbpqppfjjjqnjndnmddvsvlslmmwwdwcchmmrjmjwwsrwrhwwpcgmpmvbdmlmqbnblbbgtmtgqslnvcnmwrflrnwhqzrsnwhncwdvbcpjrqsscwzrjvslhscpvmqjnltwhshjmbhgttbzllrvpnhgdmwtddbwmpgbhrndpgwzfvqdmpcvhlnjnqbwqmshgwhmfjgsbscsjtfbfvmlljqwwjtnltbzjpcqdfmdldvmsnmzqmghcvhlpjzzszcpvldrflbcppzwgppfpbslplrqwgbfwpwbtbnrmbrrrpqndzvhmlhvtlnjvhdrhhvmwzjntsgffjsdpdlhnlslnbmbsmdsvpmpbjpjcwhbpfnhbmttfglglnnhhcqvbpvnrwcszwjsdhqwctrpgsrcbfpzhbnrbllrlflqdlgzwpwgwwvmbsppbcjcdltbgwfndqjlvndhtclfmwnqrbfvvqdzspfcslplhtmsqqtrcdvbhfscvnmzplcglwnzbvgflclclqmdgfzjqqrrmpcqrzgqcnzbmncmvdzrmmvfqrrqzqbjmjgjwmfbnmmgvmzsgjjspjqbvfhrdvllgqsffjnfqdthjbjwhwqdqhsnctwgbszvrsbwbpptcjjvftnhdmwmhtjrjrlrdrqjznhqftgtldnpbrlprjmplmwdbzqpmwwvcqccjlhqbhcjprvrfmmfmljwmbrlhcglthgbmrfmbpsztfcglpzlfbpjhmvcmvrprmvmrvvgbbllzschwshhfbnmgwrbhlqvsdjdmmbtjzthwssghtqvhtqcswdhbwhphhsrwhwwtslwvrhpgqfmftnrtqpwfqqdgftdlqfndjlzhvlrthnqdqrzpprdgwwqlplrmqtdqgbdntmjcjhlbbmctvnnhtppfbjpsbmndbdplqlfqfhzqvtqcvmprwbhdtjrqrqvmcssqnfqwtchmjfjlpwsghplbthdnbhfbhhphdmlmtjcvmzjbnqbfldrvlmjfnnrlsnwrtnrpfqdhchltmbvjzhgjwzblqdthmffztqvzzfszmdqdzlfpbfgjfdjqscrhvjflbllnlghncczrlpcbwpnmzcnqhbfnlmnbqvmwvbchwhlfcssctsdcwmtfdgbhljwprfncdgwlgzzmvfqrdsmlwbrmbmtzqqdqdpzvtbstscglrwdpndnstrhgjchnpzsvcjngmzsddwsbllpvqqzzjlmsbncbndqmqphzqzcngjzpfnjmsvngtcvhhjsssrnhjrsmvbsrdjcrppvgsqbqjzbrhjqlgmqfclbrdhwwjdlsjnmjcjrmsstngswrhmdqthprcbrndfpdjgpqtfmmfvbztqdhzhzbzhjjpfgnvrmspdvmhfvbvztmlrhfqfdcfnzzndlfldpfhrbjrwlwnprdmqjwppbrdjhpbvnrvjlrbwdwttzhqqgcclbwghbgrhcvwjrrchqgzztrjgrltcpdscjdfcphndfzdqsbpsjrljdnflfvrzcrjflddfgpvnpmdqbhzwbfrpzsnpbcbgfchvvmqpnfpvvdvhfnpbfzwmbnlpqzgrpwtsjbpzdrsfmnfqwqvpgnrjhmvmphlfdpfhdjljlzftdzdvhjrvjdctwfrctglwmrtdlrvmhcqvfvpgmstghczmvclptzspdsrlvrgvjtvflhsmqswdpqjrrnhgrggzmcpqsctqbhpqrsbstwzgzghqgltcpbrhbcdqlhfjhlcrnhrpjdzlzqqprvzntbjztqgdqqttmbpbcfbjmdjqsflbczmfnsjdzcnnmjjllhvwbwlgrlpvbffwjvctwnrsfqdnwntscpsjnshhdmcqmcpscrmzltldwlmfnbhbtprsgtsbvzfrsfpvmqjzjqqhwdjjzvbhrvtbscrcpzrqsbgfbpwqfmbsrlhhtntjmtrtlwqsdbmgtdlrwfdnmwwzlltbrjgghbstbnffzmzzdlcdgvmrzsjnqjvczmhrgwbrblrqfmzbbcnfsbfpgjsmptzbclfdnwfgbzlpbgqrdhdmfjdnlzczdpvtbzdmrthslngbrldllfcjplhglmwsfpqjnrgpgqfmbbwchbrqqsncfwnmgdmtchdhlzzqjvtvtvgqbtwvwpsjqwdqhrlfmdgdzchvfbcmqjllpjtnphwqvfwpcjmzqhsbwlcmbsgththrsjtnzlsrcptgtrfcwptbstcsdzbwjljzjztzbqsjdvwglpbpgdjtthjjmsnljltglqcszbzqmblfpncntjzzhmjffldcrcvjjswvzlfffrmsgjtpzggtlpfwpwbmhmggpnmzwrgdjrhglnhfdcjdfjtdjvrnlgqtfqmpgjcvcmnwhhbczwwntfbmgssglngqlttfpcznswvmbprsrzljtlwlljnbbrnwdvvlsbdv";

// do I need to use buf as a array of bytes &[u8] ? 
pub fn get_index_of_first_and_second_match(s: &str) -> (usize, usize) {
    let mut matching_str: &str = s.get(0..1).unwrap(); // first char
    let rest_start: &str = s.get(1..).unwrap(); // input w/o first char
    let mut rest: &str = rest_start;
    let mut index_base: usize = 1;
    for _ in 0..rest_start.len()-1 {
        match rest.find(matching_str) {
            Some(found) => return (index_base - 1, found + index_base),
            None => {
                matching_str = rest.get(0..1).unwrap(); // next char
                rest = rest.get(1..).unwrap(); // shiftng rest of the str
                index_base += 1;
            },
        };
    };
    if matching_str == rest {
        (index_base - 1, index_base)
    } else {
        (0,0)
    }
}

pub fn subroutine_4(buf: &str) {
    let mut pointer: usize = 0;
    for _ in 0..IN06.len()-4 {
        // take 4 from pointer
        let mut marker: &str = IN06.get(pointer..pointer+4).unwrap();
        pointer += 4;
    }
    // is there a duplicate? > where? > what is the next pointer?

    // repeat until there is no duplicate or no more 4-chars to take

}

#[cfg(test)]
mod test {
    use super::get_index_of_first_and_second_match;

    #[test]
    fn test_01() {
        assert_eq!(get_index_of_first_and_second_match("aabb"), (0,1));
        assert_eq!(get_index_of_first_and_second_match("abac"), (0,2));
        assert_eq!(get_index_of_first_and_second_match("abca"), (0,3));
        assert_eq!(get_index_of_first_and_second_match("baac"), (1,2));
        assert_eq!(get_index_of_first_and_second_match("baca"), (1,3));
        assert_eq!(get_index_of_first_and_second_match("bcaa"), (2,3));
        assert_eq!(get_index_of_first_and_second_match("abcd"), (0,0));
        assert_eq!(get_index_of_first_and_second_match("aaaaaaa"), (0,1));
    }
}