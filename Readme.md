# Types of Design Patterns

In this tutorial, we will explore different types of design patterns commonly used in software development. Design patterns are reusable solutions to common problems that occur during the design and implementation of software systems. They provide a structured approach to solving these problems and help in creating flexible, maintainable, and scalable code.

## Creational Patterns

Creational patterns focus on object creation mechanisms, providing ways to create objects in a manner suitable for a particular situation. Some commonly used creational patterns include:

- Factory Method: The Factory Method pattern defines an interface for creating objects, but lets subclasses decide which class to instantiate. This allows a class to defer instantiation to subclasses.

```dart
abstract class Shape {
    void draw();
}

class Circle implements Shape {
    @override
    void draw() {
        print("Drawing a circle");
    }
}

class Square implements Shape {
    @override
    void draw() {
        print("Drawing a square");
    }
}

abstract class ShapeFactory {
    Shape createShape();
}

class CircleFactory extends ShapeFactory {
    @override
    Shape createShape() {
        return Circle();
    }
}

class SquareFactory extends ShapeFactory {
    @override
    Shape createShape() {
        return Square();
    }
}

void main() {
    ShapeFactory factory = CircleFactory();
    Shape shape = factory.createShape();
    shape.draw();
}
```

- Abstract Factory: The Abstract Factory pattern provides an interface for creating families of related or dependent objects without specifying their concrete classes.

```dart
abstract class Button {
    void render();
}

abstract class Checkbox {
    void render();
}

class WindowsButton implements Button {
    @override
    void render() {
        print("Rendering a Windows button");
    }
}

class WindowsCheckbox implements Checkbox {
    @override
    void render() {
        print("Rendering a Windows checkbox");
    }
}

class MacButton implements Button {
    @override
    void render() {
        print("Rendering a Mac button");
    }
}

class MacCheckbox implements Checkbox {
    @override
    void render() {
        print("Rendering a Mac checkbox");
    }
}

abstract class GUIFactory {
    Button createButton();
    Checkbox createCheckbox();
}

class WindowsFactory implements GUIFactory {
    @override
    Button createButton() {
        return WindowsButton();
    }

    @override
    Checkbox createCheckbox() {
        return WindowsCheckbox();
    }
}

class MacFactory implements GUIFactory {
    @override
    Button createButton() {
        return MacButton();
    }

    @override
    Checkbox createCheckbox() {
        return MacCheckbox();
    }
}

void main() {
    GUIFactory factory = WindowsFactory();
    Button button = factory.createButton();
    Checkbox checkbox = factory.createCheckbox();
    button.render();
    checkbox.render();
}
```

- Singleton: The Singleton pattern ensures that a class has only one instance and provides a global point of access to it.

```dart
class Singleton {
    static Singleton? _instance;

    Singleton._();

    static Singleton getInstance() {
        _instance ??= Singleton._();
        return _instance!;
    }
}

void main() {
    Singleton singleton = Singleton.getInstance();
    // Use the singleton instance
}
```

- Builder: The Builder pattern separates the construction of a complex object from its representation, allowing the same construction process to create different representations.

```dart
class Car {
    final String brand;
    final String model;
    final int year;
    // Other attributes

    Car._(Builder builder)
            : brand = builder.brand,
                model = builder.model,
                year = builder.year;
    // Set other attributes

    factory Car(Builder builder) {
        return Car._(builder);
    }
}

class Builder {
    final String brand;
    final String model;
    final int year;
    // Other attributes

    Builder(this.brand, this.model, this.year);
    // Setters for other attributes

    Car build() {
        return Car(this);
    }
}

void main() {
    Car car = Builder("Toyota", "Camry", 2022)
            // Set other attributes
            .build();
}
```

- Prototype: The Prototype pattern allows creating new objects by cloning existing ones and modifying them as needed.

```dart
abstract class Shape implements Cloneable {
    final String color;

    Shape(this.color);

    String getColor() {
        return color;
    }

    Shape clone();
}

class Circle extends Shape {
    final int radius;

    Circle(String color, this.radius) : super(color);

    int getRadius() {
        return radius;
    }

    @override
    Shape clone() {
        return Circle(getColor(), getRadius());
    }
}

void main() {
    Circle circle = Circle("Red", 5);
    Circle clonedCircle = circle.clone() as Circle;
}
```

## Structural Patterns

Structural patterns deal with the composition of classes and objects, providing ways to form larger structures from individual parts. Some commonly used structural patterns include:

- Adapter: The Adapter pattern allows objects with incompatible interfaces to work together by wrapping the object with a new interface.

```dart
abstract class MediaPlayer {
    void play(String audioType, String fileName);
}

abstract class AdvancedMediaPlayer {
    void playVlc(String fileName);
    void playMp4(String fileName);
}

class VlcPlayer implements AdvancedMediaPlayer {
    @override
    void playVlc(String fileName) {
        print("Playing VLC file: $fileName");
    }

    @override
    void playMp4(String fileName) {
        // Do nothing
    }
}

class Mp4Player implements AdvancedMediaPlayer {
    @override
    void playVlc(String fileName) {
        // Do nothing
    }

    @override
    void playMp4(String fileName) {
        print("Playing MP4 file: $fileName");
    }
}

class MediaAdapter implements MediaPlayer {
    final AdvancedMediaPlayer advancedMediaPlayer;

    MediaAdapter(String audioType)
            : advancedMediaPlayer = audioType.toLowerCase() == "vlc"
                        ? VlcPlayer()
                        : audioType.toLowerCase() == "mp4"
                                ? Mp4Player()
                                : throw ArgumentError("Invalid audio type: $audioType");

    @override
    void play(String audioType, String fileName) {
        if (audioType.toLowerCase() == "vlc") {
            advancedMediaPlayer.playVlc(fileName);
        } else if (audioType.toLowerCase() == "mp4") {
            advancedMediaPlayer.playMp4(fileName);
        }
    }
}

class AudioPlayer implements MediaPlayer {
    MediaAdapter? mediaAdapter;

    @override
    void play(String audioType, String fileName) {
        if (audioType.toLowerCase() == "mp3") {
            print("Playing MP3 file: $fileName");
        } else if (audioType.toLowerCase() == "vlc" ||
                audioType.toLowerCase() == "mp4") {
            mediaAdapter = MediaAdapter(audioType);
            mediaAdapter!.play(audioType, fileName);
        } else {
            print("Invalid media type: $audioType");
        }
    }
}

void main() {
    MediaPlayer audioPlayer = AudioPlayer();
    audioPlayer.play("mp3", "song.mp3");
    audioPlayer.play("vlc", "movie.vlc");
    audioPlayer.play("mp4", "video.mp4");
}
```

- Bridge: The Bridge pattern decouples an abstraction from its implementation, allowing the two to vary independently.

```dart
abstract class Color {
    void applyColor();
}

class RedColor implements Color {
    @override
    void applyColor() {
        print("Applying red color");
    }
}

class BlueColor implements Color {
    @override
    void applyColor() {
        print("Applying blue color");
    }
}

abstract class Shape {
    final Color color;

    Shape(this.color);

    void applyColor();
}

class Square extends Shape {
    Square(Color color) : super(color);

    @override
    void applyColor() {
        print("Square: ");
        color.applyColor();
    }
}

class Circle extends Shape {
    Circle(Color color) : super(color);

    @override
    void applyColor() {
        print("Circle: ");
        color.applyColor();
    }
}

void main() {
    Shape redSquare = Square(RedColor());
    redSquare.applyColor();

    Shape blueCircle = Circle(BlueColor());
    blueCircle.applyColor();
}
```

- Composite: The Composite pattern composes objects into tree structures to represent part-whole hierarchies. Composite lets clients treat individual objects and compositions of objects uniformly.

```dart
abstract class Employee {
    void showDetails();
}

class Developer implements Employee {
    final String name;
    final String position;

    Developer(this.name, this.position);

    @override
    void showDetails() {
        print("Developer: $name, Position: $position");
    }
}

class Manager implements Employee {
    final String name;
    final String position;

    Manager(this.name, this.position);

    @override
    void showDetails() {
        print("Manager: $name, Position: $position");
    }
}

class Team implements Employee {
    final List<Employee> employees = [];

    void addEmployee(Employee employee) {
        employees.add(employee);
    }

    void removeEmployee(Employee employee) {
        employees.remove(employee);
    }

    @override
    void showDetails() {
        for (Employee employee in employees) {
            employee.showDetails();
        }
    }
}

void main() {
    Employee john = Developer("John Doe", "Senior Developer");
    Employee jane = Developer("Jane Smith", "Junior Developer");
    Employee mike = Manager("Mike Johnson", "Project Manager");

    Team team = Team();
    team.addEmployee(john);
    team.addEmployee(jane);
    team.addEmployee(mike);

    team.showDetails();
}
```

- Decorator: The Decorator pattern attaches additional responsibilities to an object dynamically. Decorators provide a flexible alternative to subclassing for extending functionality.

```dart
abstract class Pizza {
    String getDescription();
    double getCost();
}

class MargheritaPizza implements Pizza {
    @override
    String getDescription() {
        return "Margherita Pizza";
    }

    @override
    double getCost() {
        return 8.99;
    }
}

abstract class PizzaDecorator implements Pizza {
    final Pizza pizza;

    PizzaDecorator(this.pizza);

    @override
    String getDescription() {
        return pizza.getDescription();
    }

    @override
    double getCost() {
        return pizza.getCost();
    }
}

class CheeseDecorator extends PizzaDecorator {
    CheeseDecorator(Pizza pizza) : super(pizza);

    @override
    String getDescription() {
        return "${pizza.getDescription()}, Cheese";
    }

    @override
    double getCost() {
        return pizza.getCost() + 1.99;
    }
}

class PepperoniDecorator extends PizzaDecorator {
    PepperoniDecorator(Pizza pizza) : super(pizza);

    @override
    String getDescription() {
        return "${pizza.getDescription()}, Pepperoni";
    }

    @override
    double getCost() {
        return pizza.getCost() + 2.99;
    }
}

void main() {
    Pizza margherita = MargheritaPizza();
    Pizza margheritaWithCheese = CheeseDecorator(margherita);
    Pizza margheritaWithCheeseAndPepperoni =
            PepperoniDecorator(margheritaWithCheese);

    print(margheritaWithCheeseAndPepperoni.getDescription());
    print("Cost: \$${margheritaWithCheeseAndPepperoni.getCost()}");
}
```

- Facade: The Facade pattern provides a simplified interface to a complex subsystem, making it easier to use and understand.

```dart
class SubsystemA {
    void operationA() {
        print("Subsystem A operation");
    }
}

class SubsystemB {
    void operationB() {
        print("Subsystem B operation");
    }
}

class SubsystemC {
    void operationC() {
        print("Subsystem C operation");
    }
}

class Facade {
    final SubsystemA subsystemA;
    final SubsystemB subsystemB;
    final SubsystemC subsystemC;

    Facade()
            : subsystemA = SubsystemA(),
                subsystemB = SubsystemB(),
                subsystemC = SubsystemC();

    void operation() {
        subsystemA.operationA();
        subsystemB.operationB();
        subsystemC.operationC();
    }
}

void main() {
    Facade facade = Facade();
    facade.operation();
}
```

- Flyweight: The Flyweight pattern reduces the memory footprint of an application by sharing common data across multiple objects.

```dart
abstract class Shape {
    void draw();
}

class Circle implements Shape {
    final String color;

    Circle(this.color);

    @override
    void draw() {
        print("Drawing a $color circle");
    }
}

class ShapeFactory {
    static final Map<String, Shape> circleMap = {};

    static Shape getCircle(String color) {
        Shape? circle = circleMap[color];

        if (circle == null) {
            circle = Circle(color);
            circleMap[color] = circle;
        }

        return circle;
    }
}

void main() {
    final List<String> colors = ["Red", "Green", "Blue"];

    for (int i = 0; i < 10; i++) {
        String color = colors[i % colors.length];
        Shape circle = ShapeFactory.getCircle(color);
        circle.draw();
    }
}
```

- Proxy: The Proxy pattern provides a surrogate or placeholder for another object to control access to it.

```dart
abstract class Image {
    void display();
}

class RealImage implements Image {
    final String filename;

    RealImage(this.filename) {
        loadFromDisk();
    }

    void loadFromDisk() {
        print("Loading image: $filename");
    }

    @override
    void display() {
        print("Displaying image: $filename");
    }
}

class ProxyImage implements Image {
    final String filename;
    RealImage? realImage;

    ProxyImage(this.filename);

    @override
    void display() {
        realImage ??= RealImage(filename);
        realImage!.display();
    }
}

void main() {
    Image image1 = ProxyImage("image1.jpg");
    Image image2 = ProxyImage("image2.jpg");

    image1.display();
    image1.display();
    image2.display();
}
```

## Behavioral Patterns

Behavioral patterns focus on the interaction between objects, defining how they communicate and collaborate to achieve a specific behavior. Some commonly used behavioral patterns include:

- Observer: The Observer pattern defines a one-to-many dependency between objects, so that when one object changes state, all its dependents are notified and updated automatically.

```dart
abstract class Observer {
    void update();
}

class ConcreteObserver implements Observer {
    final String name;
    final Subject subject;

    ConcreteObserver(this.name, this.subject);

    @override
    void update() {
        print("$name received an update: ${subject.getState()}");
    }
}

abstract class Subject {
    void attach(Observer observer);
    void detach(Observer observer);
    void notifyObservers();
    String getState();
}

class ConcreteSubject implements Subject {
    final List<Observer> observers = [];
    String state = "";

    @override
    void attach(Observer observer) {
        observers.add(observer);
    }

    @override
    void detach(Observer observer) {
        observers.remove(observer);
    }

    @override
    void notifyObservers() {
        for (Observer observer in observers) {
            observer.update();
        }
    }

    @override
    String getState() {
        return state;
    }

    void setState(String state) {
        this.state = state;
        notifyObservers();
    }
}

void main() {
    Subject subject = ConcreteSubject();
    Observer observer1 = ConcreteObserver("Observer 1", subject);
    Observer observer2 = ConcreteObserver("Observer 2", subject);

    subject.attach(observer1);
    subject.attach(observer2);

    subject.setState("New state");
}
```

- Strategy: The Strategy pattern defines a family of algorithms, encapsulates each one, and makes them interchangeable. It lets the algorithm vary independently from clients that use it.

```dart
abstract class SortingStrategy {
    void sort(List<int> array);
}

class BubbleSortStrategy implements SortingStrategy {
    @override
    void sort(List<int> array) {
        // Bubble sort implementation
    }
}

class QuickSortStrategy implements SortingStrategy {
    @override
    void sort(List<int> array) {
        // Quick sort implementation
    }
}

class MergeSortStrategy implements SortingStrategy {
    @override
    void sort(List<int> array) {
        // Merge sort implementation
    }
}

class Sorter {
    SortingStrategy? sortingStrategy;

    void setSortingStrategy(SortingStrategy sortingStrategy) {
        this.sortingStrategy = sortingStrategy;
    }

    void sort(List<int> array) {
        sortingStrategy?.sort(array);
    }
}

void main() {
    Sorter sorter = Sorter();
    List<int> array = [5, 2, 8, 1, 9];

    sorter.setSortingStrategy(BubbleSortStrategy());
    sorter.sort(array);
}
```
