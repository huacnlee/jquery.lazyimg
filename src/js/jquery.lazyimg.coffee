###
jquery.lazyimg
==============
version: 0.0.3

Jason Lee <huacnlee@gmail.com>
https://github.com/huacnlee/jquery.lazyimg

Lazyload image plugin for jQuery. This project is fork from jquery.unveil, to improve performance with huge DOMs.

## Feature

* Lazyload images;
* Retina display support;
* Only 2 events binding (scroll, resize for responsive), even you call lazyimg() over again and again;
* No events binding on IMG elements;
* Very small, just 1.3 Kb (not compress);
* Very fast;
* Responsive page support.

## Usage

```html
<div class="photos">
  <img class="lazy" src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-src="http://foo.bar/item1.jpg" data-src-retina="http://foo.bar/item1@2x.jpg" />
  <img class="lazy" src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-src="http://foo.bar/item2.jpg" data-src-retina="http://foo.bar/item2@2x.jpg" />
</div>
<script type="text/javascript">
$(".photos").lazyimg();
</script>
```

###
$ = jQuery
$.fn.extend
  lazyimg : (options) ->
    defaults =
      threshold: 100
    options = $.extend {}, defaults, options
    $w = $(window)
    th = options.threshold
    retina = window.devicePixelRatio > 1
    attrib = if retina then "data-src-retina" else "data-src"
    ie = if typeof(window.scrollY) == "number" then false else true

    onWindowScrollEvent = () ->
      clearTimeout(window._lazyimg_delay)
      window._lazyimg_delay = setTimeout(lazyimg, 150);

    onWindowResizeEvent = () ->
      clearTimeout(window._lazyimg_resize_delay)
      window._lazyimg_resize_delay = setTimeout(lazyimg, 1000);

    $imgs = $("img.lazy")
    lazyimg = () ->
      console?.time? "lazyimg"
      console?.profile? "lazyimg"
      if ie
        wt = $w.scrollTop()
        wb = wt + $w.height()
      else
        # http://jsperf.com/document-scrolltop-vs-native
        wt = window.scrollY
        # http://jsperf.com/jquery-height-vs-window-innerheight
        wb = wt + window.innerHeight

      inview = $imgs.filter ->
        $e = $(this)
        if ie
          if $e.attr("src") == ($e.attr(attrib) || $e.attr("data-src")) then return
          et = $e.offset().top
          eh = $e.data("lazyheight")
        else
          if this.getAttribute("src") == (this.getAttribute(attrib) || this.getAttribute("data-src")) then return
          # http://jsperf.com/offsettop-and-offsetleft-vs-jquery-s-offset/5
          # can not use this.offsetTop, this can not work with parent node is position: relative
          et = $e.offset().top
          eh = this.lazyheight

        if not eh
          if ie
            eh = $e.height()
            $e.data("lazyheight", eh)
          else
            eh = this.clientHeight
            this.lazyheight = eh
        eb = et + eh
        return eb >= wt - th && et <= wb + th

      inview.each ->
        if ie
          $this = $(this)
          source = $this.attr(attrib) || $this.attr("data-src")
          $this.attr("src", source) if source
        else
          source = this.getAttribute(attrib) || this.getAttribute("data-src")
          this.setAttribute("src", source) if source

      console?.timeEnd? "lazyimg"
      console?.profileEnd? "lazyimg"

    $w.off('scroll.lazyimg')
    $w.on('scroll.lazyimg', onWindowScrollEvent)

    if not ie
      $w.off('resize.lazyimg')
      $w.on('resize.lazyimg', onWindowResizeEvent)

    onWindowScrollEvent()
