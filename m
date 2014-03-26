From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 21:54:37 -0500
Message-ID: <5332416D.20600@ieee.org>
References: <1395736765.2823.29.camel@localhost>	 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>	 <53317BC2.9010700@ieee.org>	 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>	 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>	 <5331853D.40408@ieee.org> <1395767705.9967.5.camel@localhost>	 <5331C05D.1060008@ieee.org> <1395773582.2076.10.camel@localhost>	 <5331D2E8.6060002@ieee.org>	 <CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>	 <1395778894.2076.12.camel@localhost> <1395780835.2076.15.camel@localhost>	 <1395781847.2076.21.camel@localhost>	 <CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>	 <1395782577.2076.23.camel@localhost>	 <CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.co
 m>	 <1395783675.2076.26.camel@localhost>	 <CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>	 <1395784476.2076.28.camel@localhost> <1395785839.2076.30.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:51395 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbaCZCyS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 22:54:18 -0400
Received: by mail-qc0-f179.google.com with SMTP id m20so1876496qcx.24
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 19:54:17 -0700 (PDT)
In-Reply-To: <1395785839.2076.30.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <mailinglist@daevel.fr>, Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

OK, here's some more analysis of this one.  I'm pretty
convinced the object request in question has already
been freed/destroyed.  The real question is "why?"

On 03/25/2014 05:17 PM, Olivier Bonvalet wrote:
> Mar 25 23:14:45 rurkh kernel: [  330.054196] rbd_img_obj_callback: bad image object request information:
> Mar 25 23:14:45 rurkh kernel: [  330.054205] obj_request ffff88025f3df058
> Mar 25 23:14:45 rurkh kernel: [  330.054209]     ->object_name <(null)>
This can occur for an object request that has been destroyed.
After the name is freed, the field is set to NULL.

> Mar 25 23:14:45 rurkh kernel: [  330.054211]     ->offset 0
> Mar 25 23:14:45 rurkh kernel: [  330.054213]     ->length 4096
Given the image request, this makes sense as the second of
two object request in this image request.  (More on the offsets
below).

> Mar 25 23:14:45 rurkh kernel: [  330.054216]     ->type 0x1
This is OBJ_REQUEST_BIO.  Reasonable.

> Mar 25 23:14:45 rurkh kernel: [  330.054218]     ->flags 0x3
This means IMG_DATA and DONE are set.  It's an image object
(which is expected), and it's done (which is also expected,
because we're calling the callback function).

> Mar 25 23:14:45 rurkh kernel: [  330.054220]     ->which 4294967295
This is BAD_WHICH.  That value overwrites the original when
an image object request is removed from its image in
rbd_img_obj_request_del().

> Mar 25 23:14:45 rurkh kernel: [  330.054222]     ->xferred 4096
> Mar 25 23:14:45 rurkh kernel: [  330.054224]     ->result 0
> Mar 25 23:14:45 rurkh kernel: [  330.054227] img_request ffff8802731f8448
> Mar 25 23:14:45 rurkh kernel: [  330.054229]     ->snap 0xfffffffffffffffe
This is CEPH_NOSNAP.

> Mar 25 23:14:45 rurkh kernel: [  330.054231]     ->offset 2508181504
> Mar 25 23:14:45 rurkh kernel: [  330.054233]     ->length 16384
Offset is 0x957FD000, length 0x4000,  The first object request
should be (assuming 4MB objects) object 255, offset 0x3FD000,
length 0x3000 (or 12KB)  The second object request should be in
object 256, offset 0, length 0x1000 (or 4KB).

> Mar 25 23:14:45 rurkh kernel: [  330.054235]     ->flags 0x0
It is not layered nor initiated by a child image.  It was a read.

> Mar 25 23:14:45 rurkh kernel: [  330.054237]     ->obj_request_count 0
As objects are removed from an image request, the request count
is decremented until it's zero.  This suggests this image request
(which looks for the most part valid) has been destroyed (or at
least is in the process).

> Mar 25 23:14:45 rurkh kernel: [  330.054239]     ->next_completion 2
For an image request comprised of 2 object requests, this is
the right value when both of the object requests have completed.
The next completion (which will never occur) equals the object
request count (2).

> Mar 25 23:14:45 rurkh kernel: [  330.054241]     ->xferred 16384
This means the request transferred completely...

> Mar 25 23:14:45 rurkh kernel: [  330.054243]     ->result 0
...and was successful.


So, it looks like the image request completed successfully.  The
first and second object requests must have both passed through
rbd_img_obj_callback() in order for this to occur, and both of
them transferred all their data successfully.

However, at the time of this assertion failure, the callback
is being called for the already-completed second object
request.  Why?

The only place an object request's callback is called is in
rbd_obj_request_complete().  Olivier reports that these are
version 1 images and there is no layering involved.  So the
only place rbd_obj_request_complete() is called is from
rbd_osd_req_callback(), and then only if the object request
has been marked done by (in this case) rbd_osd_read_callback().
For a non-layered image object request, that always occurs
(after possibly zeroing all or part of the buffer).  So it
makes sense that these OSD read requests completed normally,
and triggered object request completion, and when both of
them had completed they caused the image request to complete.

This suggests that rbd_osd_req_callback() got called more
than once for that second object request.  That function is
called only via ceph_osd_request->r_callback(), and that
only occurs in net/ceph/osd_client.c:handle_reply().  It
only calls it if local variable already_completed is false.
That's set to the osd request's r_got_reply value, taken
while the OSD client' request mutex is held.

Any chance the osd client can be calling r_callback twice?

A second possibility is that the last object request
got duplicated somehow.  Right now I'm looking at
rbd_img_request_fill() and bio_chain_clone_range() to
see if I can see a way that could happen.

That's it for now.  I'm pretty sure this is getting
pretty close to the root cause.

					-Alex
