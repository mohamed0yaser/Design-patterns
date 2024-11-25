# Types of Design Patterns

# Design Patterns

In this tutorial, we will explore different types of design patterns commonly used in software development. Design patterns are reusable solutions to common problems that occur during the design and implementation of software systems. They provide a structured approach to solving these problems and help in creating flexible, maintainable, and scalable code.

## Creational Patterns

Creational patterns focus on object creation mechanisms, providing ways to create objects in a manner suitable for a particular situation. Some commonly used creational patterns include:

### Factory Method

The Factory Method pattern defines an interface for creating objects, but lets subclasses decide which class to instantiate. This allows a class to defer instantiation to subclasses.

```dart
abstract class Product {
    void operation();
}

class ConcreteProductA implements Product {
    @override
    void operation() {
        print('ConcreteProductA operation');
    }
}

class ConcreteProductB implements Product {
    @override
    void operation() {
        print('ConcreteProductB operation');
    }
}

abstract class Creator {
    Product factoryMethod();
}

class ConcreteCreatorA implements Creator {
    @override
    Product factoryMethod() {
        return ConcreteProductA();
    }
}

class ConcreteCreatorB implements Creator {
    @override
    Product factoryMethod() {
        return ConcreteProductB();
    }
}

void main() {
    Creator creator = ConcreteCreatorA();
    Product product = creator.factoryMethod();
    product.operation();
}
```

### Abstract Factory

The Abstract Factory pattern provides an interface for creating families of related or dependent objects without specifying their concrete classes.

```dart
abstract class AbstractProductA {
    void operation();
}

abstract class AbstractProductB {
    void operation();
}

class ConcreteProductA1 implements AbstractProductA {
    @override
    void operation() {
        print('ConcreteProductA1 operation');
    }
}

class ConcreteProductA2 implements AbstractProductA {
    @override
    void operation() {
        print('ConcreteProductA2 operation');
    }
}

class ConcreteProductB1 implements AbstractProductB {
    @override
    void operation() {
        print('ConcreteProductB1 operation');
    }
}

class ConcreteProductB2 implements AbstractProductB {
    @override
    void operation() {
        print('ConcreteProductB2 operation');
    }
}

abstract class AbstractFactory {
    AbstractProductA createProductA();
    AbstractProductB createProductB();
}

class ConcreteFactory1 implements AbstractFactory {
    @override
    AbstractProductA createProductA() {
        return ConcreteProductA1();
    }

    @override
    AbstractProductB createProductB() {
        return ConcreteProductB1();
    }
}

class ConcreteFactory2 implements AbstractFactory {
    @override
    AbstractProductA createProductA() {
        return ConcreteProductA2();
    }

    @override
    AbstractProductB createProductB() {
        return ConcreteProductB2();
    }
}

void main() {
    AbstractFactory factory = ConcreteFactory1();
    AbstractProductA productA = factory.createProductA();
    AbstractProductB productB = factory.createProductB();
    productA.operation();
    productB.operation();
}
```

### Singleton

The Singleton pattern ensures that a class has only one instance and provides a global point of access to it.

```dart
class Singleton {
    static Singleton _instance;

    factory Singleton() {
        if (_instance == null) {
            _instance = Singleton._();
        }
        return _instance;
    }

    Singleton._();
}

void main() {
    Singleton singleton1 = Singleton();
    Singleton singleton2 = Singleton();
    print(identical(singleton1, singleton2)); // Output: true
}
```

### Builder

The Builder pattern separates the construction of a complex object from its representation, allowing the same construction process to create different representations.

```dart
class Product {
    String partA;
    String partB;
    String partC;

    @override
    String toString() {
        return 'Product: $partA, $partB, $partC';
    }
}

abstract class Builder {
    void buildPartA();
    void buildPartB();
    void buildPartC();
    Product getResult();
}

class ConcreteBuilder implements Builder {
    Product _product;

    ConcreteBuilder() {
        _product = Product();
    }

    @override
    void buildPartA() {
        _product.partA = 'Part A';
    }

    @override
    void buildPartB() {
        _product.partB = 'Part B';
    }

    @override
    void buildPartC() {
        _product.partC = 'Part C';
    }

    @override
    Product getResult() {
        return _product;
    }
}

class Director {
    Builder _builder;

    Director(Builder builder) {
        _builder = builder;
    }

    void construct() {
        _builder.buildPartA();
        _builder.buildPartB();
        _builder.buildPartC();
    }
}

void main() {
    Builder builder = ConcreteBuilder();
    Director director = Director(builder);
    director.construct();
    Product product = builder.getResult();
    print(product); // Output: Product: Part A, Part B, Part C
}
```

### Prototype

The Prototype pattern allows creating new objects by cloning existing ones and modifying them as needed.

```dart
abstract class Prototype {
    Prototype clone();
}

class ConcretePrototype implements Prototype {
    String _name;

    ConcretePrototype(this._name);

    @override
    Prototype clone() {
        return ConcretePrototype(_name);
    }

    String get name => _name;
    set name(String value) => _name = value;
}

void main() {
    ConcretePrototype prototype = ConcretePrototype('Prototype');
    ConcretePrototype clone = prototype.clone();
    clone.name = 'Clone';
    print(prototype.name); // Output: Prototype
    print(clone.name); // Output: Clone
}
```

## Structural Patterns

Structural patterns deal with the composition of classes and objects, providing ways to form larger structures from individual parts. Some commonly used structural patterns include:

### Adapter

The Adapter pattern allows objects with incompatible interfaces to work together by wrapping the object with a new interface.

```dart
class Adaptee {
    void specificRequest() {
        print('Adaptee specificRequest');
    }
}

abstract class Target {
    void request();
}

class Adapter implements Target {
    Adaptee _adaptee;

    Adapter(this._adaptee);

    @override
    void request() {
        _adaptee.specificRequest();
    }
}

void main() {
    Adaptee adaptee = Adaptee();
    Target target = Adapter(adaptee);
    target.request();
}
```

### Bridge

The Bridge pattern decouples an abstraction from its implementation, allowing the two to vary independently.

```dart
abstract class Implementor {
    void operationImpl();
}

class ConcreteImplementorA implements Implementor {
    @override
    void operationImpl() {
        print('ConcreteImplementorA operationImpl');
    }
}

class ConcreteImplementorB implements Implementor {
    @override
    void operationImpl() {
        print('ConcreteImplementorB operationImpl');
    }
}

abstract class Abstraction {
    Implementor _implementor;

    Abstraction(this._implementor);

    void operation() {
        _implementor.operationImpl();
    }
}

class RefinedAbstraction extends Abstraction {
    RefinedAbstraction(Implementor implementor) : super(implementor);
}

void main() {
    Implementor implementor = ConcreteImplementorA();
    Abstraction abstraction = RefinedAbstraction(implementor);
    abstraction.operation();
}
```

### Composite

The Composite pattern composes objects into tree structures to represent part-whole hierarchies. Composite lets clients treat individual objects and compositions of objects uniformly.

```dart
abstract class Component {
    void operation();
}

class Leaf implements Component {
    @override
    void operation() {
        print('Leaf operation');
    }
}

class Composite implements Component {
    List<Component> _children = [];

    void add(Component component) {
        _children.add(component);
    }

    void remove(Component component) {
        _children.remove(component);
    }

    @override
    void operation() {
        for (Component component in _children) {
            component.operation();
        }
    }
}

void main() {
    Component leaf1 = Leaf();
    Component leaf2 = Leaf();
    Component composite = Composite();
    composite.add(leaf1);
    composite.add(leaf2);
    composite.operation();
}
```

### Decorator

The Decorator pattern attaches additional responsibilities to an object dynamically. Decorators provide a flexible alternative to subclassing for extending functionality.

```dart
abstract class Component {
    void operation();
}

class ConcreteComponent implements Component {
    @override
    void operation() {
        print('ConcreteComponent operation');
    }
}

abstract class Decorator implements Component {
    Component _component;

    Decorator(this._component);

    @override
    void operation() {
        _component.operation();
    }
}

class ConcreteDecoratorA extends Decorator {
    ConcreteDecoratorA(Component component) : super(component);

    @override
    void operation() {
        super.operation();
        print('ConcreteDecoratorA operation');
    }
}

class ConcreteDecoratorB extends Decorator {
    ConcreteDecoratorB(Component component) : super(component);

    @override
    void operation() {
        super.operation();
        print('ConcreteDecoratorB operation');
    }
}

void main() {
    Component component = ConcreteComponent();
    Component decoratorA = ConcreteDecoratorA(component);
    Component decoratorB = ConcreteDecoratorB(decoratorA);
    decoratorB.operation();
}
```

### Facade

The Facade pattern provides a simplified interface to a complex subsystem, making it easier to use and understand.

```dart
class SubsystemA {
    void operationA() {
        print('SubsystemA operationA');
    }
}

class SubsystemB {
    void operationB() {
        print('SubsystemB operationB');
    }
}

class SubsystemC {
    void operationC() {
        print('SubsystemC operationC');
    }
}

class Facade {
    SubsystemA _subsystemA;
    SubsystemB _subsystemB;
    SubsystemC _subsystemC;

    Facade() {
        _subsystemA = SubsystemA();
        _subsystemB = SubsystemB();
        _subsystemC = SubsystemC();
    }

    void operation() {
        _subsystemA.operationA();
        _subsystemB.operationB();
        _subsystemC.operationC();
    }
}

void main() {
    Facade facade = Facade();
    facade.operation();
}
```

### Flyweight

The Flyweight pattern reduces the memory footprint of an application by sharing common data across multiple objects.

```dart
class Flyweight {
    final String _sharedData;

    Flyweight(this._sharedData);

    void operation(String uniqueData) {
        print('Shared data: $_sharedData, Unique data: $uniqueData');
    }
}

class FlyweightFactory {
    Map<String, Flyweight> _flyweights = {};

    Flyweight getFlyweight(String sharedData) {
        if (!_flyweights.containsKey(sharedData)) {
            _flyweights[sharedData] = Flyweight(sharedData);
        }
        return _flyweights[sharedData];
    }
}

void main() {
    FlyweightFactory factory = FlyweightFactory();
    Flyweight flyweight1 = factory.getFlyweight('SharedData');
    Flyweight flyweight2 = factory.getFlyweight('SharedData');
    flyweight1.operation('UniqueData1');
    flyweight2.operation('UniqueData2');
}
```

### Proxy

The Proxy pattern provides a surrogate or placeholder for another object to control access to it.

```dart
abstract class Subject {
    void request();
}

class RealSubject implements Subject {
    @override
    void request() {
        print('RealSubject request');
    }
}

class Proxy implements Subject {
    RealSubject _realSubject;

    Proxy(this._realSubject);

    @override
    void request() {
        _realSubject.request();
    }
}

void main() {
    RealSubject realSubject = RealSubject();
    Proxy proxy = Proxy(realSubject);
    proxy.request();
}
```

## Behavioral Patterns

Behavioral patterns focus on the interaction between objects, defining how they communicate and collaborate to achieve a specific behavior. Some commonly used behavioral patterns include:

### Observer

The Observer pattern defines a one-to-many dependency between objects, so that when one object changes state, all its dependents are notified and updated automatically.

```dart
abstract class Observer {
    void update();
}

class ConcreteObserverA implements Observer {
    @override
    void update() {
        print('ConcreteObserverA update');
    }
}

class ConcreteObserverB implements Observer {
    @override
    void update() {
        print('ConcreteObserverB update');
    }
}

class Subject {
    List<Observer> _observers = [];

    void attach(Observer observer) {
        _observers.add(observer);
    }

    void detach(Observer observer) {
        _observers.remove(observer);
    }

    void notify() {
        for (Observer observer in _observers) {
            observer.update();
        }
    }
}

void main() {
    Subject subject = Subject();
    Observer observerA = ConcreteObserverA();
    Observer observerB = ConcreteObserverB();
    subject.attach(observerA);
    subject.attach(observerB);
    subject.notify();
}
```

### Strategy

The Strategy pattern defines a family of algorithms, encapsulates each one, and makes them interchangeable. It lets the algorithm vary independently from clients that use it.

```dart
abstract class Strategy {
    void algorithm();
}

class ConcreteStrategyA implements Strategy {
    @override
    void algorithm() {
        print('ConcreteStrategyA algorithm');
    }
}

class ConcreteStrategyB implements Strategy {
    @override
    void algorithm() {
        print('ConcreteStrategyB algorithm');
    }
}

class Context {
    Strategy _strategy;

    Context(this._strategy);

    void setStrategy(Strategy strategy) {
        _strategy = strategy;
    }

    void execute() {
        _strategy.algorithm();
    }
}

void main() {
    Strategy strategyA = ConcreteStrategyA();
    Strategy strategyB = ConcreteStrategyB();
    Context context = Context(strategyA);
    context.execute();
    context.setStrategy(strategyB);
    context.execute();
}
```
