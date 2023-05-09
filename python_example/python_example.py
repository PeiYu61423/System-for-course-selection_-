#!/usr/bin/env python3
# coding=utf-8
# -*- coding: UTF-8 -*-
from flask import Flask, request, redirect, render_template, session, flash
import MySQLdb

app = Flask(__name__)
app.config['SECRET_KEY'] = b'(\xf1v\xd5\xae\xbf\xbbk\x19\xb6\x80\xdb_W\x93\x0f'

# 根據 sql(sql 指令) 到資料庫搜尋資料
def Query(sql, commit=False):
    conn = MySQLdb.connect(host="127.0.0.1",
                           user="hj",
                           passwd="test1234",
                           db="testdb")

    cursor = conn.cursor()
    cursor.execute(sql)

    if commit:
        conn.commit()

    return cursor.fetchall()

def getLogin():
    user = False
    if 'login' in session:
        if session['login']:
            user = session['login']
    return user

# 首頁
@app.route('/')
def index():
    #如果 session 中不存在 "login" 或是空的代表還沒登入
    if 'login' in session:
        if session['login']:
            return redirect('/login')

    return render_template('index.html')

# 根據輸入的 student_id 到資料庫搜尋資料
@app.route('/login', methods=['GET', 'POST'])
def login():
    student_id = getLogin()

    if request.form.get("student_id"):
        student_id = request.form.get("student_id")

    # 根據 student_id 搜尋學生資料
    data = Query(
        f'SELECT * FROM `students` WHERE `s_id` = "{student_id}"'
    )

    # 如果搜尋出來有資料代表資料存在資料庫裡
    if data:
        # 將 student_id 設定到 session 裡保持登入狀態
        session['login'] = student_id

        # 學生資料
        student = {
            's_id': data[0][0],
            's_name': data[0][1],
            's_class': data[0][2]
        }

        # 根據 s_id 搜尋學生目前所選課程
        data = Query(
            f'SELECT `course_id`, `title`, `department`, `dept_class`, `dept_grade`, `type`, `credit` FROM `stu_cou` WHERE `s_id` = "{student_id}"'
        )

        student_credit = 0
        student_course = {}
        selected_course_id = []

        if data:
            # 已選課程資料
            for i in range(len(data)):
                selected_course_id.append(data[i][0])

                student_course[i] = {
                    'course_id': data[i][0],
                    'course_title': data[i][1],
                    'course_department': data[i][2],
                    'course_dept_class': data[i][3],
                    'course_dept_grade': data[i][4],
                    'course_type': '必修' if 'required' == data[i][5] else '選修',
                    'course_credit': data[i][6],
                    'course_drop': False if 'required' == data[i][5] else True
                }

                # 加總已選課程學分
                student_credit += data[i][6]

            student['s_credit'] = student_credit

        # 查詢所有課程時段
        data = Query(
            f'SELECT `course_id`, `day`, `class_number` FROM `cou_time` LEFT JOIN `time_slot` ON `cou_time`.`time_id` = `time_slot`.`time_id`;'
        )

        student_course_time = {}
        course_time = {}

        # 記錄每個課程上課時段
        if data:
            for i in range(len(data)):
                if data[i][0] not in course_time:
                    course_time[data[i][0]] = []

                if data[i][1] not in student_course_time:
                    student_course_time[data[i][1]] = []

                course_time[data[i][0]].append(f'({data[i][1]}){data[i][2]}')
                student_course_time[data[i][1]].append(data[i][2])

        # 查詢所有課程
        data = Query(
            f'SELECT * FROM `course`'
        )

        courses = {}

        if data:
            for i in range(len(data)):
                courses[i] = {
                    'course_id': data[i][0],
                    'course_title': data[i][1],
                    'course_dept_name': data[i][2],
                    'course_dept_class': data[i][3],
                    'course_dept_grade': data[i][4],
                    'course_type': '必修' if 'required' == data[i][5] else '選修',
                    'course_num_people': data[i][6],
                    'course_max_people': data[i][7],
                    'course_credit': data[i][8],
                    'course_time_slot': ' '.join(course_time[data[i][0]]),
                    'course_select': data[i][0] not in selected_course_id
                }

        return render_template('selected_courses.html', student=student, student_course=student_course, courses=courses)
    else:
        flash('帳號不存在!')
    
        return render_template('index.html', action='/')

# 加選課程
@app.route('/select', methods=['POST'])
def select():
    student_id = getLogin()
    select_course_id = request.form.get("select_course_id")

    if student_id and select_course_id:
        # 查看目前總學分
        data = Query(
            f'SELECT SUM(`credit`) FROM `stu_cou` WHERE `s_id` = "{student_id}"'
        )

        current_credit = int(data[0][0])

        # 查詢要加選課程學分
        data = Query(
            f'SELECT `title`, `credit`, `num_people`, `max_people` FROM `course` WHERE `course_id` = "{select_course_id}"'
        )

        check_people = False
        check_credit = False
        check_same_course = False
        check_time_slot = False
        course_name = data[0][0]
        course_credit = int(data[0][1])
        course_num_people = int(data[0][2])
        course_max_people = int(data[0][3])

        # 檢查課程人數是否有超過上限
        if course_max_people > course_num_people:
            check_people = True
        else:
            flash('無法加選, 課程人數已滿!')
            return redirect('/login')

        # 檢查加選後學分是否小於等於30
        if 30 >= (current_credit + course_credit):
            check_credit = True
        else:
            flash('無法加選, 不可超過30學分!')
            return redirect('/login')

        # 查詢是否有同名課程
        data = Query(
            f'SELECT `title` FROM `stu_cou` WHERE `title` = "{course_name}" AND `s_id` = "{student_id}"'
        )

        if not data:
            check_same_course = True
        else:
            flash('無法加選, 已有相同課程!')
            return redirect('/login')

        # 查詢是否有相同上課時間
        data = Query(
            f'SELECT COUNT(*) FROM `cou_time` WHERE `cou_time`.`course_id` = "{select_course_id}" OR `course_id` IN (SELECT `stu_cou`.`course_id` FROM `stu_cou` WHERE `s_id` = "{student_id}") GROUP BY `time_id` HAVING COUNT(*) > 1'
        )

        if not data:
            check_time_slot = True
        else:
            flash('無法加選, 課程與其他課程衝堂')
            return redirect('/login')
        
        # 上面條件檢查完畢確定後進行加選, 加選成功人數 + 1
        if check_people and check_credit and check_same_course and check_time_slot:
            Query(
                f'INSERT INTO `stu_cou` (`s_id`, `course_id`, `title`, `department`, `dept_class`, `dept_grade`, `type`, `credit`) SELECT "{student_id}", `course_id`, `title`, `dept_name`, `dept_class`, `dept_grade`, `type`, `credit` FROM `course` WHERE `course_id` = "{select_course_id}"',
                True
            )

            Query(
                f'UPDATE `course` SET `num_people` = `num_people` + 1 WHERE `course_id` = "{select_course_id}"',
                True
            )

            flash('加選成功')

        return redirect('/login')
    else:
        flash('尚未登入!')
    
        return render_template('index.html', action='/')

# 退選課程
@app.route('/drop', methods=['POST'])
def drop():
    student_id = getLogin()
    drop_course_id = request.form.get("drop_course_id")

    if student_id and drop_course_id:
        # 查看目前總學分
        data = Query(
            f'SELECT SUM(`credit`) FROM `stu_cou` WHERE `s_id` = "{student_id}"'
        )

        current_credit = int(data[0][0])

        # 查詢要退選課程學分
        data = Query(
            f'SELECT `credit` FROM `stu_cou` WHERE `s_id` = "{student_id}" AND `course_id` = "{drop_course_id}"'
        )

        course_credit = int(data[0][0])

        # 檢測退選後學分是否大於等於9, 退選成功人數 - 1
        if 9 <= (current_credit - course_credit):
            Query(
                f'DELETE FROM `stu_cou` WHERE `s_id` = "{student_id}" AND `course_id` = "{drop_course_id}"',
                True
            )

            Query(
                f'UPDATE `course` SET `num_people` = `num_people` - 1 WHERE `course_id` = "{drop_course_id}"',
                True
            )

            flash('已退選')
        else:
            flash('無法退選, 不可少於9學分!')
        return redirect('/login')
    else:
        flash('尚未登入!')
    
        return render_template('index.html', action='/')

# 登出
@app.route('/logout', methods=['GET', 'POST'])
def logout():
    session['login'] = False

    return render_template('index.html', action='/')
