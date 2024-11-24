///
/// This file contains the implementation of the Chain of Responsibility design pattern.
///
/// The Chain of Responsibility pattern allows a request to be passed along a chain of potential handlers
/// until one of the handlers handles the request or the end of the chain is reached.
///
/// The pattern consists of three main components:
/// - Abstract Handler: Defines an interface for handling requests and optionally sets the next handler in the chain.
/// - Concrete Handlers: Implement the handling logic for specific types of requests.
/// - Usage: Demonstrates how to create the chain of handlers and send requests to the chain.
///
/// Example Usage:
/// ```dart
/// // Create the chain of handlers
/// final handler1 = ConcreteHandler1();
/// final handler2 = ConcreteHandler2();
/// final handler3 = ConcreteHandler3();
///
/// handler1.setNextHandler(handler2);
/// handler2.setNextHandler(handler3);
///
/// // Send requests to the chain
/// handler1.handleRequest('A');
/// handler1.handleRequest('B');
/// handler1.handleRequest('C');
/// handler1.handleRequest('D');
/// ```
abstract class Handler {
  Handler? _nextHandler;

  /// Sets the next handler in the chain.
  void setNextHandler(Handler handler){
    _nextHandler = handler;
  }
  /// Handles the request.
  void handleRequest(String request);
}

/// ConcreteHandler1 is a concrete implementation of the Handler interface.
/// It handles requests of type 'A'.
class ConcreteHandler1 extends Handler {
  @override
  void setNextHandler(Handler handler) {
    // Implementation details
    _nextHandler = handler;
  }

  @override
  void handleRequest(String request) {
    // Implementation details
    if (request == 'A') {
      print('ConcreteHandler1 is handling the request: $request');
    } else {
      _nextHandler?.handleRequest(request);
    }
  }
}

/// ConcreteHandler2 is a concrete implementation of the Handler interface.
/// It handles requests of type 'B'.
class ConcreteHandler2 extends Handler {
  @override
  void setNextHandler(Handler handler) {
    // Implementation details
    _nextHandler = handler;
  }

  @override
  void handleRequest(String request) {
    // Implementation details
    if (request == 'B') {
      print('ConcreteHandler2 is handling the request: $request');
    } else {
      _nextHandler?.handleRequest(request);
    }
  }
}

/// ConcreteHandler3 is a concrete implementation of the Handler interface.
/// It handles requests of type 'C'.
class ConcreteHandler3 extends Handler {
  @override
  void setNextHandler(Handler handler) {
    // Implementation details
    _nextHandler = handler;
  }

  @override
  void handleRequest(String request) {
    // Implementation details
    if (request == 'C') {
      print('ConcreteHandler3 is handling the request: $request');
    } else {
      print('End of the chain. No handler found for the request: $request');
    }
  }
}

