# 🏦 은행창구 매니저

## 0. 목차
1. [소개](#1-소개)
2. [팀원](#2-팀원)
3. [타임라인](#3-타임라인)
4. [시각화된 프로젝트 구조](#4-시각화된-프로젝트-구조)
5. [실행 화면](#5-실행-화면)
6. [트러블 슈팅](#6-트러블-슈팅)
7. [핵심 경험](#7-프로젝트-수행-중-핵심-경험)
8. [참고 링크](#8-참고-링크)

## 1. 소개
- 은행 업무 처리 프로세스를 구현한 ConsoleApp
- 은행 업무 처리 프로세스를 시각적으로 표현한 UIApp


## 2. 팀원
<div align="center">

| zhilly | 미니 |
| :---: | :---: |
| <img src=https://user-images.githubusercontent.com/99257965/190572502-b7a41ed7-3c1b-44af-8b03-77d7e49d4705.png width=150> | <img src=https://i.imgur.com/i6XRuQE.jpg width=150> |
| [@zhilly11](https://github.com/zhilly11) | [@minii](https://github.com/leegyoungmin) |

</div>


<br>

## 3. 타임라인
[STEP-1]
- 2022.10.31
     - 프로젝트 초기 설정
     - 사용자 대기 Queue 타입 테스트 코드 작성
- 2022.11.01
     - SwiftLint 적용
     - 사용자 대기 Queue 타입 구현


[STEP-2]
 - 2022.11.03
     - Console Manager 타입 구현 및 메서드 구현
     - Bank Manager 타입 구현 및 메서드 구현
     - Bank 타입 구현 및 메서드 구현
     - 코드 리팩토링
 - 2022.11.07
     - 코드 리팩터링

[STEP-3]
 - 2022.11.08
     - Costomer 타입에 프로퍼티 추가
     - BankProcessing 프로토콜 정의 및 기본 구현
     - BankOperation 타입 구현 및 메서드 구현
     - 작업 처리 방식을 Dispatch -> Operation으로 수정
     - Bank 타입 추가 구현
     - 작업시간을 계산하는 메서드 구현
     - 프로젝트 및 코드 리팩토링

[STEP-4]
 - 2022.11.10
     - Main화면을 구성하는 UI요소 파일 구현
     - ConsoleApp에서 구현한 파일을 UIApp에 추가
     - UIApp에서 불필요한 파일 제거 및 통합
     - 고객 업무 수행 메소드 구현
     - UI 업데이트 메서드 구현

## 4. 시각화된 프로젝트 구조
### File Tree
- BankManagerConsoleApp
```bash
BankManagerConsoleApp
├── BaseDataStruct
│   ├── CustomerQueue.swift
│   ├── LinkedList.swift
│   └── Node.swift
├── Manager
├── Model
│   ├── Bank.swift
│   ├── BankBusiness.swift
│   ├── BankOperationProcessing.swift
│   ├── BankerOperation.swift
│   └── Customer.swift
└── main.swift
```

- BankManagerUIApp
```bash
BankManagerUIApp
├── AppDelegate.swift
├── Base.lproj
├── Info.plist
├── SceneDelegate.swift
├── View
│   ├── BankView.swift
│   ├── Base.lproj
│   │   ├── LaunchScreen.storyboard
│   │   └── Main.storyboard
│   ├── CustomerLineScrollView.swift
│   ├── QueueLabelStackView.swift
│   ├── UserTopButtonStackView.swift
│   └── WorkTimeLabelStackView.swift
└── ViewController
    └── BankViewController.swift

```
<br>

### UML
- ConsoleApp 구현 타입의 UML
![ConsoleAppUML](https://user-images.githubusercontent.com/99257965/199923301-c4d42e00-ebbc-421e-a84d-87e4596a6386.jpg)

<br>

## 5. 실행 화면
- **큐 타입 구현 후 테스트 수행결과**

    ![testImage](https://i.imgur.com/7oC1mdo.png)

- **한명의 은행원이 업무를 처리하는 과정**

    ![previewOfCmd](https://i.imgur.com/11t6i1E.gif)

- **두명의 예금 은행원과 한명의 대출 은행원이 비동기적으로 처리하는 과정**

    ![AsyncPreview](https://i.imgur.com/oxCIWOU.gif)

- **UIApp 구현 화면 (미완성)**

    ![UICustomerScroll](https://i.imgur.com/pUR0YdV.gif)


## 6. 트러블 슈팅
**DispatchQueue의 사용**
- 요구사항 중 `은행에는 n명의 은행원이 근무하고, 한명의 은행원만이 창구 업무를 한다.`라는 문구를 이해나는 것에서 어려움을 느낀 것 같다. 여러명의 은행원은 다중 쓰레드의 환경을 말하는 것인지, 단순히 여러개의 은행원 인스턴스가 존재해야 하는 것인지에 대해서 고민하게 되었고, 이를 해결하지 못한채 구현을 하려고 하니 어려움을 겪은 것 같다. 그래서 논의를 하여서 인스턴스를 생성하는 방향이 아닌, 다중 쓰레드의 방향으로 구현을 할 수 있는 부분이 있을 것 같다는 결론을 통해서 다중 쓰레드의 환경으로 구현하기로 하였다.
- 또한, 다중 쓰레드의 관점에서 데이터를 처리하기 위해서 은행원이 근무하는 시간 동안에는 다른 일을 할 수 없는 것을 구현하기 위해서 동기적으로 코드를 작성하려고 하였다.
- 하나의 업무를 처리하는데 걸리는 시간은 0.7초라는 요구사항이 있었고, 이를 해결하기 위해서 `asyncAfter` 메서드를 활용하려고 하였다. 하지만, 비동기적으로 처리하는 것이 아니기 때문에 `sleep`메서드를 활용하여서 업무 시간을 기다릴 수 있도록 하였다.

**은행원의 역할에 대한 고민 및 문제**
- 처음 생각했던 의도 (그림 1)

    ![thinkImage](https://i.imgur.com/xGldy2T.png)

- Operation을 통해 구현 완성 (그림 2)

    ![realImage](https://i.imgur.com/RgSb2t4.png)

- 은행원이 할 수 있는 일의 영역은 어디까지인가에 대해서 고민하게 되었습니다. 은행원이 현재 대출 창구에서 일을 하고 있지만, 다른 업무를 하지 못하는 것은 아니라고 생각하였습니다. 즉, 은행원은 어떤 손님이 와도 업무를 볼 수 있어야 하는 것입니다.
- Thread를 은행원이라고 생각한다면, 한개의 Thread가 한명의 은행원이기 때문에 관리가 더욱 쉬울 것이라고 생각하였습니다. 그래서 `그림 1` 처럼 한개의 글로벌 큐에서 여러개의 쓰레드로 일을 하는 것에 대해서 고민하고 구현을 시도하였습니다. 
- 하지만, 은행 전체의 대기열에서는 비동기적으로 일을 수행시켜야 하는 문제가 발생하였고, 각각의 쓰레드의 일은 동기적으로 이루어져야 하기 때문에 동일한 큐에서 일을 진행하는 것은 적절하지 않다고 생각하였습니다. 그래서 `그림 2`와 같이 두개의 큐로 구성하고, 각 큐에 따라서 동시에 수행할 수 있는 일의 개수를 조절아여서 구현할 수 있도록 하였습니다.
- 위와 같이 구현하는 과정에서 DispatchQueue는 내부 작업에 대한 쓰레드를 직접적으로 제한하는 메서드나 프로퍼티가 존재하지 않기 때문에 Operation 타입과 OperationQueue를 활용하여서 구현하였습니다.

**가로 스크롤**

| 문제 상황 | 해결 화면 |
| :--------: | :--------: |
| <img src="https://i.imgur.com/E7BF2YN.gif" width=300>| <img src="https://i.imgur.com/6bBZSZ7.gif" width=300>|

- UI를 구성하던 중, 동일한 클래스로 정의된 스크롤 뷰 2개를 나란히 배치 하려고 하였다. 하지만, 각 기기의 safeArea의 크기가 다른 이유로 인해서 왼쪽은 정확하게 세로로만 스크롤이 되지만, 오른쪽은 사방으로 스크롤이 가능한 상황이 발생하였다.
- 이는 스크롤 뷰의 ContentView의 가로 길이가 frameLayoutGuide의 가로 길이와 동일하게하여 가로 스크롤을 방지할 수 있었지만, AutoLayout 제약 사항을 구성하는 과정에서 CenterX의 제약사항으로 인해서 발생하게 되었다.
- 이를 해결하기 위해 다양한 방법을 찾게 되었다.
    1. ScrollView의 bounces 프로퍼티를 false로 변경하여서 화면 이외의 영역으로 스크롤 되는 것을 막는법
    2. UIScrollViewDelegate를 채택 하여서 scrollViewDidScroll() 함수를 정의해주는 법
- 우리는 이에 대해서 2번째 방법을 활용하여서 ScrollView의 ContentOffset.x의 값이 변경되는 것을 다시 0으로 변경하여서 가로 스크롤이 되지 않도록 하였다.

    ```swift
    class CustomerLineScrollView: UIScrollView, UIScrollViewDelegate {
        ...
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView.contentOffset.x != 0 {
                scrollView.contentOffset.x = 0
            }
        }
    }
    ```

<br>

## 7. 프로젝트 수행 중 핵심 경험
- Linked-List 타입으로 Queue 타입 구현
- Generics 타입의 이해
- mutating 키워드에 대한 이해
- 동기와 비동기에 대한 이해
- 스레드 개념에 대한 이해
- 동시성 프로그래밍의 이해와 활용
    - GCD의 이해 및 구현
    - RaceCondition을 해결하는 방법
    - Operation의 이해 및 구현
- UIApp에서의 동시성 프로그래밍 적용
- NotificationCenter의 이해 및 활용
- Protocol Orientied Programming에 대한 이해 및 활용
- 커스텀 뷰 구현

<br>

## 8. 참고 링크
[야곰닷넷 - 동시성 프로그래밍](https://yagom.net/courses/%eb%8f%99%ec%8b%9c%ec%84%b1-%ed%94%84%eb%a1%9c%ea%b7%b8%eb%9e%98%eb%b0%8d-concurrency-programming/)
[야곰닷넷 - 오토레이아웃 정복하기](https://yagom.net/courses/autolayout/)
[Concurrent Programming With GCD in Swift 3](https://developer.apple.com/videos/play/wwdc2016/720/)
[Swift Language Guide - Subscripts](https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html)
[Concurrency Programming Guide](https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html)
[Swift Language Guide - Concurrency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)

---
[🔝 맨 위로 이동하기](#🏦-은행창구-매니저)
