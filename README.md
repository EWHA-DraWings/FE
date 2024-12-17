# 캡스톤디자인 그로쓰 05팀 그린나래 FE 레포

### 😄Members
- 프로젝트 기간: 24.03~24.12
- 김여은: FE(리더), BE
- 우정아: BE(리더), AI
- 장서연: AI(리더), FE
<br><br>

### 📂프로젝트 소개
✔️ 서비스명: 소담 - 소리로 담는 나만의 작은 이야기

✔️ 주제: 노인 인지 기능 저하 예방을 위한 GPT-4o 기반 음성 챗봇 및 일기 생성 서비스

✔️ 부제: 대화로 기억을 지키는 치매 예방 솔루션

<br><br>

### 📂기능 소개
✔️ 기능1: AI와의 음성 채팅<br>
: 사용자가 설정한 시간에(ex. 저녁 7시) 규칙적으로 하루에 있었던 일, 수면 시간, 섭취 음식, 약 복용 여부 등 여러 질문들을 챗봇이 음성으로 제공

✔️ 기능2: 일기 생성<br>
: 챗봇과 나눈 대화를 바탕으로 요약된 일기 생성

✔️ 기능3: report 제공<br>
: 챗봇과 나눈 대화를 바탕으로 report 제공.<br>
: 리포트에는 감정 분석 결과, 컨디션, 기억점수 그래프가 포함<br>

✔️ 기능4: 기억점수 측정 및 치매 자가진단<br>
: 챗봇과의 음성 대화를 통해 3일간의 일기 데이터를 바탕으로 기억점수 측정<br>
: TTS 기능을 활용한 자가진단(KDSQ, PRMQ)을 통해 추가적인 인지기능 저하 체크<br>


노인 사용자/ 보호자 사용자의 기능 비교<br>

![image](https://github.com/user-attachments/assets/040638f8-0479-4595-9aad-38cc014b6a94)

<br><br>

## 💻FE 사용 기술 및 프레임워크
- Flutter: https://flutter.dev/
  
## </>Source 코드 설명
- **lib**
  - **assets**: 앱에서 사용하는 리소스 파일을 포함하는 폴더
    - `fonts`: 폰트 파일을 저장하는 폴더
    - `images`: 이미지 파일을 저장하는 폴더
  - **models**: 앱에서 사용되는 데이터 모델을 정의하는 폴더
  - **screens**: 앱의 각 화면을 구성하는 폴더
    - `calendar`: 캘린더 화면
    - `chat`: 채팅 화면
    - `elderly_signin`: 노인 로그인 화면
    - `guardian_signin`: 보호자 로그인 화면
    - `report`: 보고서 화면
    - `self_diagnosis`: 자가 진단 화면
  - **services**: 앱의 기능을 제공하는 서비스 관련 코드
  - **widgets**: UI 위젯 및 재사용 가능한 컴포넌트를 포함하는 폴더
  - **global.dart**: 전역 변수를 정의하는 파일
  - **main.dart**: 앱의 시작점을 정의하며 초기화 및 라우팅을 담당하는 파일

## 🛠️How to build
#### 1. git clone
작업 폴더를 열고 터미널에
```git clone https://github.com/EWHA-DraWings/FE```
를 입력하여 소담의 프론트엔드 레포지토리를 클론합니다.
 
#### 2. 서버 IP 주소 확인
앱이 정상적으로 작동하려면 소담 백엔드 코드가 실행되어야 합니다.<br>
백엔드 서버를 실행하려면 소담 백엔드 레포의 리드미를(https://github.com/EWHA-DraWings/BE)를 참고해주세요.

백엔드 서버가 정상적으로 실행 중이라면,
`sodam\lib\global.dart`의 ipAddr 변수에 해당 서버의 public IP 주소를 넣어줍니다.
ex) 서버의 public IP 주소가 192.168.1.1이라면,<br>
```static const ipAddr = '192.168.1.1';```

#### 3. flutter 종속성 설치
터미널에 `flutter pub get`을 입력하여 종속성을 설치합니다.

#### 4. apk 파일 빌드하기
터미널에서 아래 명령어를 입력하여 빌드합니다.
```flutter build apk --release --target-platform=android-arm64```

## ⬇️How to install
1. (경로 수정!) `FE/sodam/build/app/outputs/apk/release`에서 빌드된 앱 app-release.apk를 확인할 수 있습니다.
2. apk 파일을 안드로이드 디바이스로 전송하여 설치합니다.

## 📲How to test
앱을 실행하면 나타나는 로그인 화면에 아래의 테스트 계정을 입력하여 앱을 테스트할 수 있습니다.
#### 테스트 계정
```
ID: jonggang
Password: 20240929
```

## 🌐Used Open Source
- **audio_wave**: 오디오 파형을 시각적으로 표시하는 기능 제공
- **audioplayers**: 오디오 파일을 재생하고 제어하는 기능 설정
- **web_socket_channel**: WebSocket을 통해 실시간 통신을 설정
- **fl_chart**: 다양한 종류의 차트를 그릴 수 있는 위젯 제공
- **flutter_secure_storage**: 안전하게 데이터를 저장하고 불러올 수 있는 기능 제공
- **flutter_sound**: 오디오 녹음 및 재생 기능을 설정
- **flutter_tts**: 텍스트를 음성으로 변환하는 기능 제공
- **http**: HTTP 요청을 보내고 받을 수 있는 기능 설정
- **permission_handler**: 앱에서 필요한 권한을 요청하고 처리할 수 있도록 함
- **provider**: 상태 관리를 위한 패키지 제공
- **record**: 오디오 녹음 기능을 설정
- **table_calendar**: 달력 UI 제공
