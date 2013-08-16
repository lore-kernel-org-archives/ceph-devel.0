From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: debugging librbd async
Date: Fri, 16 Aug 2013 05:38:09 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B66498DAD@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B66498C5D@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308152206200.1479@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:57734 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab3HPFiP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Aug 2013 01:38:15 -0400
In-Reply-To: <alpine.DEB.2.00.1308152206200.1479@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Sylvain Munaut (s.munaut@whatever-company.com)" <s.munaut@whatever-company.com>

> 
> On Fri, 16 Aug 2013, James Harper wrote:
> > I'm testing out the tapdisk rbd that Sylvain wrote under Xen, and have
> > been having all sorts of problems as the tapdisk process is segfaulting. To
> > make matters worse, any attempt to use gdb on the resulting core just tells
> > me it can't find the threads ('generic error'). Google tells me that I can get
> > around this error by linking the main exe (tapdisk) with libpthread, but that
> > doesn't help.
> >
> > With strategic printf's I have confirmed that in most cases the crash
> > happens after a call to rbd_aio_read or rbd_aio_write and before the
> > callback is called. Given the async nature of tapdisk it's impossible to be sure
> > but I'm confident that the crash is not happening in any of the tapdisk code.
> > It's possible that there is an off-by-one error in a buffer somewhere with the
> > corruption showing up later but there really isn't a lot of code there and I've
> > been over it very closely and it appears quite sound.
> >
> > I have also tested for multiple complete's for the same request, and
> > corrupt pointers being passed into the completion routine, and nothing
> > shows up there either.
> >
> > In most cases there is nothing pre-empting the crash, aside from a
> > tendency to seemingly crash more often when the cluster is disturbed (eg a
> > mon node is rebooted). I have one VM which will be unbootable for long
> > periods of time with the crash happening during boot, typically when
> > postgres starts. This can be reproduced for hours and is useful for debugging,
> > but then suddenly the problem goes away spontaneously and I can no longer
> > reproduce it even after hundreds of reboots.
> >
> > I'm using Debian and the problem exists with both the latest cuttlefish and
> > dumpling deb's.
> >
> > So... does librbd have any internal self-checking options I can enable? If I'm
> > going to start injecting printf's around the place, can anyone suggest what
> > code paths are most likely to be causing the above?
> 
> This is usually about the time when we trying running things under
> valgrind.  Is that an option with tapdisk?

Never used it before. I guess I can find out pretty easy, I'll try that next.

> Of course, the old standby is to just crank up the logging detail and try
> to narrow down where the crash happens.  Have you tried that yet?

I haven't touched the rbd code. Is increased logging a compile-time option or a config option?

> 
> There is a probable issue with aio_flush and caching enabled that Mike
> Dawson is trying to reproduce.  Are you running with caching on or off?

I have not enabled caching, and I believe it's disabled by default.

Thanks

James
