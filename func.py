import threading
from time import sleep
import sqlite3
from hashlib import blake2b
from hmac import compare_digest


from PyQt5.QtCore import QObject, pyqtSlot, pyqtSignal


class Backend(QObject):

    def __init__(self):
        QObject.__init__(self)

    authenticated = pyqtSignal(str, arguments=['_authenticate'])


    @pyqtSlot(str, str)
    def authenticate(self, email, passcode):
        auth_thread = threading.Thread(target=self._authenticate,
        args=[email, passcode])
        auth_thread.daemon = True
        auth_thread.start()

    def _authenticate(self, email, passcode):

        conn = sqlite3.connect('signin.db')
        cursor = conn.cursor()

        sql = ''' SELECT `username`, `hashed_password` FROM USER WHERE email=?'''
        cursor.execute(sql, (email,))
        # this came from db
        username, hash_passcode = cursor.fetchone()

        # this came from the user
        hlib = blake2b(key=b'signin12343434')
        hlib.update(passcode.encode('utf-8'))
        hhex = hlib.hexdigest()

        conn.close()

        hash_passcode = hash_passcode.encode('utf-8')
        hhex = hhex.encode('utf-8')

        if compare_digest(hash_passcode, hhex):
            self.authenticated.emit(username)
        else:
            pass
