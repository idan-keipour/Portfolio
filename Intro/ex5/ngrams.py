import string
import re

# 1. Compute ngram statistics for text
def compute_ngram_frequency(text, n):
    newtext= text.lower() #to make the whole text with lower letters
    newtext = re.sub('[^A-Za-z]+', " ", newtext) #to remove anything but the 'abc' from the text
    txt= newtext.split(" ") #to separate the words in the text
    dict1 = {}
    for word in txt: #for every word in the text
        while len(word)>= n: #if the word (or the rest of it) is bigger then the length of the combination we want to check
            check = word[:n]  #cheks how many times the comination appears in the word
            if check in dict1:
                dict1[check] +=1
            else:
                dict1[check] = 1
            word = word[1:]
    s = sum(dict1.values())
    for key in dict1:
        dict1[key] = dict1[key]/ s #calculates what is the frequency of every combination compared to the rest of the text.
    return dict1

# 2. Concatenate items of dictionary to one string
def ngram_dict_to_string(d):
    st= '' #makes a new empty string
    for key in d:
        st += key+ ":" + str(d[key]) + " " #pass on all of the dictionary and add it to the string
    return st

# 3. split string to dictionary
def string_to_ngram_dict(s):
    dic={} #makes a new dictionary
    st = s.split(" ") #separates the values in the string
    for i in st:
        if ":" not in i:
            return dic
        ls = i.split(":") #separates the string to the strings and values
        dic[ls[0]] = float(ls[1]) #add it to the empty dictionary
    return dic #returns the new dictionary

# 4. Save to file
def write_ngram_dict(dict, filename):
    st= ngram_dict_to_string(dict) #use the second function to convert the dictionary to string
    file = open(filename, 'w') #open the file for writing
    file.write(st) #add the string to the file
    file.close()
    return #returns nothing (but changes the file)

# 5. Load from file
def read_ngram_dict(filename):
    file = open(filename, 'r') #open the file for reading
    st = file.read() #takes the content of the file and add it to a variable
    file.close()
    dic = string_to_ngram_dict(st) #use the third function to convert the string to dictionary
    return dic
