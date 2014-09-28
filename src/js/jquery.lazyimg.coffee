# jquery.lazyimg
# Lazyload image plugin for jQuery.
# version: 0.0.1
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

    onWindowScrollEvent = () ->
      clearTimeout(window._lazyimg_delay)
      window._lazyimg_delay = setTimeout(lazyimg, 250);
      
    lazyimg = () ->
      $imgs = $("img.lazy")
      wt = $w.scrollTop()
      wb = wt + $w.height()
      
      inview = $imgs.filter ->
        $e = $(this)
        et = $e.offset().top
        eb = et + $e.height()

        return eb >= wt - th && et <= wb + th
        
      inview.each ->
        $this = $(this)
        source = $this.attr(attrib)
        source = source || $this.attr("data-src")
        if source
          $this.attr("src", source)
          $this.removeClass("lazy")
          
    $w.off('scroll.lazyimg')
    $w.on('scroll.lazyimg', onWindowScrollEvent)
    onWindowScrollEvent()
    
      
        
    