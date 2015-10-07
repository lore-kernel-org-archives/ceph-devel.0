From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] O_DIRECT on deep-scrub read
Date: Wed, 7 Oct 2015 13:52:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510071349410.8667@cobra.newdream.net>
References: <56150598.1080604@sadziu.pl> <alpine.DEB.2.00.1510070748580.8667@cobra.newdream.net> <561577DD.1050107@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41784 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbbJGUwj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Oct 2015 16:52:39 -0400
In-Reply-To: <561577DD.1050107@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: =?ISO-8859-2?Q?Pawe=B3_Sadowski?= <ceph@sadziu.pl>, ceph-users <ceph-users@ceph.com>, ceph-devel@vger.kernel.org

On Wed, 7 Oct 2015, David Zafman wrote:
> 
> There would be a benefit to doing fadvise POSIX_FADV_DONTNEED after 
> deep-scrub reads for objects not recently accessed by clients.

Yeah, it's the 'except for stuff already in cache' part that we don't do 
(and the kernel doesn't give us a good interface for).  IIRC there was a 
patch that guessed based on whether the obc was already in cache, which 
seems like a pretty decent heuristic, but I forget if that was in the 
final version.

> I see the NewStore objectstore sometimes using the O_DIRECT  flag for writes.
> This concerns me because the open(2) man pages says:
> 
> "Applications should avoid mixing O_DIRECT and normal I/O to the same file,
> and especially to overlapping byte regions in the same file.  Even when the
> filesystem correctly handles the coherency issues in this situation, overall
> I/O throughput is likely to be slower than using either mode alone."

Yeah: an O_DIRECT write will do a cache flush on the write range, so if 
there was already dirty data in cache you'll write twice.  There's 
similarly an invalidate on read.  I need to go back through the newstore 
code and see how the modes are being mixed and how it can be avoided...

sage


> 
> David
> 
> On 10/7/15 7:50 AM, Sage Weil wrote:
> > It's not, but it would not be ahrd to do this.  There are fadvise-style
> > hints being passed down that could trigger O_DIRECT reads in this case.
> > That may not be the best choice, though--it won't use data that happens
> > to be in cache and it'll also throw it out..
> > 
> > On Wed, 7 Oct 2015, Pawe? Sadowski wrote:
> > 
> > > Hi,
> > > 
> > > Can anyone tell if deep scrub is done using O_DIRECT flag or not? I'm
> > > not able to verify that in source code.
> > > 
> > > If not would it be possible to add such feature (maybe config option) to
> > > help keeping Linux page cache in better shape?
> > > 
> > > Thanks,
> > > 
> > > -- 
> > > PS
> > > 
> > > _______________________________________________
> > > ceph-users mailing list
> > > ceph-users@lists.ceph.com
> > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > 
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
