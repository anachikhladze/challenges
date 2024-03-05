import Foundation

// MARK: - Challenge 1
/* Მოცემულია String ტიპის ცვლადი “s”. იპოვეთ ყველაზე გრძელი ისეთი substring-ის ზომა,
 რომელშიც ყველა სიმბოლო უნიკალურია(არ მეორდება).
 */

func lengthOfLongestSubstring(_ s: String) -> Int {
    var longest = 0
    var startIndex = 0
    var charMap = [Character: Int]()
    
    for (index, char) in s.enumerated() {
        if let foundIndex = charMap[char] {
            startIndex = max(foundIndex + 1, startIndex)
        }
        longest = max(longest, index - startIndex + 1)
        charMap[char] = index
    }
    return longest
}

print("Length of longest substring is \(lengthOfLongestSubstring("abcabcbb"))")
print("Length of longest substring is \(lengthOfLongestSubstring("bbbbb"))")

// MARK: - Challenge 2
/*
 Მოცემულია ორი String ცვლადი “s” და “t” დააბრუნეთ მინიმალური ფანჯარა(უწყვეტი
 საბსტრინგი) “s”-დან რომელიც შეიცავს “t”-ში შემავალ ყველა სიმბოლოს. თუ “s”-ში არ არის
 ისეთი ფანჯარა, რომელიც მოიცავს “t”-ის ყველა სიმბოლოს, დააბრუნეთ ცარიელი
 სტრინგი("").
 */

func minWindow(_ s: String, _ t: String) -> String {
    var sChars = Array(s)
    let tChars = Array(t)
    
    var charCount = Array(repeating: 0, count: 128)
    for char in tChars {
        charCount[Int(char.asciiValue!)] += 1
    }
    
    var required = t.count
    var left = 0
    var minLeft = 0
    var minLength = Int.max
    
    var i = 0
    while i < s.count {
        if charCount[Int(sChars[i].asciiValue!)] > 0 {
            required -= 1
        }
        charCount[Int(sChars[i].asciiValue!)] -= 1
        while required == 0 {
            if i - left + 1 < minLength {
                minLength = i - left + 1
                minLeft = left
            }
            charCount[Int(sChars[left].asciiValue!)] += 1
            if charCount[Int(sChars[left].asciiValue!)] > 0 {
                required += 1
            }
            left += 1
        }
        i += 1
    }
    
    return minLength == Int.max ? "" : String(sChars[minLeft..<minLeft+minLength])
}

print(minWindow("ADOBECODEBANC", "ABC"))
print(minWindow("a", "aa"))

// MARK: - Challenge 3
/*
 Მოცემულია String “s” და String-ების მასივი “words”. დააბრუნეთ “true” თუ შეიძლება
 “s”-ის დაყოფა “-”-ით დაშორებული სიტყვების მიმდევრობად “words”-დან.
 */

func wordBreak(_ s: String, _ words: [String]) -> Bool {
    let sLength = s.count
    var dp = [Bool](repeating: false, count: sLength + 1)
    dp[0] = true
    
    let wordSet = Set(words)
    
    for i in 1...sLength {
        for j in 0..<i {
            let startIndex = s.index(s.startIndex, offsetBy: j)
            let endIndex = s.index(s.startIndex, offsetBy: i)
            let subString = String(s[startIndex..<endIndex])
            
            if dp[j] && wordSet.contains(subString) {
                dp[i] = true
                break
            }
        }
    }
    
    return dp[sLength]
}

print(wordBreak("leetcode", ["leet", "code"]))
print(wordBreak("applepenapple", ["apple", "pen"]))
