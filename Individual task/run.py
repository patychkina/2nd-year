import datetime

import web3
from PyQt5 import QtCore, QtWidgets, QtGui
import sys
import time

from Go import Ui_MainWindow
from API import API
from Admin import Ui_MainWindow as Ui_Admin
from Client import Ui_MainWindow as Ui_Client
from Master import Ui_MainWindow as Ui_Master

class Go(QtWidgets.QMainWindow):
    def __init__(self, parent=None):
        QtWidgets.QMainWindow.__init__(self, None)
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)
        self.ui.pushButton.clicked.connect(self.check_user)
        self.Warn = QtWidgets.QErrorMessage()
        self.ui.lineEdit.setMaxLength(42)
    def check_user(self):
        self.current_user = self.ui.lineEdit.text()
        password = str(self.ui.lineEdit_2.text())
        self.api = API(self.current_user)
        if self.api.check_password(self.current_user, password) == True:
            if self.api.owner() == self.current_user:
                self.Warn.setWindowTitle("Успешно")
                self.Warn.showMessage("Верный пароль!")
                self.open = Admin(current_user=self.current_user)
                self.open.show()
            elif self.api.is_client(self.current_user) == True:
                self.Warn.setWindowTitle("Успешно")
                self.Warn.showMessage("Добро пожаловать!")
                self.open = Client(current_user=self.current_user)
                self.open.show()
            elif self.api.is_master(self.current_user) == True:
                self.Warn.setWindowTitle("Успешно")
                self.Warn.showMessage("Добро пожаловать!")
                self.open = Master(current_user=self.current_user)
                self.open.show()
            else:
                self.Warn.setWindowTitle("Ошибка")
                self.Warn.showMessage("Вы не зарегистрированы!")
        else:
            self.Warn.setWindowTitle("Ошибка")
            self.Warn.showMessage("Неверный пароль или аккаунт не существует!")


class Admin(QtWidgets.QMainWindow):
    def __init__(self, current_user, parent=None):
        QtWidgets.QMainWindow.__init__(self, parent)
        self.Warn = QtWidgets.QErrorMessage()
        self.ui = Ui_Admin()
        self.ui.setupUi(self)
        self.ui.lineEdit_4.setInputMask("999999999999999999")
        self.ui.lineEdit_5.setInputMask("999999999999999999")
        self.ui.lineEdit_6.setInputMask("999999999999999999")
        self.ui.lineEdit_7.setInputMask("999999999999999999")
        self.ui.lineEdit.setMaxLength(42)
        self.ui.lineEdit_2.setMaxLength(42)
        self.current_user = current_user
        self.api = API(self.current_user)
        self.ui.label_5.setText(self.current_user)
        self.ui.label_3.setText(str(self.api.get_balance(self.current_user)) + " ETH")
        self.update_all()
        self.ui.pushButton_4.clicked.connect(self.change_inflation)
        self.ui.pushButton_5.clicked.connect(self.change_price)
        self.ui.pushButton_2.clicked.connect(self.add_client)
        self.ui.pushButton_3.clicked.connect(self.add_service)
        self.ui.pushButton.clicked.connect(self.add_master)
        self.ui.pushButton_6.clicked.connect(self.create_account)
        self.ui.pushButton_7.clicked.connect(self.change_time)
        timestamp = self.api.get_time()
        data = datetime.datetime.fromtimestamp(timestamp)
        self.ui.label_14.setText(str(data.day)+":"+str(data.month)+":"+str(data.year)+" "+str(data.hour)+":"+str(data.minute))
        self.timer = QtCore.QTimer()
        self.timer.timeout.connect(self.update_all)
        self.timer.start(5000)
    def update_all(self):
        timestamp = self.api.get_time()
        data = datetime.datetime.fromtimestamp(timestamp)
        self.ui.label_14.setText(
            str(data.day) + ":" + str(data.month) + ":" + str(data.year) + " " + str(data.hour) + ":" + str(
                data.minute))
        self.ui.label_3.setText(str(self.api.get_balance(self.current_user)) + " ETH")
        self.ui.label_11.setText(str(self.api.inflation()))
        masters = self.api.get_masters()
        all_masters = []
        for master in masters:
            all_masters.append(master)
        self.ui.tableWidget.setRowCount(len(all_masters))
        self.ui.tableWidget.setColumnCount(1)
        for i in range(len(all_masters)):
            self.ui.tableWidget.setItem(i, 0, QtWidgets.QTableWidgetItem(str(all_masters[i])))

        clients = self.api.get_clients()
        all_clients = []
        for client in clients:
            all_clients.append(client)
        self.ui.tableWidget_2.setRowCount(len(all_clients))
        self.ui.tableWidget_2.setColumnCount(1)
        for i in range(len(all_clients)):
            self.ui.tableWidget_2.setItem(i, 0, QtWidgets.QTableWidgetItem(str(all_clients[i])))

        services = self.api.get_service()
        all_services = []
        for service in services:
            all_services.append(service)
        self.ui.tableWidget_3.setRowCount(len(all_services))
        self.ui.tableWidget_3.setColumnCount(3)
        for i in range(len(all_services)):
            for j in range(1, 3):
                self.ui.tableWidget_3.setItem(i, j, QtWidgets.QTableWidgetItem(str(all_services[i][j-1])))
            self.ui.tableWidget_3.setItem(i, 0, QtWidgets.QTableWidgetItem(str(i)))


    def change_inflation(self):
        try:
            new_inflation = int(self.ui.lineEdit_5.text())
            self.api.change_inflation(int(new_inflation))
        except:
            self.Warn.setWindowTitle("Ошибка")
            self.Warn.showMessage("Неверный ввод!")
    def change_price(self):
        try:
            new_price = int(self.ui.lineEdit_6.text())
            number = int(self.ui.lineEdit_7.text())
            self.api.change_price(number, new_price)
        except:
            self.Warn.setWindowTitle("Ошибка")
            self.Warn.showMessage("Неверный ввод!")

    def add_client(self):
        try:
            address = self.ui.lineEdit_2.text()
            self.api.add_clients(web3.Web3.to_checksum_address(address))
        except:
            self.Warn.setWindowTitle("Ошибка")
            self.Warn.showMessage("Клиент существует!")

    def add_service(self):
        try:
            name = self.ui.lineEdit_3.text()
            price = int(self.ui.lineEdit_4.text())
            self.api.add_service(name, price)
        except:
            self.Warn.setWindowTitle("Ошибка")
            self.Warn.showMessage("Неверный ввод!")
    def add_master(self):
        try:
            address = self.ui.lineEdit.text()
            self.api.add_master(web3.Web3.to_checksum_address(address))
        except:
            self.Warn.setWindowTitle("Ошибка")
            self.Warn.showMessage("Мастер существует!")

    def create_account(self):
        password = str(self.ui.lineEdit_8.text())
        address = self.api.create_account(password)
        self.ui.label_13.setText(str(address))

    def change_time(self):
        date = self.ui.dateTimeEdit.dateTime().toPyDateTime()
        timestamp = int(time.mktime(date.timetuple()))
        self.api.change_time(timestamp)


class Client(QtWidgets.QMainWindow):
    def __init__(self, current_user, parent=None):
        QtWidgets.QMainWindow.__init__(self, parent)
        self.ui = Ui_Client()
        self.Warn = QtWidgets.QErrorMessage()
        self.ui.setupUi(self)
        self.ui.lineEdit.setMaxLength(42)
        self.ui.lineEdit_3.setInputMask("999999999999999999")
        self.ui.lineEdit_4.setInputMask("999999999999999999")
        self.ui.lineEdit_5.setInputMask("999999999999999999")
        self.ui.lineEdit_6.setInputMask("999999999999999999")
        self.current_user = current_user
        self.api = API(self.current_user)
        self.ui.label_5.setText(self.current_user)
        self.ui.label_3.setText(str(self.api.get_balance(self.current_user)) + " ETH")
        self.update_all()
        timestamp = self.api.get_time()
        data = datetime.datetime.fromtimestamp(timestamp)
        self.ui.label_11.setText(
            str(data.day) + ":" + str(data.month) + ":" + str(data.year) + " " + str(data.hour) + ":" + str(
                data.minute))
        self.timer = QtCore.QTimer()
        self.timer.timeout.connect(self.update_all)
        self.timer.start(5000)
        self.ui.pushButton_4.clicked.connect(self.register_visit)
        self.ui.pushButton_5.clicked.connect(self.cancle_visit)
        self.ui.pushButton_6.clicked.connect(self.pay_for_service)

    def update_all(self):
        timestamp = self.api.get_time()
        data = datetime.datetime.fromtimestamp(timestamp)
        self.ui.label_11.setText(
            str(data.day) + ":" + str(data.month) + ":" + str(data.year) + " " + str(data.hour) + ":" + str(
                data.minute))
        self.ui.label_3.setText(str(self.api.get_balance(self.current_user)) + " ETH")
        masters = self.api.get_masters()
        all_masters = []
        for master in masters:
            all_masters.append(master)
        self.ui.tableWidget.setRowCount(len(all_masters))
        self.ui.tableWidget.setColumnCount(1)
        for i in range(len(all_masters)):
            self.ui.tableWidget.setItem(i, 0, QtWidgets.QTableWidgetItem(str(all_masters[i])))

        services = self.api.get_service()
        all_services = []
        for service in services:
            all_services.append(service)
        self.ui.tableWidget_3.setRowCount(len(all_services))
        self.ui.tableWidget_3.setColumnCount(3)
        for i in range(len(all_services)):
            for j in range(1, 3):
                self.ui.tableWidget_3.setItem(i, j, QtWidgets.QTableWidgetItem(str(all_services[i][j - 1])))
            self.ui.tableWidget_3.setItem(i, 0, QtWidgets.QTableWidgetItem(str(i)))

        visits = self.api.get_visits()
        all_visits = []
        count = 0
        for visit in visits:
            if self.api.check_client(count, self.current_user) == True:
                all_visits.append(visit)
            count += 1
        self.ui.tableWidget_2.setRowCount(len(all_visits))
        self.ui.tableWidget_2.setColumnCount(7)
        for i in range(len(all_visits)):
            for j in range(1, 2):
                self.ui.tableWidget_2.setItem(i, j, QtWidgets.QTableWidgetItem(str(all_visits[i][j - 1])))
            self.ui.tableWidget_2.setItem(i, 0, QtWidgets.QTableWidgetItem(str(i)))
        for i in range(len(all_visits)):
            for j in range(3, 7):
                self.ui.tableWidget_2.setItem(i, j, QtWidgets.QTableWidgetItem(str(all_visits[i][j - 1])))
        for i in range (len(all_visits)):
            timestamp = all_visits[i][1]
            if timestamp == 0:
                self.ui.tableWidget_2.setItem(i, 2, QtWidgets.QTableWidgetItem(str("Отмена")))
            else:
                data = datetime.datetime.fromtimestamp(timestamp)
                self.ui.tableWidget_2.setItem(i, 2, QtWidgets.QTableWidgetItem(str(data.day)+":"+str(data.month)+":"+str(data.year)+" "+str(data.hour)+":"+str(data.minute)))

    def register_visit(self):
        try:
            master = str(self.ui.lineEdit.text())
            service = int(self.ui.lineEdit_3.text())
            date = self.ui.dateTimeEdit.dateTime().toPyDateTime()
            timestamp = int(time.mktime(date.timetuple()))
            muss = self.api.get_time()
            self.api.register_visit(master, service, timestamp)
        except:
            self.Warn.setWindowTitle("Ошибка")
            self.Warn.showMessage("Неверные данные или мастер занят")

    def cancle_visit(self):
        try:
            index = int(self.ui.lineEdit_4.text())
            self.api.cancel_visit(index)
        except:
            self.Warn.setWindowTitle("Ошибка")
            self.Warn.showMessage("Вы не записаны на данное посещение!")

    def pay_for_service(self):
        try:
            index = int(self.ui.lineEdit_5.text())
            count = int(self.ui.lineEdit_6.text())
            self.api.pay_for_service(index, count)
        except:
            self.Warn.setWindowTitle("Ошибка")
            self.Warn.showMessage("Не ваша запись или неточная сумма!")


class Master(QtWidgets.QMainWindow):
    def __init__(self, current_user, parent=None):
        QtWidgets.QMainWindow.__init__(self, parent)
        self.ui = Ui_Master()
        self.ui.setupUi(self)
        self.current_user = current_user
        self.api = API(self.current_user)
        self.ui.label_4.setText(self.current_user)
        self.ui.label_3.setText(str(self.api.get_balance(self.current_user)) + " ETH")
        self.timer = QtCore.QTimer()
        self.timer.timeout.connect(self.update_all)
        self.timer.start(5000)

    def update_all(self):
        self.ui.label_3.setText(str(self.api.get_balance(self.current_user)) + " ETH")

        visits = self.api.get_visits()
        all_visits = []
        count = 0
        for visit in visits:
            if self.api.check_master(count, self.current_user) == True:
                all_visits.append(visit)
            count += 1
        self.ui.tableWidget.setRowCount(len(all_visits))
        self.ui.tableWidget.setColumnCount(7)
        for i in range(len(all_visits)):
            for j in range(1, 2):
                self.ui.tableWidget.setItem(i, j, QtWidgets.QTableWidgetItem(str(all_visits[i][j - 1])))
            self.ui.tableWidget.setItem(i, 0, QtWidgets.QTableWidgetItem(str(i)))
        for i in range(len(all_visits)):
            for j in range(3, 7):
                self.ui.tableWidget.setItem(i, j, QtWidgets.QTableWidgetItem(str(all_visits[i][j - 1])))
        for i in range(len(all_visits)):
            timestamp = all_visits[i][1]
            if timestamp == 0:
                self.ui.tableWidget.setItem(i, 2, QtWidgets.QTableWidgetItem(str("Отмена")))
            else:
                data = datetime.datetime.fromtimestamp(timestamp)
                self.ui.tableWidget.setItem(i, 2, QtWidgets.QTableWidgetItem(
                    str(data.day) + ":" + str(data.month) + ":" + str(data.year) + " " + str(data.hour) + ":" + str(data.minute)))


if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    myapp = Go()
    myapp.show()
    sys.exit(app.exec())
