---
title: Sky
primary_navigation: true
---

# Sky

The sky is just a box that is very large and placed around the scene as a background. 
It can have a flat color, a gradient, or a 6 sided image mapped to it.

## Sample XML

```xml
<sky style="color: linear-gradient(#fff, #99f);" />
```

## Screenshot

<img src="/images/sky.png" class="screenshot" />

## Attributes

### src

Use the src attribute to specify a 6-sided image for the sky. SceneVR will automatically insert the prefixes back, front, left, right, top and bottom to your image url. For example the following markup:

```xml
<sky src='/sky/clouds_.jpg' />
```

Will cause scenevr to look for these images:

```
/sky/clouds_top.jpg
/sky/clouds_bottom.jpg
/sky/clouds_left.jpg
/sky/clouds_right.jpg
/sky/clouds_front.jpg
/sky/clouds_back.jpg
```

If any of the images is missing, the entire sky may fail to render.

## Styles

### color

For the sky, you can use `linear-gradient` to set a gradient (the start color is at the horizon, and the end color at the zenith of the sky. Otherwise you can just use a hexidecimal color.

