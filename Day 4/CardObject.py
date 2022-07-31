Debug=False

class Card:
    def __init__(self,size):
        self.size=size
        self.card = [[None for _ in range(size)] for _ in range(size)]
        self.called = [[0 for _ in range(size)] for _ in range(size)]
        self.i=0

    def declareLine(self,nums):
        self.card[self.i]=nums
        self.i=self.i+1

    def checkBingo(self):
        for row in self.called:
            if row==[1 for _ in range(self.size)]:
                if Debug:
                    print("printing row")
                    print(row)
                return True
        for col in range(0,self.size):
            if Debug:
                print("printing column")
                print([i[col] for i in self.called])
                print([i[col] for i in self.card])
            if [i[col] for i in self.called]==[1 for _ in range(self.size)]:
                return True
        return False

    def numCalled(self,number):
        found=False
        for row in range(0,self.size):
            for col in range(0,self.size):
                if number==self.card[row][col]:
                    self.called[row][col]=1
                    found=True
        if found:
            return self.checkBingo()
    
    def sumUncalled(self):
        sum=0
        for row in range(0,self.size):
            for col in range(0,self.size):
                if not self.called[row][col]:
                    sum=sum+self.card[row][col]
        return sum




