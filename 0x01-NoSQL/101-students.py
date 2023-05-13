#!/usr/bin/env python3.8
'''
File: 101-students.py
'''

def top_students(mongo_collection):
    '''
    function that returns all students sorted by average score
    '''
    students = list_all(mongo_collection)
    for student in students:
        total_score = 0
        for topic in student['topics']:
            total_score += topic['score']
        student['averageScore'] = round(total_score / len(student['topics']), 2)
    return sorted(students, key=lambda x: x['averageScore'], reverse=True)
