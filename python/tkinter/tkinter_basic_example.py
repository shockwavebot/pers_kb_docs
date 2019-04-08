from tkinter import *

window = Tk()

def func_example():
    t1.insert(END, int(e1_value.get())*10 + 3)

b1 = Button(window, text='Execute', command=func_example)
b1.grid(row=0, column=0) # b1.pack()

e1_value = StringVar()
e1 = Entry(window, textvariable=e1_value)
e1.grid(row=0, column=1)

t1 = Text(window, height=1, width=15)
t1.grid(row=0, column=2)

window.mainloop()
