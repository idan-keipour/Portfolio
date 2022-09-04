# the function gets a number and a degree unit (fahrenheit or celsius) and transfer the number the the unit asked.
def convert_degree(num,unit):
    if ((is_number(num)) == (10<1)):
        return None
    else:
        num = float(num)
        if (unit == 'F') and (num > (-273.15)):
            return (num * 9/5 +32)
        elif (unit == 'C') and (num > (-459.67)):
            return ((num-32) / (9/5))
        else:
            return None
#the function gets a value and returning if he is a number or not.
def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False
#The function gets an ask to convert degree in natural language and does the calculation.
def natural_language_convert_degree(sentence):
    a = sentence.split(" ")
    number = (a[3])
    if ((is_number(number)) == (10<1)):
        return None
    else:
        number = float(a[3])
        if ((a[2]) == 'fahrenheit'):
            degree = 'F'
            if(number<(-273.15)):
                return None
        else:
            degree = 'C'
            if(number<(-459.67)):
                return None
    transfer = convert_degree(number,degree)
    return (number,transfer)
#The function gets an input from the user and convert the number of unit to the degree asked by the user.
def user_input_convert_degree():
    num= float(input("Please enter degrees: "))
    degree= input("Convert to (C)elsius, or (F)ahrenheit: ")
    transfer = convert_degree(num, degree)
    if(num==int(num)):
        num=int(num)
    if (degree == 'F'):
        print(num , "in Celsius is" , transfer , "in Fahrenheit")
    else:
        print(num, "in Fahrenheit is", transfer , "in Celsius")
#The function gets few inputs of temperature from the user (according to his ask) and printing the State of matter of them
def state_of_matter():
    temp=int(input("Please enter a number of temperatures (1-3): "))
    if (temp>3 or temp<1):
        print("The number you entered is not between 1 and 3, goodbye!")
    elif(temp==3):
        num1=float(input("Please enter the temperatures, one in each line"))
        num2=float(input())
        num3=float(input())
        print("")
        if(num1>100):
            print("Gas")
        elif(num1<100 and num1>0):
            print("Liquid")
        else:
            print("Solid")
        if (num2 > 100):
            print("Gas")
        elif (num2 < 100 and num2 > 0):
            print("Liquid")
        else:
            print("Solid")
        if(num3>100):
            print("Gas")
        elif(num3<100 and num3>0):
            print("Liquid")
        else:
            print("Solid")
    elif(temp==2):
        num1 = float(input("Please enter the temperatures, one in each line"))
        num2 = float(input())
        print("")
        if (num1 > 100):
            print("Gas")
        elif (num1 < 100 and num1 > 0):
            print("Liquid")
        else:
            print("Solid")
        if (num2 > 100):
            print("Gas")
        elif (num2 < 100 and num2 > 0):
            print("Liquid")
        else:
            print("Solid")
    elif(temp==1):
        num1 = float(input("Please enter the temperatures, one in each line"))
        print("")
        if (num1 > 100):
            print("Gas")
        elif (num1 < 100 and num1 > 0):
            print("Liquid")
        else:
            print("Solid")

