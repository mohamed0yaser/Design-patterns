import 'observer_pattern.dart';

void main() {
  // Create subject and observers
  var subject = ConcreteSubject();
  var observer1 = ConcreteObserver();
  var observer2 = ConcreteObserver();
  var observer3 = ConcreteObserver();

  // Attach observers to the subject
  subject.attach(observer1);
  subject.attach(observer2);
  subject.attach(observer3);
  subject.notifyObservers();
  // Set the state of the subject
  subject.setState('new state');
  subject.setState('hello');

  // Perform some actions that trigger updates in the subject
  // ...

  // Notify observers
  subject.notifyObservers();
}
