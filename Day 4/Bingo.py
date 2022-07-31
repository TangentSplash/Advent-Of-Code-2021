INPUT = "C:\\Users\\ciara\\Documents\\Python\\AdventOfCode\\2021\\Day 4\\input.txt"
import math
import CardObject
Card=CardObject.Card

Debug=True

Fileinput= open(INPUT,"r")
Input=Fileinput.readlines()
callednums=Input[0].split(",")
callednums=list(map(int, callednums))
Input.remove(Input[0])

card=-1
Cards=[]
newcard=True
for line in Input:
    if line=='\n':
        card=card+1
        newcard=True
    else:
        line=line[:-1]
        nums=line.split(" ")
        nums=list(filter(('').__ne__, nums))
        nums=list(map(int, nums))

        if newcard:
            newcard=False
            size=len(nums)
            Cards.append(Card(size))
        Cards[card].declareLine(nums)

run=True
for Number in callednums:
    if run:
        for Card in Cards:
            Bingo=Card.numCalled(Number)
            if Bingo:
                uncalled=Card.sumUncalled()
                number=Number
                run=False
                break
    else:
        break
        
print("The answer is " + str(uncalled*number))