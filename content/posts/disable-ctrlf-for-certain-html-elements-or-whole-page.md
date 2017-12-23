---
date: 2012-03-11T06:00:00+00:00
title: Disable CTRL+F for Certain HTML Elements or Whole Page
aliases:
  - /post/30716192694/disable-ctrl-f-for-certain-html-elements-or-whole
  - /post/30716192694
---

<p>I plan on creating a web-based game where using CTRL+F to search for text on a page would be cheating. To stop this from happening, I created a jQuery plugin that stops certain HTML elements from being searched.</p>&#13;
<p><strong>View the <a href="https://github.com/seangransee/Disable-CTRL-F-jQuery-plugin" target="_blank">source code</a> to use it in your own project, and check out the <a href="http://seangransee.github.com/Disable-CTRL-F-jQuery-plugin/" target="_blank">demo</a> to see it in action.</strong></p>&#13;
<h3>How to use:</h3>&#13;
<p>Include <a href="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" target="_blank">jQuery</a> and <a href="https://raw.github.com/seangransee/Disable-CTRL-F-jQuery-plugin/master/disableFind.js" target="_blank">disableFind.js</a>.</p>&#13;
<script src="https://gist.github.com/3596236.js?file=index.html" type="text/javascript"></script><p>Call the disableFind() function on the element(s) you want to make unsearchable.</p>&#13;
<script src="https://gist.github.com/3596236.js?file=javascript.js" type="text/javascript"></script>
