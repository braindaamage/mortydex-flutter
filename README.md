# mortydex-flutter

## Generate tests

### Install lcov
```
brew install lcov
```

### Generate Tests with coverage
```
cd package or module
flutter test --coverage 
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```