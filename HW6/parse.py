"""
Alec Bird
CSE 465-565
Homework 6
4/24/19
"""

ARTICLES = ["a", "the"]
ADJECTIVES = ["yellow", "big"]
NOUNS = ["sun", "children"]
VERBS = ["shines", "illuminates"]
ABVERBS = ["brightly"]

def check_start(word, previous):
    """
    Check that the first word of the sentence is either an article, adjective, noun
    """
    correct = False
    if word in ARTICLES:
        previous = "article"
        correct = True
    elif word in NOUNS:
        previous = "noun"
        correct = True
    elif word in ADJECTIVES:
        previous = "adjective"
        correct = True
    return correct, previous

def check_if_adjective(word, previous):
    """
    Check if the word is an adjective
    """
    if word in ADJECTIVES:
        return True, "adjective"
    return False, previous

def check_if_noun(word, previous):
    """
    Check if the word is an noun
    """
    if word in NOUNS:
        return True, "noun"
    return False, previous

def check_if_verb(word, previous):
    """
    Check if the word is an verb
    """
    if word in VERBS:
        return True, "verb"
    return False, previous

def check_if_adverb(word, previous):
    """
    Check if the word is an adverb
    """
    if word in ABVERBS:
        return True, "adverb"
    return False, previous

def sentence(words):
    """
    Takes a string sentence and checks if it is valid
    """
    single_words = words.split()
    correct = True
    complete_sentence = False
    i = 0
    previous = ""
    while i < len(single_words) and correct:
        if previous == "":
            #start of sentence -> article, adjective, noun
            correct, previous = check_start(single_words[i], previous)
        elif previous == "article" or previous == "adjective":
            #article or adjective -> adjective or noun
            correct, previous = check_if_adjective(single_words[i], previous)
            if correct is False:
                correct, previous = check_if_noun(single_words[i], previous)
        elif previous == "noun":
            #noun -> verb
            correct, previous = check_if_verb(single_words[i], previous)
            if correct:
                #sentence must have verb to be legal
                complete_sentence = True
        elif previous == "verb":
            #verb -> adverb or end of sentence
            correct, previous = check_if_adverb(single_words[i], previous)
            if not correct:
                #if word after the verb is not valid, illegal sentence
                complete_sentence = False
        else:
            complete_sentence = False
        i += 1
    return complete_sentence

def main():
    """
    goodOnes = ["the sun shines", "the big yellow sun shines", "children shines"]
    badOnes = ["the shines"]
    """
    test_sentence = "the sun shines"
    print(test_sentence)
    if sentence(test_sentence):
        print('legal')
    else:
        print('illegal')
if __name__ == "__main__":
    main()
