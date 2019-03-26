# AwesomeController - An Educational Rebuild of ActionController
## Purpose of AwesomeController
AwesomeController was built to understand and simplify the concepts of ActionController and the functionality it provides. It started by taking a simple example Ruby on Rails app and removing the inheritance of ActionController from the app's controllers. From there, everything was built by following the trail of failures and referencing the real code of Action Controller to understand what it is doing.

## Code Structure of AwesomeController

The code for **AwesomeController** lives in `/app/controllers/awesome_controller`, and the controllers inheriting from it live in `/app/controllers/awesome`.

For each controller inheriting from **AwesomeController**, there is a corresponding controller for it inheriting from **Action Controller**, living in the top level directory of `/app/controllers` or `/app/controllers/api`.

```
app/controllers
├── awesome_controller # Where the AwesomeController code lives
│   ├── api.rb
│   ├── base.rb
│   ├── callbacks.rb
│   ├── flash.rb
│   ├── implicit_rendering.rb
│   ├── json_renderer.rb
│   ├── params.rb
│   ├── redirecting.rb
│   ├── rendering.rb
│   ├── super_base.rb
│   └── url_for.rb
├── awesome # Where the controllers inheriting from AwesomeController live
│   ├── api
│   │   └── posts_controller.rb
│   ├── application_controller.rb
│   └── posts_controller.rb
├── api
│   └── posts_controller.rb
├── application_controller.rb
└── posts_controller.rb
```

## Pieces of AwesomeController
### SuperBase - [Source Code](https://github.com/alexcameron89/awesome-controller/blob/master/app/controllers/awesome_controller/super_base.rb)
**Inspired By [ActionController::Metal](https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/metal.rb)**

SuperBase provides the very basic functionality of a controller like dispatching. Both **AwesomeController::Base** and **AwesomeController::Api** inherit from SuperBase and build upon its functionality to become more complex controller classes.

This is similar to the relationship **ActionController::API** and **ActionController::Base** to **ActionController::Metal**.

### Api - [Source Code](https://github.com/alexcameron89/awesome-controller/blob/master/app/controllers/awesome_controller/api.rb)
**Inspired By [ActionController::API](https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/api.rb)**

The **AwesomeController::Api** class provides a minimal implementation of [**ActionController::API**](https://api.rubyonrails.org/classes/ActionController/API.html). It's a controller that provides the ability to render JSON.

### Base - [Source Code](https://github.com/alexcameron89/awesome-controller/blob/master/app/controllers/awesome_controller/base.rb)
**Inspired By [ActionController::Base](https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/base.rb)**

The **AwesomeController::Base** class provides a minimal implementation of [**ActionController::Base**](https://api.rubyonrails.org/classes/ActionController/API.html). It's a controller that provides the ability to render HTML implicitly. In order to do so, it requires several more modules including **Redirecting**, **UrlFor**, and **Flash**.

### Callbacks - [Source Code](https://github.com/alexcameron89/awesome-controller/blob/master/app/controllers/awesome_controller/callbacks.rb)
**Inspired By [AbstractController::Callbacks](https://github.com/rails/rails/blob/master/actionpack/lib/abstract_controller/callbacks.rb)**

Callbacks provide the functionality for methods like `:before_action`, `:around_action`, and `:after_action`. It does so by taking advantage of the callback [**ActiveSupport::Callbacks**](https://api.rubyonrails.org/classes/ActiveSupport/Callbacks.html) API, as do the real AbstractController::Callbacks and the callbacks provided by Active Record through [**ActiveModel::Callbacks**](https://github.com/rails/rails/blob/master/activemodel/lib/active_model/callbacks.rb).

### Params - [Source Code](https://github.com/alexcameron89/awesome-controller/blob/master/app/controllers/awesome_controller/params.rb)
**Inspired By [ActionController::Parameters](https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/metal/strong_parameters.rb)**

**Params** provides a nice way of receiving parameters from the request, requiring params (and throwing an error when they don't exist), and permitting params (and filtering out the ones that aren't permitted).

_**Note:** The implementation of Params in AwesomeController slightly differs from the code presented in the talk. This was for presentation's sake, and the differences are documented in the module._

### ImplicitRendering - [Source Code](https://github.com/alexcameron89/awesome-controller/blob/master/app/controllers/awesome_controller/implicit_rendering.rb)
**Inspired By [ActionController::BasicImplicitRender](https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/metal/basic_implicit_render.rb)**

**ImplicitRendering** provides a way to render without explicitly calling `render` in your controller methods. It does so by checking to see if the controller has rendered, and if it has not, then it calls a default `render` method, here provided by the **Rendering** module.

### UrlFor - [Source Code](https://github.com/alexcameron89/awesome-controller/blob/master/app/controllers/awesome_controller/url_for.rb)
**Inspired By [ActionController::UrlFor](https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/metal/url_for.rb)**

**UrlFor** is a very simple module that extends the functionality of Rails Routing's **UrlFor**.

### Redirecting - [Source Code](https://github.com/alexcameron89/awesome-controller/blob/master/app/controllers/awesome_controller/redirecting.rb)
**Inspired By [ActionController::Redirecting](https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/metal/redirecting.rb)**

Redirecting a request requires 3 things:
1. A redirection status code (`3xx`)
2. A `Location` header set to the place we're redirecting to.
3. (This is Rails specific) We need to set the body. I'm not sure on the exact reason, but failing tests led me to think it's so we don't perform an implicit render; set the body so that it looks like it's rendered. Rails does this by [setting the body](https://github.com/rails/rails/blob/41758964e9515ae879fce0be687da2f5953bc950/actionpack/lib/action_controller/metal/redirecting.rb#L64) to "You are being redirected."

### Flash - [Source Code](https://github.com/alexcameron89/awesome-controller/blob/master/app/controllers/awesome_controller/flash.rb)
**Inspired By [ActionController::Flash](https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/metal/flash.rb)**

**Flash** provides a way to set flash messages on the request for `redirect_to` and provides a `notice` method for views to pull the flash information from the request. Very little code was needed here since the Flash implementation mostly lives on the request, provided by the [Flash middleware](https://github.com/rails/rails/blob/master/actionpack/lib/action_dispatch/middleware/flash.rb).

### Rendering - [Source Code](https://github.com/alexcameron89/awesome-controller/blob/master/app/controllers/awesome_controller/rendering.rb)
**Inspired By [AbstractController::Rendering](https://github.com/rails/rails/blob/master/actionpack/lib/abstract_controller/rendering.rb)**

**Rendering** provides a `render` method that connects with the Rails [**Action View**](https://github.com/rails/rails/tree/master/actionview) module to render html views. It does so by including the [**ActionView::Layouts**](https://github.com/rails/rails/blob/master/actionview/lib/action_view/layouts.rb) module and defining methods that the Layouts module expects from the controller, providing details that **Action View** needs to render HTML, like where the views live for AwesomeController (`/app/views`). 

### JsonRenderer - [Source Code](https://github.com/alexcameron89/awesome-controller/blob/master/app/controllers/awesome_controller/json_renderer.rb)
**Inspired By [ActionController::Renderers](https://github.com/rails/rails/blob/master/actionpack/lib/action_controller/metal/renderers.rb)**

**JsonRenderer** is where the rendering specific to JSON was stored. In the talk, I wrote the JSON rendering functionality directly in render for the **Api** class, but in the code, I created an abstract method of rendering, allowing both the **Api** and **Base** classes to use the same render method.

The **JsonRenderer** module defines `render_to_body`, one of the methods used in `render`, to provide the JSON rendering functionality.
