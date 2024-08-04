from PyQt5 import QtCore, QtWidgets, QtGui
import sys

from Admin import Ui_MainWindow
from API import API
class Admin(QtWidgets.QMainWindow):
    def __init__(self):
        super().__init__(self)
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)

if __name__ == "__main__":
    admin = QtWidgets.QApplication(sys.argv)
    myadmin = Admin()
    myadmin.show()
    sys.exit(admin.exec_())