INPUT = "Day 4\\input.txt"
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

First=True
Last=False
run=True

for Number in callednums:
    if run:
        i=0
        cards=True
        while cards:
        #for Card in Cards:
            Card=Cards[i]
            Bingo=Card.numCalled(Number)
            if Bingo:
                if First:
                    uncalled=Card.sumUncalled()
                    number=Number
                    First=False
                    print("The answer to part 1 is " + str(uncalled*number))
                if Last:
                    uncalled=Card.sumUncalled()
                    number=Number
                    run=False
                    break
                Cards.remove(Card)
                i=i-2
                if len(Cards)==1:
                    Last=True
            i=i+1
            if i==len(Cards):
                cards=False
    else:
        break
print("The answer to part 2 is " + str(uncalled*number))
            
        
