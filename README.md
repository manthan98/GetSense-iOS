# GetSense-iOS

Hack The 6ix - Best Security Hack, Best Use of Clarifai API.

## What it does
GetSense is an AI powered flexible security solution that uses low-level IoT devices (laptop camera systems or Raspberry Pi) to detect, classify, and identify strangers and friends in your circle. A GetSense owner uploads images of authorized faces through an user-facing mobile application. Through this iOS application, the user has access to a live-stream of all connected camera devices, and authorized friend list.


## How it works
This iOS application is an interfacing tool to a fairly complex data processing pipeline which lives in another repository, 
found [here](https://github.com/manthan98/getSense).

For the data processing, we used stdlib to generate serverless functions for obtaining the probability score through Clarifai facial recognition, push notifications via Slack alerts to notify the user of an unrecognizable face, and managing the image model training route to Clarifai. For the facial detection process, we used OpenCV with multithreading to detect faces (through Clarifai) for optimization purposes.

This iOS application was exposed to the user for live-streaming all camera sources, adding authorized faces, and visualizing current friend list. All the data involving images and streaming was handled through Firebase storage and database, which the iOS application heavily interfaced with.

## Authors
Manthan S, Vishvajit K, Aaron S, Emmanuel A - official submission can be found [here](https://devpost.com/software/getsense). 
