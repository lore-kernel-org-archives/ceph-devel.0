From: Sage Weil <sweil@redhat.com>
Subject: Re: inline vector container
Date: Wed, 3 Feb 2016 15:04:57 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602031503230.28963@cpach.fuggernut.com>
References: <CY1PR0201MB189757D3C50DF09DDD8F2877E8D00@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1687706043-1454529899=:28963"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37041 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbcBCUEm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Feb 2016 15:04:42 -0500
In-Reply-To: <CY1PR0201MB189757D3C50DF09DDD8F2877E8D00@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: ceph-devel@vger.kernel.org, mbenjami@redhat.com, cbodley@redhat.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1687706043-1454529899=:28963
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 3 Feb 2016, Allen Samuels wrote:
> One thing that the code base needs is a simple vector container that is
> optimized for a small number of elements, i.e., for small element counts we
> avoid the malloc/free overhead. But fully supports being resized into larger
> containers that are unbounded. Of course it will need to follow all of the
> proper object copy/move semantics so that things like unique_ptr, etc work
> correctly.
> 
> I heard rumors that there was one available in the boost world, but I can’t
> seem to find it. Do you know about one being available?

http://www.boost.org/doc/libs/1_60_0/doc/html/boost/container/small_vector.html

> I’ve been prototyping one myself, just to get re-familiar with all of the
> C++11 move sementics, and trivial constructors, etc.
> 
> The code is pretty complete, but the testing gets rather involved. There’s
> no reason to contain this if it’s available elsewhere. But if it isn’t I
> plan on continuing this…

I think Casey had prototyped something similar using a custom allocator, 
too, but I didn't actually look at the result.  And Matt talked about just 
pulling the boost one in-tree until we get updated boost in the supported 
distros, but I forget if he ran into problems there or not...

sage
--8323329-1687706043-1454529899=:28963--
