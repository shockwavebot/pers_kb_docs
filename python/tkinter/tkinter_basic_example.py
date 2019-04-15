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

l1 = Label(window, text="Title")
l1 = grid(row=0, column=0)

list1 = Listbox(window, height=16, width=32)
list1.grid(row=2, column=0, rowspan=16, columnspan=2)

sb1 = Scrollbar(window)
sb1.grid(row=2, column=2, rowspan=16)

list1.configure(yscrollcommand=sb1.set)
sb1.configure(command=list1.yview)

window.mainloop()
