NAG A RAM
=========

Generate single-word anagrams for exciting wordplay fun! I needed a way to play with ruby, so why not anagrams?

Because the number of permutations of a word is based on a factorial, the runtime increases _incredibly_ with larger inputs. 

Usage
----

```
ruby anagram.rb [options] [word]
```

Where word is what you want to anagram (if provided - you will be prompted if it isn't provided on the command line.

The anagrams are checked against a dictionary. By default, the program looks first in /usr/share/dict/words, which is the location in OS X. If that doesn't exist, it checks for /usr/dict/words. You can provide your own dictionary file with ```ruby anagram.rb -d DICTSRC``` where DICTSRC is the source of the file you want to use. 
