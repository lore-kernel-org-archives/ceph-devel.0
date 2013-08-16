From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: debugging librbd async
Date: Fri, 16 Aug 2013 06:13:52 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B66498EC6@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B66498C5D@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308152206200.1479@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B66498DAD@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308152242310.1479@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:59199 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab3HPGN6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Aug 2013 02:13:58 -0400
In-Reply-To: <alpine.DEB.2.00.1308152242310.1479@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Sylvain Munaut (s.munaut@whatever-company.com)" <s.munaut@whatever-company.com>

> > > Of course, the old standby is to just crank up the logging detail and try
> > > to narrow down where the crash happens.  Have you tried that yet?
> >
> > I haven't touched the rbd code. Is increased logging a compile-time
> > option or a config option?
> 
> That is probably the first you should try then.  In the [client] section
> of ceph.conf on the node where tapdisk is running add something like
> 
>  [client]
>   debug rbd = 20
>   debug rados = 20
>   debug ms = 1
>   log file = /var/log/ceph/client.$name.$pid.log
> 
> and make sure the log directory is writeable.
> 

Excellent. How noisy are those levels likely to be?

Is it the consumer of librbd that reads those values? I mean all I need to do is restart tapdisk process and the logging should happen right?

> > > There is a probable issue with aio_flush and caching enabled that Mike
> > > Dawson is trying to reproduce.  Are you running with caching on or off?
> >
> > I have not enabled caching, and I believe it's disabled by default.
> 
> There is a fix for an aio hang that just hit the cuttlefish branch today
> that could conceivably be the issue.  It causes a hang on qemu but maybe
> tapdisk is more sensitive?  I'd make sure you're running with that in any
> case to rule it out.
> 

I switched to dumpling in the last few days to see if the problem existed there. Is the fix you mention in dumpling? I'm not yet running mission critical production code on ceph, just a secondary windows domain controller, secondary spam filter, and a few other machines that don't affect production if they crash.

I'm also testing valgrind at the moment, just basic memtest, but suddenly everything is quite stable even though it's under reasonable load right now. Stupid heisenbugs.

Thanks

James



