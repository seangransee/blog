---
date: 2012-03-07T06:00:00+00:00
title: How to Build an Elegant One-page Scrolling Website
aliases:
  - /post/30716164962/how-to-build-an-elegant-one-page-scrolling-website
  - /post/30716164962
---

<p>For my latest website, I decided to try something a little different. I wanted to take a stab at a single page design with multiple sections. I&rsquo;ve seen it done a few times before, but the style isn&rsquo;t even close to being commonplace.</p>
<p>There are a couple advantages to having a one-page website. First of all, it loads very quickly. Since you don&rsquo;t have to deal with a CMS or a database you can get away with just having one HTML file, one CSS file, and one Javascript file. Once the page is loaded, all the content can be accessed instantaneously because there are no additional pages to load. And finally, this type of design can look really elegant if done correctly.</p>
<p><a href="http://applause.seangransee.com/" target="_blank">View demo</a>&nbsp;&middot;&nbsp;<a href="https://github.com/seangransee/Applause-For-a-Cause" target="_blank">View source</a></p>
<p><a href="http://i.imgur.com/C9rYm.png" target="_blank"><img alt="screenshot" src="http://i.imgur.com/C9rYm.png" width="515" /></a></p>
<p>Here are a few things you can do to build a similar website. Be sure to reference the&nbsp;<a href="https://github.com/seangransee/Applause-For-a-Cause" target="_blank">source code</a>. This tutorial assumes intermediate knowledge of HTML, CSS, and Javascript.</p>
<h3>1. Keep the left side fixed in place.</h3>
<p>Here&rsquo;s how the page is set up. Inside our&nbsp;<code>#main</code>&nbsp;div, we have two divs with ids&nbsp;<code>#leftside</code>and&nbsp;<code>#rightside</code>.&nbsp;<code>#leftside</code>&nbsp;contains the navigation (and any other unmoving content) and<code>#rightside</code>&nbsp;contains all the content of the page. We also have our footer, which we&rsquo;ll get to later.</p>
<script src="https://gist.github.com/3612584.js?file=index1.html" type="text/javascript"></script>
<p>Now we need to style both of these divs to keep&nbsp;<code>#leftside</code>&nbsp;off to the side and in a fixed position. We&rsquo;re also going to fix the footer in the bottom right corner and hide it for now.</p>
<script src="https://gist.github.com/3612584.js?file=style1.css" type="text/javascript"></script>
<h3>2. Set up the navigation.</h3>
<p>We&rsquo;ll set up our navigation links as an unordered list, which you can then style however you&rsquo;d like.</p>
<script src="https://gist.github.com/3612584.js?file=index2.html" type="text/javascript"></script>
<p>Notice how instead of linking to pages, we&rsquo;re linking to ids. For example, clicking the Media link will scroll directly to whichever element has the id&nbsp;<code>media</code>. The first link has the class<code>current</code>&nbsp;because it corresponds to the page that will be visible when the page is loaded. You can use this to style the currently active section differently than the others in the navigation. Later, we&rsquo;ll make the&nbsp;<code>current</code>&nbsp;class switch to whichever section is visible.</p>
<h3>3. Put in the sections.</h3>
<p>Now we need to put in the sections, which will act as pseudo-pages.</p>
<script src="https://gist.github.com/3612584.js?file=index3.html" type="text/javascript"></script>
<p>We need to take care of some styling. Let&rsquo;s going to set the minimum height and bottom margin of the sections to 500px. That way, when there is very little content in a section it occupies a minimum of 1000 pixels to give it the appearance of being a full page. When there is a lot of content, there 500 pixels separating it from the next section so they don't run into each other.</p>
<script src="https://gist.github.com/3612584.js?file=style2.css" type="text/javascript"></script>
<h3>4. Make the scrolling magic happen.</h3>
<p>If you populate the sections with content, you&rsquo;ll notice that it looks like a multi-page site if you ignore the tiny scrollbar. You click on a navigation link, and it instantly takes you to the corresponding section. Now let&rsquo;s make this page a little more elegant by making the navigation links&nbsp;<em>scroll</em>&nbsp;to the sections instead of jumping to them.</p>
<p>I created a&nbsp;<a href="https://github.com/seangransee/Applause-For-a-Cause/blob/master/plugins.js" target="_blank">plugins.js</a>&nbsp;file and copied in the following Javascript plugins. Feel free to use my plugins file. I combined them all into one file to minimize the number of HTTP requests, causing the page to load slightly faster.</p>
<ul>
<li><a href="http://jquery.com/" target="_blank">jQuery</a></li>
<li><a href="https://github.com/davist11/jQuery-One-Page-Nav/blob/master/jquery.nav.js" target="_blank">jQuery One Page Nav Plugin</a></li>
<li><a href="https://github.com/davist11/jQuery-One-Page-Nav/blob/master/jquery.scrollTo.js" target="_blank">jQuery.ScrollTo</a></li>
<li><a href="https://github.com/tuupola/jquery_lazyload/blob/master/jquery.lazyload.min.js" target="_blank">Lazy Load</a>&nbsp;(not necessary for this part, but this will come up later)</li>
</ul>
<p>By sure to include this Javascript file in your&nbsp;<a href="https://github.com/seangransee/Applause-For-a-Cause/blob/master/index.html" target="_blank">index.html</a>&nbsp;file by putting the following code somewhere in the&nbsp;<code>&lt;head&gt;</code>:</p>
<script src="https://gist.github.com/3612584.js?file=index4.html" type="text/javascript"></script>
<p>Also include the following code in the&nbsp;<a href="https://github.com/seangransee/Applause-For-a-Cause/blob/master/index.html" target="_blank">index.html</a>&nbsp;file inside a&nbsp;<code>&lt;script&gt;</code>&nbsp;tag to make it work with the navigation links.</p>
<script src="https://gist.github.com/3612584.js?file=index5.html" type="text/javascript"></script>
<p>Now, when you click on a navigation link, the browser will automatically scroll to the correct section.</p>
<h3>5. Lazy Load the images.</h3>
<p>My&nbsp;<a href="http://applause.seangransee.com/">site</a>&nbsp;has a lot of images, which can slow down the loading of the page. To fix this, we&rsquo;ll use a jQuery plugin called&nbsp;<a href="https://github.com/tuupola/jquery_lazyload/blob/master/jquery.lazyload.min.js" target="_blank">Lazy Load</a>. This will make certain images not load until they&rsquo;re scrolled into the viewport. You can optionally make them fade into view instead of instantly appearing, which I think fits with the aesthetic of the site. Make sure the Lazy Load plugin is included in your&nbsp;<a href="https://github.com/seangransee/Applause-For-a-Cause/blob/master/plugins.js" target="_blank">plugins.js</a>&nbsp;file.</p>
<p>Normally when you have an image you&rsquo;d do it like this:</p>
<script src="https://gist.github.com/3612584.js?file=index6.html" type="text/javascript"></script>
<p>For the images you want to work with the Lazy Load plugin, you&rsquo;ll have to change it to this:</p>
<script src="https://gist.github.com/3612584.js?file=index7.html" type="text/javascript"></script>
<p>Let&rsquo;s take a look at what we did here. We set the src of the image to&nbsp;<a href="https://github.com/seangransee/Applause-For-a-Cause/raw/master/img/place.gif" target="_blank">img/place.gif</a>, which is a transparent 1x1px image. This is because you need an image as a placeholder, but nothing needs to be seen before the image is in the viewport. The actual image is placed in&nbsp;<code>data-original</code>. When the image comes into the viewport, the Lazy Load plugin replaces the value of&nbsp;<code>src</code>&nbsp;with the value of&nbsp;<code>data-original</code>. The&nbsp;<code>&lt;noscript&gt;</code>&nbsp;tag allows browsers without Javascript to still show the images.</p>
<p>Now we need a bit of Javascript to activate the plugin. Add the following code inside your<code>&lt;script&gt;</code>&nbsp;in&nbsp;<a href="https://github.com/seangransee/Applause-For-a-Cause/blob/master/index.html" target="_blank">index.html</a>.</p>
<script src="https://gist.github.com/3612584.js?file=index8.html" type="text/javascript"></script>
<h3>6. Fade out elements that don&rsquo;t fit.</h3>
<p>Remember the footer we added in before? We had it hidden by default, but with no explanation. Here comes the explanation. When the page loads, the footer will overlap the content if the user&rsquo;s screen isn&rsquo;t big enough (or if they have the window resized too small). We only want to display the footer if there&rsquo;s enough extra room. Add the following code to your<code>&lt;script&gt;</code>:</p>
<script src="https://gist.github.com/3612727.js?file=index9.html" type="text/javascript"></script>
<p>Now let&rsquo;s walk through what we just did there. We created a function called<code>handleDisplay()</code>&nbsp;which fades the footer in or out based on the size of the viewport. The number&nbsp;<code>1263</code>&nbsp;was determined through trial and error, and will be different for you depending on the size of your content and the size of the footer. Then we have event handlers to call<code>handleDisplay()</code>&nbsp;whenever the window is loaded or resized. Check out the&nbsp;<a href="http://seangransee.github.com/Applause-For-a-Cause/" target="_blank">demo</a>&nbsp;for a more concrete example. If you never see a footer even when the window is maximized, your screen is too small to display it. If you see a footer (it&rsquo;s in the bottom-right corner), resize the window until it collides with the content and watch it disappear. Just like magic.</p>
<h3>Conclusion</h3>
<p>You&rsquo;ve just learned how to make a single page with navigation buttons that scroll to their respective sections when they&rsquo;re clicked. You also learned how to have images fade into view when they are scrolled into view and how to hide elements that don&rsquo;t fit on the page. While these don&rsquo;t necessarily need to be used in conjunction, you can combine them to make a pretty elegant website.</p>
<p>Be sure to reference the&nbsp;<a href="http://applause.seangransee.com/" target="_blank">demo</a>&nbsp;and&nbsp;<a href="https://github.com/seangransee/Applause-For-a-Cause" target="_blank">source code</a>&nbsp;if you want to try it on your own. Happy coding!</p>
