# jquery.lazyimg
# Lazyload image plugin for jQuery.
# version: 0.0.2
# ==============================================
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
          if $e.attr("src") == $e.attr(attrib) then return
          et = $e.offset().top
          eh = $e.data("lazyheight")
        else
          if this.getAttribute("src") == this.getAttribute(attrib) then return
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
        $this = $(this)
        source = if ie then $this.attr(attrib) else this.getAttribute(attrib)
        if source
          if ie then $this.attr("src", source) else this.setAttribute("src", source)

      console?.timeEnd? "lazyimg"
      console?.profileEnd? "lazyimg"

    $w.off('scroll.lazyimg')
    $w.on('scroll.lazyimg', onWindowScrollEvent)
    
    if not ie
      $w.off('resize.lazyimg')
      $w.on('resize.lazyimg', onWindowResizeEvent)

    onWindowScrollEvent()
