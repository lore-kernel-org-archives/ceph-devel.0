From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Mon, 11 Apr 2011 16:23:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104111618130.7812@cobra.newdream.net>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com> <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net> <4D9F367B.1070904@sandia.gov>
 <Pine.LNX.4.64.1104081343460.15928@cobra.newdream.net> <4D9F87F7.6090203@sandia.gov>
 <4DA3702B.4010808@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34333 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756350Ab1DKXTv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2011 19:19:51 -0400
In-Reply-To: <4DA3702B.4010808@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 11 Apr 2011, Jim Schutt wrote:
> Jim Schutt wrote:
> > Sage Weil wrote:
> > > On Fri, 8 Apr 2011, Jim Schutt wrote:
> 
> > > > So, in the short term I guess I need to run fewer cosd
> > > > instances per server.
> > > 
> > > There is one other thing to look at, and that's the number of threads used
> > > by each cosd process.  Have you tried setting
> > > 
> > >     osd op threads = 1
> > > 
> > > (or even 0, although I haven't tested that recently).  That will limit the
> > > number of concurrent IOs in flight to the fs.  Setting it to 0 will avoid
> > > using a thread pool at all and will process the IO in the message dispatch
> > > thread (though we haven't tested that recently so there may be issues).
> > 
> > I'll try this 2nd, since it's easy.
> > 
>      osd op threads = 0
> 
> didn't work for me at all - 20 of 96 OSDs aborted almost
> immediately after startup.
> 
>      osd op threads = 1
> 
> didn't work very well either - one of my servers went OOM,
> which hasn't happened since I started using my restricted
> buffering parameters.

Debugging this turned up a refcounting leak that meant PGs were never 
freed.  That's fixed (and osd op threads = 0 and 1 work in my limited 
tests), but there may be other PG lifecycle related issues now that 
refcounting actually works.  :)

sage
