From: Sage Weil <sweil@redhat.com>
Subject: Re: reducing buffer allocations
Date: Thu, 4 Feb 2016 17:47:57 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602041746380.28396@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1602041730260.28396@cpach.fuggernut.com> <20160204224009.GA22061@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38952 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934361AbcBDWrl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 4 Feb 2016 17:47:41 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 564D2BCFF2
	for <ceph-devel@vger.kernel.org>; Thu,  4 Feb 2016 22:47:41 +0000 (UTC)
In-Reply-To: <20160204224009.GA22061@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 4 Feb 2016, Adam C. Emerson wrote:
> On 04/02/2016, Sage Weil wrote:
> [snip]
> > (2) convert buffer::list into an intrusive_list, while embedding N
> > (=3) buffer::ptr's in the buffer::raw so that most buffers require only
> > 1 allocation (provided they aren't on more than N lists).
> [snip]
> > Do we want both, or just 1, or is there an alternative we should
> > consider?
> 
> Do we have any places in the code where we seek into a buffer::list that has a
> good number of buffer::ptrs in it? If so then we could get a speedup by
> switching from an intrusive list to an intrusive set (or avlset).

There are a very few, but not many.  They tend to be in debug code only.

Re: Allen's comment: we could use small_vector<> in combination with (1) 
too and probably get much of the benefit, but (1) + (2) should avoid 
the need for it at all...

sage
