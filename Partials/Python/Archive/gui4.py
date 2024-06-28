import tkinter as tk
my_w = tk.Tk() # parent window 
width,height=300,200
v_dim=str(width)+'x'+str(height)
my_w.geometry(v_dim)  # Size of the window 
#my_w.minsize(280, 180) # (minimum ) Width  , ( minimum ) height
#my_w.maxsize(320,220)  # (maximum ) width , ( maximum) height
my_w.title("www.plus2net.com")  # Adding a title

def my_resize(condition):
    global width , height 
    if(condition=='increase'):
        width=width+10
        height=height+10
    elif(condition=='decrease'):
        width=width-10
        height=height-10
    
    d=str(width)+"x"+str(height) 
    my_w.geometry(d) # update the new width and height
    
b1=tk.Button(my_w,text='zoom ++ ',command=lambda:my_resize('increase'))
b1.grid(row=0,column=0,padx=10,pady=10)    
b2=tk.Button(my_w,text='zoom -- ',command=lambda:my_resize('decrease'))
b2.grid(row=0,column=1,padx=10,pady=10)  
b3=tk.Button(my_w,text='Full Screen',command=lambda:my_w.state('zoomed'))
b3.grid(row=0,column=2,padx=10,pady=10)   

my_w.mainloop()  # Keep the window open