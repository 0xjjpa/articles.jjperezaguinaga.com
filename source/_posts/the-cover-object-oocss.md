title: 'The “cover” object [OOCSS]'
tags:
  - bem
  - css
  - oocss
id: 354
categories:
  - Developer Stories
date: 2013-10-21 03:45:23
---

Last week I got some interesting feeds in my mailbox: [Forrst](http://forrst.com/) launched a new redesign, the long waited NodeJS powered blog platform [Ghost](http://ghost.org/) was finally public released, there's actually a [Jekyll Theme](http://incorporated.sendtoinc.com/) that doesn't look like a webpage from the 90's, and I founded an outstanding design in the form of [an amazing article about Russia](http://www.nytimes.com/newsgraphics/2013/10/13/russia/) from the New York Times (_and a[debate on whether this is a good or bad idea](http://css-tricks.com/art-directed-articles-still-good-idea/)_).

After opening each of those websites, I noticed this design trend that has been going on for some time, **an image with a caption or some sort of content over it**:

![Russia New York Times Article](https://dl.dropboxusercontent.com/u/23857782/cover-object/new-york-times-russia-article.png)
<small>New York Times Article on Russia<!--more--></small>

![Incorporated Jekyll Theme](https://dl.dropboxusercontent.com/u/23857782/cover-object/incorporated-jekyll-theme.png)
<small>Incorporated Jekyll Theme</small>

![Ghost Public Release!](https://dl.dropboxusercontent.com/u/23857782/cover-object/ghost-public-release.png)
<small>Ghost Features Page</small>

![Brangerg Personal Page picked on Forrst](https://dl.dropboxusercontent.com/u/23857782/cover-object/brangerg-personal-portfolio.png)
<small>Branberg Personal Portfolio found at Forrst</small>

I personally find this strategy quite effective. Using an image can create a beautiful effect for the copy in your webpages. As long as the image is related to your product, by overlaying on it a specific content, you can create a contrast between said content and the image, which then provides a **context** for your information while **emphasizing** the importance of it. This has become common in _app webpages_, which are webpages that their solely purpose is to introduce their product.

![Tikkio App Webpage](https://dl.dropboxusercontent.com/u/23857782/cover-object/tikkio-concert-webpage.png)
<small>Tikkio App webpage showcases a background image with people getting ready to enter a concert.</small>

This strategy is most commonly delivered through the `background-image`css property. It's usually a combination of the following:

*   A `position:absolute` element with `background` and `background-size: cover`.
*   A `position:relative` element with `background` and `background-size: cover`.
*   An element with `background` and `background-attachment: fixed` to provide the scrolling effect.
Although this is enough to effectively achieve the effect, there are[scenarios](http://stackoverflow.com/questions/492809/when-to-use-img-vs-css-background-image) where the `&lt;img&gt;` tag element might be better, specially when you want **your images to be included on print**, **a better performance on animations**, and any time **your images contain semantic value on your webpage**.

### Introducing the "cover" object

In OOCSS, an abstraction is a simple base object that can be constructed into a more powerful object. Some popular abstractions are the [media object](http://www.stubbornella.org/content/2010/06/25/the-media-object-saves-hundreds-of-lines-of-code/), crafted by [Nicole Sullivan](https://twitter.com/stubbornella), as well as the [island object](http://csswizardry.com/2011/10/the-island-object/), crafted by[Harry Roberts](https://twitter.com/csswizardry). We can see some of those implementations in frameworks such as [Bootstrap 3](http://getbootstrap.com/components/), and through browsable elements like[the Pattern Lab](http://demo.pattern-lab.info/) by [Brad Frost](https://twitter.com/brad_frost), I can guarantee you that more of those are coming.

The **cover object** is the name I came up for this _text over image_ trend, due it's similarity with book covers, that rely on the same introduction to attract readers and possible customers to get a book. If we come to think about it, books and webpages are using the same style to provide a first impression to the reader/user and prompt them to continue exploring it's content.

![Stephen King](http://upload.wikimedia.org/wikipedia/en/e/e9/Doctor_Sleep.jpg)

Whenever you want to use a semantic valid image as your _cover_ for your webpage, use the following markup.

    &lt;figure&gt;  
      &lt;img src="URL_TO_IMG" alt="IMG_ALT"&gt;
      &lt;figcaption&gt;
          &lt;!-- Your content goes here --&gt;
        ...
      &lt;/figcaption&gt;
    &lt;/figure&gt;  
    `</pre>
    Add the following CSS:
    <pre>`.cover__content {
      position: relative;
      margin: 0;
    }
    .cover__image {
      max-width: 100%;
    }
    .cover__text {
      left: 0;
      right: 0;
      margin: 0 auto;
      position: absolute;
      width: 100%;
      text-align: center;
    }

The first thing you might notice is the `&lt;figcaption&gt;` tag element. This is a way to tell our users that this specific content belongs to our [figure](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/figure)element. This element was introduced in HTML5 and it's the perfect tool to describe any information related to an image, just as captions work on real life magazines and newspapers.

The second thing is that the position absolute gives us perfect control on our text, so instead of working with magic numbers to position the text (e.g. `margin: 200px 100px`), we can use the `width` of the text and percentages to place our content responsively. So, if we want the content to always be centered in both x and y axis, just add a `bottom: 50%; width: 50%;` to it.

[Here's the codepen with the example](http://codepen.io/jjperezaguinaga/pen/njmtA):
<div></div>
In this example I added a [BEM](http://jjperezaguinaga.hostghost.io/the-cover-css-object/csswizardry.com/2013/01/mindbemding-getting-your-head-round-bem-syntax/) modifier for making the text always be on top. The class `cover__text--top` provides only the changes required for this specific element. You can then easily craft classes that suit better your needs, such as `cover__text--left`, `cover__text--bottom-left` and so on.

Because we can easily abstract this class from the markup, we don't need to have a specific image within the `&lt;figure&gt;` element. Because of the flexibility of the this element, we can include any kind of media to work as our cover. What about a [video](http://codepen.io/jjperezaguinaga/pen/diAKm)?
<div></div>

### Conclusion

There are multiple uses for this cover abstraction. For instance, in case you need to do a Slideshow, you can stuff multiple images inside the `&lt;figure&gt;` element. Put one image twice, and add `position:relative; float: left; visibility: hidden` to it. The other ones stay the same. The hidden one will work as your "holder" and will provide the `height` for the other absolute positioned ones, which then allows you through Javascript and CSS3 showcase some nice effects. Just add `overflow:hidden` to the `cover__content` class and you can get a easy captionable slideshow.

It's really up to you whether you use `background-image` or `&lt;img&gt;` to display a book cover effect for your webpage; I strongly believe that unless you need to perform a scrolling effect through `background-position` or `background-attachment`, you are better using an `&lt;img&gt;` tag. Some of the major downsizes of this approach is the lack of responsiveness in terms of image sources. While on pure image background css you can use a media query and **request, download and deliver the proper image according to the device it needs**, the `&lt;img&gt;` is lacking some love. There are some responses like the `srcset` property, and its [polyfill](https://github.com/borismus/srcset-polyfill).