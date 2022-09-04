from ngrams import compute_ngram_frequency
from ngrams import write_ngram_dict
from ngrams import ngram_dict_to_string
from ngrams import read_ngram_dict
import os

# 6. Build an n-gram dictionary from text in a file
def build_language_model(language_filename, n, dict_filename=''):
    if os.path.isfile(language_filename) == False: #checks if the file exists
        return None
    try: #if the file isn't a text file the function gets an error and therefor "skips" to the 'exept' line
        file = open(language_filename, 'r')  # open the file for reading
        st = file.read()  # takes the content of the file and add it to a variable
        file.close()
        dic = compute_ngram_frequency(st,n) #built the ngram for the text
        if dict_filename !='': #if the user put a file' the function will add the dictionary to it.
            write_ngram_dict(dic,dict_filename)
        return dic
    except:
        return None

# 7. Compute distance between two dictionaries
def compute_ngram_distance(dict1, dict2):
    total = 0
    for key in dict1: #pass on all of the keys in the first dictionary
        if key in dict2: #if the second dictionary also has this key it calculates the distance between the values.
            total += (float((dict1[key]) - float(dict2[key]))**2)
        else:
            total += float(dict1[key]**2)
    for key2 in dict2:
        if key2 not in dict1: #to check the keys were in the second dictionary but not in the first one
            total += float(dict2[key2]**2)
    return total

#returns the keys of a dictionary
def get_keys(d):
    a=[]
    for key in d:
        a.append(key) #add the key to the list
    return a

def reduce_ngram(d, n):
    allkeys = get_keys(d) #to get only the keys of the dictionary
    if len(allkeys[0]) < n: #if the 'n' of the exicted ngram is lower then the one we are checking
        print("Error! Current ngram size smaller than ["+ str(n)+ "]") #it prints an error massage
        return False
    newdic = {} #makes an empty dictionary to contain the new ngram
    for key in allkeys:
        check = key[:n] #checks for the beginning of the exicting ngram (until 'n' size)
        if check in newdic: #add the value of the ngram to the dictionary of the new size.
            newdic[check] += d[key]
        else:
            newdic[check] = d[key]
    return newdic

# 9. Build a language classifier
def classify_language(text_to_classify, list_of_dict_files):
    all_di=[]
    for dict in list_of_dict_files: #read the dictionarys and add it to a list
        all_di.append(read_ngram_dict(dict))
    keys = []
    for di in all_di: #get the keys of the dictionary and add it to a new list
        keys.append(get_keys(di))
    short_n = len(keys[0])
    for onekey in keys: #pass on all of the keys and gets the smallest "n"
        if len(onekey)< short_n:
            short_n = len(onekey)
    for i in range(len(all_di)): #sets all of the ngrams to ngram in the same key length
        if len(keys[i][0])> short_n:
            all_di[i] = reduce_ngram(all_di[i],short_n)
    text_ngram = build_language_model(text_to_classify,short_n) #makes the ngram of the text wer'e checking
    distance = []
    for d in range(len(all_di)):
        distance.append(compute_ngram_distance(all_di[d],text_ngram)) #checks the distance between all of the ngram to the text's ngram
    smallest= min(distance) #checks which ngram has the smallest distanse
    for index in range(len(distance)):
        if distance[index] == smallest:
            return index #returns the indext of the closest dictionary to the text dictionary







######################## Helper Functions ########################


