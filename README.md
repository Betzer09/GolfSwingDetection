# Introduction
I was able to have some fun over the weekend and build out a simple project that uses Swift, AVKIt, & CoreML to detect that an object was a person, centered, and stationary. This is used to detect when a person is about 
to swing! 

https://github.com/Betzer09/GolfSwingDetection/assets/31580350/21e26ec8-d684-4721-99c3-d5678a4b5f03

Here's a little information about some of the more complex piecs of the code 

### Archtecture 
The project follows MVC, leverages progrmatic UI, and uses the Coordinator pattern for navigating in the app. 

### BoundingBoxAnalyzer
The BoundingBoxAnalyzer class is a Swift component designed to analyze and track bounding boxes associated with objects in video frames. It implements the BoundingBoxAnalyzerProtocol and offers functionality to determine whether an object is moving or stationary based on its bounding box's positional changes over time. This class is particularly useful in scenarios where real-time object tracking and movement detection are required.

#### Key Features
**Bounding Box Storage**: The class maintains an array of bounding boxes, allowing it to keep track of the object's historical positions.

**Movement Threshold**: Objects are considered to be moving if their positional change exceeds a specified movement threshold (default: 0.02).

**Stationary Detection**: It counts consecutive frames where an object is stationary and can signal when an object becomes stationary, making it suitable for applications such as gesture recognition.


