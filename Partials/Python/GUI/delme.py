import multiprocessing as mp
import math
import time
results_a = []
results_b = []
results_c = []




def make_calculation_one(numbers):
        for number in numbers:
            results_a.append(math.sqrt(number ** 3))


def make_calculation_two(numbers):
        for number in numbers:
            results_b.append(math.sqrt(number ** 4))


def make_calculation_three(numbers):
        for number in numbers:
            results_c.append(math.sqrt(number ** 5))


if __name__ == '_main__':


    number_list = list(range(5000000))

    start = time.time()
    make_calculation_one(number_list)
    make_calculation_two(number_list)
    make_calculation_three(number_list)
    end = time.time()

    print (end-start)
    print ("done")