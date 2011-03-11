From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 11 Mar 2011 07:51:37 -0700
Message-ID: <1299855097.4750.382.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov>
 <1299686572.4750.329.camel@sale659.sandia.gov>
 <2E7A0FAAE7EA416896A1990C7A96D59A@gmail.com>
 <1299695809.4750.346.camel@sale659.sandia.gov>
 <144B52A5BA504DCB992CD253287A397A@gmail.com>
 <1299798589.4750.372.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103101515430.20133@cobra.newdream.net>
 <1299799936.4750.378.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103101538100.20133@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:40705 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab1CKOvs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2011 09:51:48 -0500
In-Reply-To: <Pine.LNX.4.64.1103101538100.20133@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Thu, 2011-03-10 at 16:40 -0700, Sage Weil wrote:
> > > Hmm, maybe.  I wouldn't expect this behavior from any allocator,
> though!
> > >
> > > Can you drill down a bit further and see if either of these is
> > > responsible?
> > >
> > >   virtual ~Message() {
> > >     assert(nref.read() == 0);
> > >     if (connection)
> > >       connection->put();
> > >     if (throttler)
> > >       throttler->put(payload.length() + middle.length() +
> data.length());
> > >   }
> > >
> > > (msg/Message.h)
> >
> > Hmmm, this is the patch I'm running to produce above.
> > It seems pretty definitive to me; am I missing something?
> 
>         delete this;
> 
> is calling the virtual destructor ~MOSDPing(), and then ~Message(),
> and
> only then releasing the memory to the allocator. 

Doh!!!  Sorry, I should have been doing more thinking
and less typing last night.

>  ~MOSDPing doesn't do
> anything, but ~Message adjusts the throttler (which involves a mutex
> that
> *shouldn't* be contended :) and a connection->put(), which calls
> ~Connection() and then releases memory.
> 
> My money is on the throttler, but let's see!

OK, I see what you're after.....

-- Jim

> 
> sage
> 


