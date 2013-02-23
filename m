From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: [Ceph - Feature #4230] (New) librados: node.js bindings
Date: Sat, 23 Feb 2013 14:15:19 -0800
Message-ID: <12FAC6A7-962C-4E06-8041-7C69CA827F7F@inktank.com>
References: <redmine.issue-4230.20130222104241@tracker.ceph.com> <CAP-Tmqg4CBeJdncpueeScXXV48oYQJ9BzB=uHpyJpYahWbXptg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f54.google.com ([209.85.210.54]:60543 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758512Ab3BWWPS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Feb 2013 17:15:18 -0500
Received: by mail-da0-f54.google.com with SMTP id p1so318551dad.27
        for <ceph-devel@vger.kernel.org>; Sat, 23 Feb 2013 14:15:17 -0800 (PST)
In-Reply-To: <CAP-Tmqg4CBeJdncpueeScXXV48oYQJ9BzB=uHpyJpYahWbXptg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Marangone <alexandre.marangone@inktank.com>
Cc: ceph-devel@vger.kernel.org


On Feb 23, 2013, at 12:49 PM, Alexandre Marangone <alexandre.marangone@inktank.com> wrote:

> Of course, thoughts and suggestions are welcome.

Oo, this is nice. A while back I built a cls_v8 object class to play with, but never got around to working on a front-end. The motivation was to be able to write things like this in the client:

App.js
------

function plugin() {

  function helper(args) {
    /* do stuff */
  }

  function handler1(input, output) {
    /* do stuff */
  }

  function handler2(input, output) {
    /* do stuff */
  }

}

/* serialize the plugin as a string */
var myplugin = plugin.toString();

rados.ioctx_create('mypool', ioctx, function (err) {
  if (err)
    throw err;

  command = {
    'script': myplugin,
    'handler': 'handler1',
    'input': 'hello',
  };

  /* run the plugin in OSD using V8 JIT compilation */
  ioctx.exec('myobject1', 'cls_v8', 'eval', command);

});

- Noah

> --
> Alexandre
> 
> On Fri, Feb 22, 2013 at 2:42 AM,  <redmine@tracker.ceph.com> wrote:
>> Issue #4230 has been reported by Wido den Hollander.
>> ________________________________
>> 
>> Feature #4230: librados: node.js bindings
>> 
>> Author: Wido den Hollander
>> Status: New
>> Priority: Low
>> Assignee:
>> Category: librados
>> Target version:
>> Source: Community (dev)
>> Tags:
>> Reviewed:
>> 
>> Although I don't have a use-case at this specific point it would be very
>> cool to have node.js bindings.
>> 
>> From the docs it seems pretty simple to write these bindings and make cool
>> stuff with it.
>> 
>> I'm just opening the feature here so that it shows up and can be picked up:
>> 
>> Some reference docs:
>> 
>> http://nodejs.org/api/addons.html#addons_wrapping_c_objects
>> http://www.slideshare.net/nsm.nikhil/writing-native-bindings-to-nodejs-in-c
>> https://github.com/nikhilm/jsfoo-pune-2012
>> 
>> Without bindings you would be able to use node-ffi, but I think native
>> bindings would be cleaner: https://github.com/rbranson/node-ffi
>> 
>> ________________________________
>> 
>> You have received this notification because you have either subscribed to
>> it, or are involved in it.
>> To change your notification preferences, please click here:
>> http://tracker.ceph.com/my/account
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

