From: Sage Weil <sage@inktank.com>
Subject: RE: debugging librbd async
Date: Fri, 16 Aug 2013 08:57:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308160856010.26808@cobra.newdream.net>
References: <6035A0D088A63A46850C3988ED045A4B66498C5D@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1308152206200.1479@cobra.newdream.net> <6035A0D088A63A46850C3988ED045A4B66498DAD@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1308152242310.1479@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B66498EC6@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45926 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab3HPP5Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Aug 2013 11:57:16 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B66498EC6@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Sylvain Munaut (s.munaut@whatever-company.com)" <s.munaut@whatever-company.com>

On Fri, 16 Aug 2013, James Harper wrote:
> > > > Of course, the old standby is to just crank up the logging detail and try
> > > > to narrow down where the crash happens.  Have you tried that yet?
> > >
> > > I haven't touched the rbd code. Is increased logging a compile-time
> > > option or a config option?
> > 
> > That is probably the first you should try then.  In the [client] section
> > of ceph.conf on the node where tapdisk is running add something like
> > 
> >  [client]
> >   debug rbd = 20
> >   debug rados = 20
> >   debug ms = 1
> >   log file = /var/log/ceph/client.$name.$pid.log
> > 
> > and make sure the log directory is writeable.
> > 
> 
> Excellent. How noisy are those levels likely to be?
> 
> Is it the consumer of librbd that reads those values? I mean all I need 
> to do is restart tapdisk process and the logging should happen right?

That sound do it, yeah.

> > > > There is a probable issue with aio_flush and caching enabled that Mike
> > > > Dawson is trying to reproduce.  Are you running with caching on or off?
> > >
> > > I have not enabled caching, and I believe it's disabled by default.
> > 
> > There is a fix for an aio hang that just hit the cuttlefish branch today
> > that could conceivably be the issue.  It causes a hang on qemu but maybe
> > tapdisk is more sensitive?  I'd make sure you're running with that in any
> > case to rule it out.
> > 
> 
> I switched to dumpling in the last few days to see if the problem existed there. Is the fix you mention in dumpling? I'm not yet running mission critical production code on ceph, just a secondary windows domain controller, secondary spam filter, and a few other machines that don't affect production if they crash.

The fix is in the dumpling branch, but not in v0.67.  It will be in 
v0.67.1.
 
> I'm also testing valgrind at the moment, just basic memtest, but suddenly everything is quite stable even though it's under reasonable load right now. Stupid heisenbugs.

Valgrind makes things go very slow (~10x?), which can have a huge effect 
on timing. Sometimes that reveals new races, other times it hides others.  
:/

sage
