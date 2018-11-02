# Blur-Distance-Blur-for-Unity-Postprocessing-Stack-v2

I was surprised by the lack of blur effect that works with Unity Postprocessing Stack v2, so here is one.

It has a simple blur version
![simpleblur](https://user-images.githubusercontent.com/10098032/47937148-e2007c00-def0-11e8-92ee-1e3ac6b0dd7c.JPG)

And a distance based one, that loosely mimics depth of field, but has no bokeh and has precise distance controls. Distance is in clip space, from 0 to 1, so it depends on the camera's near and far planes.
![distanceblur](https://user-images.githubusercontent.com/10098032/47937188-02303b00-def1-11e8-8bb5-f0248f2e3a86.JPG)

Made with Unity 2018.2.14
