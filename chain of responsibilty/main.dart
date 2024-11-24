import 'chain_of_responsibility.dart';

void main() {
  // Create the chain of handlers
  final handler1 = ConcreteHandler1();
  final handler2 = ConcreteHandler2();
  final handler3 = ConcreteHandler3();

  handler1.setNextHandler(handler2);
  handler2.setNextHandler(handler3);

  // Send requests to the chain
  handler1.handleRequest('A');
  handler1.handleRequest('B');
  handler1.handleRequest('C');
  handler1.handleRequest('D');
}
