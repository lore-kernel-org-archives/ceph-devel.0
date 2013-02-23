From: Alexandre Marangone <alexandre.marangone@inktank.com>
Subject: Re: [Ceph - Feature #4230] (New) librados: node.js bindings
Date: Sat, 23 Feb 2013 12:49:40 -0800
Message-ID: <CAP-Tmqg4CBeJdncpueeScXXV48oYQJ9BzB=uHpyJpYahWbXptg@mail.gmail.com>
References: <redmine.issue-4230.20130222104241@tracker.ceph.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:49021 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757340Ab3BWUtm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Feb 2013 15:49:42 -0500
Received: by mail-wg0-f51.google.com with SMTP id 8so1386926wgl.18
        for <ceph-devel@vger.kernel.org>; Sat, 23 Feb 2013 12:49:41 -0800 (PST)
In-Reply-To: <redmine.issue-4230.20130222104241@tracker.ceph.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: redmine@tracker.ceph.com
Cc: ceph-devel@vger.kernel.org

Hi Wido,

Also cc'ing ceph-devel.

Few months ago I started to write node bindings to librados. No
specific use case either, just curious to learn a little bit more
about v8 and librados.

My first work was to do a 1:1 wrapping, but it wasn't javascripty enough.
I started over and was able to do stuff like:
var librados = require('./build/Release/nrados');
var rados = new librados.Rados({
   'user': 'admin',
   'keyring': '/etc/ceph/keyring',
   'monitors': '[ 192.168.0.20 ]'
});

var ioctx = new librados.IoCtx();
rados.connect(function (err) {
   if (err)
       throw err;
   rados.ioctx_create('mypool', ioctx, function (err) {
     if (err)
       throw err;
     ioctx.write_full('myobject1', 'aa');
   });
});
Which is better, but still, clumsy (I want to get rid of ioctx_create).
I need to put some thoughts into the overall design.

I didn't touch the code for about two months, and couldn't find it
this morning. As soon as I figure out where it is, I'll create a
github repo.

Of course, thoughts and suggestions are welcome.

--
Alexandre

On Fri, Feb 22, 2013 at 2:42 AM,  <redmine@tracker.ceph.com> wrote:
> Issue #4230 has been reported by Wido den Hollander.
> ________________________________
>
> Feature #4230: librados: node.js bindings
>
> Author: Wido den Hollander
> Status: New
> Priority: Low
> Assignee:
> Category: librados
> Target version:
> Source: Community (dev)
> Tags:
> Reviewed:
>
> Although I don't have a use-case at this specific point it would be very
> cool to have node.js bindings.
>
> From the docs it seems pretty simple to write these bindings and make cool
> stuff with it.
>
> I'm just opening the feature here so that it shows up and can be picked up:
>
> Some reference docs:
>
> http://nodejs.org/api/addons.html#addons_wrapping_c_objects
> http://www.slideshare.net/nsm.nikhil/writing-native-bindings-to-nodejs-in-c
> https://github.com/nikhilm/jsfoo-pune-2012
>
> Without bindings you would be able to use node-ffi, but I think native
> bindings would be cleaner: https://github.com/rbranson/node-ffi
>
> ________________________________
>
> You have received this notification because you have either subscribed to
> it, or are involved in it.
> To change your notification preferences, please click here:
> http://tracker.ceph.com/my/account
