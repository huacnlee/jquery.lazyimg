jquery.lazyimg
==============

Lazyload image plugin for jQuery.
This project is fork from [jquery.unveil](https://github.com/luis-almeida/unveil), to improve performance with huge DOMs.

## Feature

- Lazyload images;
- Retina display support;
- Only 2 events binding (scroll, resize for responsive), even you call `lazyimg()` over again and again;
- No events binding on IMG elements;
- Very small, just 1.3 Kb (not compress);
- Very fast;
- Responsive page support.

## Changelogs

You can see all of the release notes in here: [Release notes](https://github.com/huacnlee/jquery.lazyimg/releases)

## Browser support

- Safari
- Chrome
- Firefox
- IE6+

## Demo

You can try the [Demo app](https://huacnlee.github.io/jquery.lazyimg).

## Usage

```html
<img class="lazy" src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-src="https://foo.bar/item1.jpg" data-src-retina="https://foo.bar/item1@2x.jpg" />
<img class="lazy" src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" data-src="https://foo.bar/item2.jpg" data-src-retina="https://foo.bar/item2@2x.jpg" />
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

Apache V2 : https://choosealicense.com/licenses/apache
