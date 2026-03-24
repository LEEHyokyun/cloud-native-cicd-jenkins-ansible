## 1.  개요

- Java ver 21.
- Spring Boot ver 3.5.0 

## 2. Projects

- Jenkins cicd pipleline 구축을 위한 프로젝트
  - todeploy

## 3. pipeline

| 구성 요소       | Host Port | Container(Inner) Port | 설명                      |
| ----------- | --------- | --------------------- | ----------------------- |
| Jenkins     | 8080      | 8080                  | CI/CD 서버                |
| Tomcat      | 8081      | 8080                  | WAS (외부 8081 → 내부 8080) |
| Application | 8090      | (내부 실행 포트)            | Spring Boot 등 애플리케이션    |

```scss
Git Push → Webhook → Jenkins Trigger
        → Git Fetch & Checkout (master)
        → Build (Jar/War 생성)
        → Deploy (Tomcat Container)
        → Application Running
```

※ build, test stage를 분리하여 진행