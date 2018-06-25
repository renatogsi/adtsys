import math
def ftruncate(f, ndigits=None):
     if ndigits and (ndigits > 0):
         multiplier = 10 ** ndigits
         num = math.floor(f * multiplier) / multiplier
     else:
         num = math.floor(f)
     return num
