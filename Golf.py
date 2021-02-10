#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Oct  8 10:13:01 2020

@author: ramaal-enzy
"""
#importing functions
import math

import matplotlib.pyplot as plt

import xlsxwriter


#constant values
rho = 1.225 #kg/m^3
grav =9.81 #m/s^2
mass = 0.042672 #kg
diameter = 0.042672 #m
Area = (math.pi*diameter**2)/4 #m^2
Cd = 0.2
Cl = 0.2
dt = 0.05

#creating the arraylist for each axis and it is outside the modules because it will be used in each module
x_array = []
y_array = []
z_array = []




def drag(v0, theta):
    
    
    #convert string into float and convert angle into radians
    theta = float(theta)
    theta = (math.pi*theta)/180
    v0 = float(v0)
    
    #break the speed into its respective components
    vx = v0*math.cos(theta)
    vy = v0*math.sin(theta)
    
    #define the distance intial values along with the range of the for loop
    x=0
    y=0
    
    #If y equals and is greater then 0 the loop will go
    while y >= 0:
        
        #the vx, vy, vz change every single time the loop occurs
        speed = math.sqrt(vx**2 +vy**2)
        Q = rho*speed**2*Area/2
        
        #finding the velocity with a 0.01 change in time (in seconds)
        vx +=  (-Q*Cd*vx/speed)*dt/mass 
        vy += (-Q*Cd*vy/speed)*dt/mass - grav*dt
    
        #finding the x,y,z distances with a change of time as 0.01 and then assigns the values to the distance based on the axis 
        x += vx*dt
        y += vy*dt
        
        
        #once y is less then zero the loop will stop
        if (y < 0):
            break
        
        #print(vx,vy, x, y)
        
        #adding the x,y,z into an array so it can be plotted
        x_array.append(x)
        y_array.append(y)
        
    

        
    #plotting the values in a 3D plot, this is done outside the loop
    
    fig = plt.figure()
    
    #creating the 3D plot
    ax = fig.add_subplot(111, projection='3d')
    
    
    ax.plot(x_array, z_array,y_array, 'gray')
    
    ax.set_title("Golf Ball Motion with Gravity, Drag and Lift, 3D Model")
    ax.set_xlabel('x')
    ax.set_ylabel('z')
    ax.set_zlabel('y')
    
    plt.show()
    
    

    

def lift(v0, theta, wx, wy, wz, phi):
    
    #convert string into float and convert angle into radians
    theta = float(theta)
    theta = (math.pi*theta)/180
    phi = float(phi)
    phi = (math.pi*phi)/180
    v0 = float(v0)
    wx = float(wx)
    wy = float(wy)
    wz = float(wz)
    
    # the if statement is to make sure that we are not dividing by zero
    omega = math.sqrt(wx**2 +wy**2 +wz**2)
    if omega != 0:
        tx = wx/omega
        ty = wy/omega
        tz = wz/omega
    else:
        tx =0
        ty =0
        tz =0
        
    #break the speed into its respective components
    vx = v0*math.cos(theta)*math.cos(phi)
    vy = v0*math.sin(theta)
    vz = -(v0*math.cos(theta)*math.sin(phi))
    
    #define what x,y,z are
    x=0
    y=0
    z=0
    
    #same as the drag moduel but with only lift
    while y >= 0:
        speed = math.sqrt(vx**2 +vy**2 +vz**2)
        Q = rho*speed**2*Area/2
        vx +=  (Q*Cl*(ty*vz-tz*vy)/speed)*dt/mass 
        vy += (Q*Cl*(tz*vx-tx*vz)/speed)*dt/mass - grav*dt
        vz += (Q*Cl*(tx*vy-ty*vx)/speed)*dt/mass
        
        
        x += vx*dt
        y += vy*dt
        z += vz*dt
        
        x_array.append(x)
        y_array.append(y)
        z_array.append(z)
        
        if (y < 0):
            break
        
        
    fig = plt.figure()
    
    ax = fig.add_subplot(111, projection='3d')
    
    
    ax.plot(x_array, z_array,y_array, 'gray')
    ax.set_title("Golf Ball Motion with Gravity, Drag and Lift, 3D Model")
    ax.set_xlabel('x')
    ax.set_ylabel('z')
    ax.set_zlabel('y')
    
    plt.show()

    
def both(v0, theta, wx, wy, wz, phi):
    
    #convert string into float and convert angle into radians
    theta = float(theta)
    theta = (math.pi*theta)/180
    phi = float(phi)
    phi = (math.pi*phi)/180
    v0 = float(v0)
    wx = float(wx)
    wy = float(wy)
    wz = float(wz)
    
    omega = math.sqrt(wx**2 +wy**2 +wz**2)
    if omega != 0:
        tx = wx/omega
        ty = wy/omega
        tz = wz/omega
    else:
        tx =0
        ty =0
        tz =0
    
    #break the speed into its respective components
    vx = v0*math.cos(theta)*math.cos(phi)
    vy = v0*math.sin(theta)
    vz = -(v0*math.cos(theta)*math.sin(phi))
    
    
    x=0
    y=0
    z=0
    
    while y >= 0:
        speed = math.sqrt(vx**2 +vy**2 +vz**2)
        Q = rho*speed**2*Area/2
        vx +=  (-Q*Cd*vx/speed+ Q*Cl*(ty*vz-tz*vy)/speed)*dt/mass 
        vy += (-Q*Cd*vy/speed+ Q*Cl*(tz*vx-tx*vz)/speed)*dt/mass - grav*dt
        vz += (-Q*Cd*vz/speed + Q*Cl*(tx*vy-ty*vx)/speed)*dt/mass
        
        
        x += vx*dt
        y += vy*dt
        z += vz*dt
        
        if (y < 0):
            break
        
        x_array.append([x])
        y_array.append([y])
        z_array.append([z])
        
    '''    
    fig = plt.figure()
    
    ax = fig.add_subplot(111, projection='3d')
    
    
    ax.plot(x_array, z_array, y_array, 'gray')
    ax.set_title("Golf Ball Motion with Gravity, Drag and Lift, 3D Model")
    ax.set_xlabel('x')
    ax.set_ylabel('z')
    ax.set_zlabel('y')
    plot.show()
    '''
    workbook = xlsxwriter.Workbook('LiDAR.xlsx')
    worksheet = workbook.add_worksheet()

    for x in range(len(x_array)):
        worksheet.write_column(x, 0, x_array[x])
    
    for y in range(len(y_array)):
        worksheet.write_column(y, 1, y_array[y])

    for z in range(len(z_array)):
        worksheet.write_column(z, 2, z_array[z])

    workbook.close()

    

    

def gravity(v0, theta):
    
    #convert string into float and convert angle into radians
    theta = float(theta)
    theta = (math.pi*theta)/180
    v0 = float(v0)
    
    #break the speed into its respective components
    vx = v0*math.cos(theta)
    vy = v0*math.sin(theta)

    x=0
    y=0

    while y >= 0:
        vx = v0*math.cos(theta)
        vy +=  - grav*dt
        
        x += vx*dt
        y += vy*dt

        if (y < 0):
            break
        
        x_array.append([x])
        y_array.append([y])

        
    plt.plot(x_array, y_array)
    plt.xlabel('x')
    plt.ylabel('y')
    plt.title('Gravity Only')

    workbook = xlsxwriter.Workbook('LiDAR.xlsx')
    worksheet = workbook.add_worksheet()

    for x in range(len(x_array)):
        worksheet.write_column(x, 0, x_array[x])
    
    for y in range(len(y_array)):
        worksheet.write_column(y, 1, y_array[y])

    workbook.close()

#takes the users input     
if __name__ == "__main__":
    #asks the user what they want
    question = input("For the golf ball, does it have Lift or Drag or Both or just Gravity?: ")
    
     #if they put drag in then it asks them for the intial velocity and launch angle, if you have a better way of checking that they choose feel free to change it
    if(question == "Drag" or question =="drag"):
        
        v0 = input("What is the inital velocity in m/s: ")
        theta = input("What is the angle of the velocity in degrees: ") 
        
        #checking to make sure that string contains numbers, if it does then it goes to the drag module
        if (v0.isnumeric() and theta.isnumeric()):
            drag(v0, theta)
        #if they did not put a number then it will tell them that it was invalid
        else:
            print("Invalid Input")
            
    #if they did not choose drag then it checks if they choose lift   
    elif(question == "Lift" or question =="lift"):
        
        #inputing values
        v0 = input("What is the inital velocity in m/s: ")
        theta = input("What is the angle of the velocity in degrees: ")
        wx = input("What is the rifle spin in rads/sec?:")
        wy = input("What is the side spin in rads/sec?:")
        wz = input("What is the back spin in rads/sec?:")
        phi = input("What is the spin angle in degrees?: ")
        
        #checking to make sure that string contains numbers
        if (v0.isnumeric() and theta.isnumeric() and wx.isnumeric() and wy.isnumeric() and wx.isnumeric() and phi.isnumeric()):
            lift(v0, theta, wx, wy, wz, phi)
        else:
            print("Invalid Input")
        
      #cheick if it was both    
    elif(question == "Both" or question =="both"):
       
        #inputing values
        v0 = input("What is the inital velocity in m/s: ")
        theta = input("What is the angle of the velocity in degrees: ")
        wx = input("What is the rifle spin in rads/sec?:")
        wy = input("What is the side spin in rads/sec?:")
        wz =input("What is the back spin in rads/sec?:")
        phi = input("What is the spin angle in degrees?: ")
        
        #checking to make sure that string contains numbers
        if (v0.isnumeric() and theta.isnumeric() and wx.isnumeric() and wy.isnumeric() and wx.isnumeric() and phi.isnumeric()):
            both(v0, theta, wx, wy, wz, phi)
        else:
            print("Invalid Input")
    
     #checks if they inputted gravity
    elif(question == "Gravity"or question =="gravity" or question =="just gravity" or question =="Just Gravity"):
        
        #inputing values
        v0 = input("What is the inital velocity in m/s: ")
        theta = input("What is the angle of the velocity in degrees: ")
        
        #checking to make sure that string contains numbers
        if (v0.isnumeric() and theta.isnumeric()):
            gravity(v0, theta)
        else:
            print("Invalid Input")
    
     #if they do not chose graivyt, lift, both, drag then it lets them know that their input is invalid   
    else:
        print("Invalid input")
    