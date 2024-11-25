///
/// This file contains the implementation of the Observer pattern.
///
/// The Observer pattern is a behavioral design pattern that defines a one-to-many dependency between objects,
/// so that when one object changes state, all its dependents are notified and updated automatically.
///
/// The pattern consists of the following components:
/// - Subject: An interface that defines the operations for attaching, detaching, and notifying observers.
/// - ConcreteSubject: A concrete implementation of the Subject interface. It maintains a list of observers
///   and notifies them when its state changes.
/// - Observer: An interface that defines the operation for updating the observer.
/// - ConcreteObserver: A concrete implementation of the Observer interface. It defines the behavior that
///   should be executed when it is notified by the subject.
///
/// Usage:
/// 1. Create a ConcreteSubject object.
/// 2. Create one or more ConcreteObserver objects.
/// 3. Attach the observers to the subject using the `attach` method.
/// 4. When the subject's state changes, call the `notifyObservers` method to notify all the attached observers.
/// 5. The observers will be automatically updated and execute their defined behavior.
///

// Define the Subject interface
abstract class Subject {
  void attach(Observer observer);
  void detach(Observer observer);
  void notifyObservers();
}

// Define the Observer interface
abstract class Observer {
  void update(String state);
}


// Concrete implementation of the Subject
class ConcreteSubject implements Subject {
  List<Observer> _observers = [];
  String _state = '';

  void attach(Observer observer) {
    _observers.add(observer);
  }

  void detach(Observer observer) {
    _observers.remove(observer);
  }

  void notifyObservers() {
    for (var observer in _observers) {
      observer.update(_state);
    }
  }

  void setState(String state) {
    _state = state;
    notifyObservers();
  }
}


class ConcreteObserver implements Observer {
  @override
  void update(String state) {
    print('Observer received state: $state');
  }
}

