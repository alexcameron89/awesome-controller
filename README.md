# AwesomeController - An Educational Rebuild of ActionController
## Purpose of AwesomeController
AwesomeController was built to understand and simplify the concepts of ActionController and the functionality it provides. It started by taking a simple example Ruby on Rails app and removing the inheritance of ActionController from the app's controllers. From there, everything was built by following the trail of failures and referencing the real code of Action Controller to understand what it is doing.

## Concepts
### Dispatching
### Base and Api
### Using Modules

## Pieces of AwesomeController
### SuperBase
**Inspired By [ActionController::Metal](https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/metal.rb)**

SuperBase provides the very basic functionality of a controller like dispatching. Both **AwesomeController::Base** and **AwesomeController::Api** inherit from SuperBase and build upon its functionality to become more complex controller classes.

This is similar to the relationship **ActionController::API** and **ActionController::Base** to **ActionController::Metal**.

### Api
**Inspired By []()**

### Base
**Inspired By []()**

### Callbacks
**Inspired By []()**

### Params
**Inspired By []()**

### ImplicitRendering
**Inspired By []()**

### BasicRendering
**Inspired By []()**

### UrlFor
**Inspired By []()**

### Redirecting
**Inspired By []()**

### Flash
**Inspired By []()**

### Rendering
**Inspired By []()**

### JsonRenderer
**Inspired By []()**


## Details about Rails' ActionPack and ActionController
ActionController lives in a greater module of Rails called Action Pack.
### Action Dispatch
### Abstract Controller
### Action Controller
#### Metal
