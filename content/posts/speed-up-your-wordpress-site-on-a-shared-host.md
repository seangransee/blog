---
date: 2012-03-09T06:00:00+00:00
title: Speed Up Your WordPress Site on a Shared Host
aliases:
  - /post/30716177955/speed-up-your-wordpress-site-on-a-shared-host
  - /post/30716177955
---

<p>If you’re serious about your website, <a href="http://www.nytimes.com/2012/03/01/technology/impatient-web-users-flee-slow-loading-sites.html?_r=3" target="_blank">you can’t afford long pageload times</a>. Unfortunately, most of us (myself included) don’t have the cash to drop on a dedicated server and are forced to use cheap, shared hosts that cost less than $150 a year. While these hosts are adequate for serving static content, they don’t do a great job at serving dynamic content from content management systems such as WordPress and Drupal. I was recently tasked with speeding up a site called <a href="http://www.alumtalks.com/" target="_blank">AlumTalks</a>, which runs on WordPress on a shared host. I tested many different plugins and services, and came up with a combination that works really well. Their home page used to take 15 seconds to load according to <a href="http://tools.pingdom.com/fpt/" target="_blank">Pingdom Tools</a>, and it now loads 50-90% faster.</p>&#13;
<p>Here are 3 tools that you can use in conjunction to speed up your WordPress site on a shared host.</p>&#13;
<h3>1. <a href="http://www.cloudflare.com/" target="_blank">CloudFlare</a></h3>&#13;
<div class="fluid-width-video-wrapper"><iframe frameborder="0" id="fitvid565364" src="http://player.vimeo.com/video/14700285?title=0&amp;byline=0&amp;portrait=0&amp;color=ffffff"></iframe></div>&#13;
<p>I’m a huge fan of <a href="http://www.cloudflare.com/" target="_blank">CloudFlare</a> because of the short set-up time and the number of enhancements it provides. It takes about 5 minutes to sign up for an account and activate it, and once that’s done it stays quietly out of the way. It also tries to keep your site online during a server crash, which is a huge benefit.</p>&#13;
<h3>2. <a href="http://wordpress.org/extend/plugins/wp-super-cache/" target="_blank">WP Super Cache</a></h3>&#13;
<p>This is my favorite WordPress caching plugin because it’s pretty easy to set up compared to some others and the performance increase is very noticeable. After you install and activate this <a href="http://wordpress.org/extend/plugins/wp-super-cache/" target="_blank">plugin</a>, there are a few steps you should take to maximize its performance.</p>&#13;
<p><strong>Turn caching on</strong></p>&#13;
<p>Switch to “Caching On” and click “Update Status”.</p>&#13;
<p><strong><a href="http://i.imgur.com/E57Sq.png" target="_blank"><img src="http://i.imgur.com/E57Sq.png" width="515" /></a></strong></p>&#13;
<p><strong>Advanced options</strong></p>&#13;
<p>Enable the following settings. Don’t forget to click “Update Status”.</p>&#13;
<p><a href="http://i.imgur.com/fOMIS.png" target="_blank"><img src="http://i.imgur.com/fOMIS.png" width="515" /></a></p>&#13;
<p>Once you save these settings, scroll down and you’ll see a giant yellow box. At the bottom of the box, click “Update Mod_Rewrite Rules” and the box will turn green.</p>&#13;
<p><a href="http://i.imgur.com/fjeon.png" target="_blank"><img height="35" src="http://i.imgur.com/fjeon.png" width="196" /></a></p>&#13;
<p><strong>Enable Preload mode</strong></p>&#13;
<p>Check the box for “Preload mode” and click “Update Settings”.</p>&#13;
<p><a href="http://i.imgur.com/k7EKC.png" target="_blank"><img src="http://i.imgur.com/k7EKC.png" width="515" /></a></p>&#13;
<p>That’s all the configuration you should need for this plugin. If you run into any problems, look at the descriptions of the options and disable some of them until your site is running smoothly. The options above should work on most shared hosts.</p>&#13;
<h3>3. <a href="http://wordpress.org/extend/plugins/jquery-image-lazy-loading/" target="_blank">jQuery lazy load plugin</a></h3>&#13;
<p>This is extremely useful for sites with lots of images, since images can be a huge bottleneck when loading a page. This <a href="http://wordpress.org/extend/plugins/jquery-image-lazy-loading/" target="_blank">plugin</a> makes it so that images aren’t loaded until they’re about to enter the viewport so they don’t all need to load when the page first loads. If a user only scrolls halfway through a page, the images on the bottom half are never loaded, saving valuable bandwidth. There is no configuration page for this plugin. Just install it and it works.</p>&#13;
<h3>Conclusion</h3>&#13;
<p>That’s it! Your website should now be noticeably faster and use less bandwidth. Now you don’t have to drop hundreds or thousands of dollars so have a well-performing WordPress site.</p>
