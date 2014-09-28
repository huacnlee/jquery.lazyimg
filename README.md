jquery.lazyimg
==============

Lazyload image plugin for jQuery.

## Changelogs

You can see all of the release notes in here: [Release notes](https://github.com/huacnlee/jquery.lazyimg/releases)

## Browser support

- Safari
- Chrome
- Firefox
- IE (No test), maybe 8+

## Demo

You can try the [Demo app](http://huacnlee.github.io/jquery.lazyimg).

## Usage

```html
<img class="lazy" src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-src="http://foo.bar/item1.jpg" data-src-retina="http://foo.bar/item1@2x.jpg" />
<img class="lazy" src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-src="http://foo.bar/item2.jpg" data-src-retina="http://foo.bar/item2@2x.jpg" />
<script type="text/javascript">
$("body").lazyimg();
</script>
```

## Build

```
$ bundle install
$ rake watch # or use "rake build" to release
``` 

## License

Apache V2 : http://choosealicense.com/licenses/apache
