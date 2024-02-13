from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QHBoxLayout, QPushButton, QComboBox, QLabel, QTextEdit, QSplitter
from PyQt5.QtCore import Qt, QThread, pyqtSignal
from subprocess import Popen, PIPE, STDOUT
import sys

class ExecuteScriptThread(QThread):
    output = pyqtSignal(str)

    def __init__(self, command):
        super().__init__()
        self.command = command

    def run(self):
        process = Popen(self.command, shell=True, stdout=PIPE, stderr=STDOUT, executable='/bin/bash', text=True, bufsize=1)
        for line in process.stdout:
            self.output.emit(line)
        process.stdout.close()
        process.wait()

class DockerBuildRunGUI(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.setGeometry(100, 100, 800, 550)  # 너비를 800으로 조정하여 더 많은 공간 확보
        self.setWindowTitle('Docker Build and Run with Options GUI')

        mainLayout = QVBoxLayout()
        splitter = QSplitter(Qt.Horizontal)

        # Docker Build 섹션
        buildLayout = QVBoxLayout()
        buildContainer = QWidget()
        buildContainer.setLayout(buildLayout)

        self.ubuntuVersionCombo = QComboBox()
        self.ubuntuVersionCombo.addItems(["ubuntu18.04", "ubuntu20.04", "ubuntu22.04"])
        buildLayout.addWidget(QLabel("Select Ubuntu Version:"))
        buildLayout.addWidget(self.ubuntuVersionCombo)

        self.cudaVersionCombo = QComboBox()
        self.cudaVersionCombo.addItems(["10.1", "10.2", "11.0.3", "11.1.1", "11.2.2", "11.3.1", "11.4.3", "11.5.2", "11.6.2", "11.7.1", "11.8.0", "12.0.1", "12.1.1", "12.2.2", "12.3.1"])
        buildLayout.addWidget(QLabel("Select CUDA Version:"))
        buildLayout.addWidget(self.cudaVersionCombo)

        self.cudnnVersionCombo = QComboBox()
        self.cudnnVersionCombo.addItems(["cudnn7", "cudnn8", "none"])
        buildLayout.addWidget(QLabel("Select cuDNN Version:"))
        buildLayout.addWidget(self.cudnnVersionCombo)

        self.rosVersionCombo = QComboBox()
        self.rosVersionCombo.addItems(["dashing", "foxy", "humble", "none"])
        buildLayout.addWidget(QLabel("Select ROS Version:"))
        buildLayout.addWidget(self.rosVersionCombo)

        self.buildButton = QPushButton('Build Docker Image')
        self.buildButton.clicked.connect(self.buildDockerImage)
        buildLayout.addWidget(self.buildButton)

        self.output = QTextEdit()
        self.output.setPlaceholderText("Build Output...")
        self.output.setReadOnly(True)
        self.output.setStyleSheet("background-color: black; color: white;")
        buildLayout.addWidget(self.output)

        # Docker Run 섹션 (여기에 실행 관련 UI 구성 요소 추가)
        runLayout = QVBoxLayout()
        runContainer = QWidget()
        runContainer.setLayout(runLayout)

        # 예시: Docker Run 버튼
        self.runButton = QPushButton('Run Docker Container')
        runLayout.addWidget(self.runButton)
        self.runOutput = QTextEdit()
        self.runOutput.setPlaceholderText("Run Output...")
        self.runOutput.setReadOnly(True)
        self.runOutput.setStyleSheet("background-color: black; color: white;")
        runLayout.addWidget(self.runOutput)

        # Splitter에 위젯 추가
        splitter.addWidget(buildContainer)
        splitter.addWidget(runContainer)
        splitter.setSizes([400,400])  # 초기 분할 크기 설정

        mainLayout.addWidget(splitter)
        self.setLayout(mainLayout)

    def buildDockerImage(self):
        # 이미지 빌드 로직
        pass

    def updateOutput(self, text):
        self.output.append(text)

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = DockerBuildRunGUI()
    ex.show()
    sys.exit(app.exec_())
