# stripe-connect-ios-app-app

A Swift 3, iOS App that Authenticates to a Stripe Account, via a Node.js App.


![](stripe_connect_demo.gif?raw=true)


This application is used to demonstrate authentication to a Stripe Account. On
successful authentication, a Stripe User ID (Stripe Account ID) will be returned to the user. It is meant to work in conjunction with a Node.js App as the backend. The Node.js App can be found over [here>>]

You will need to configure the Node.js app first in order to obtain your hosted 'url'. Once the url is available, you should then assign it to the instance variable 'url', in StripeConnectViewController.swift as shown below;

![](url.png?raw=true)



Have fun!

**-Mohau**


[here>>]: https://github.com/mohaumpoti/stripe-connect-nodejs-app
