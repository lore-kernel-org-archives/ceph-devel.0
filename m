From: Sage Weil <sage@newdream.net>
Subject: Re: the state of cephfs in giant
Date: Mon, 13 Oct 2014 11:26:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410131122150.10568@cobra.newdream.net>
References: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net> <543C17F1.7060308@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57031 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbaJMS0u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Oct 2014 14:26:50 -0400
In-Reply-To: <543C17F1.7060308@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-users@ceph.com, ceph-devel@vger.kernel.org

On Mon, 13 Oct 2014, Wido den Hollander wrote:
> On 13-10-14 20:16, Sage Weil wrote:
> > With Giant, we are at a point where we would ask that everyone try
> > things out for any non-production workloads. We are very interested in
> > feedback around stability, usability, feature gaps, and performance. We
> > recommend:
> 
> A question to clarify this for anybody out there. Do you think it is
> safe to run CephFS on a cluster which is doing production RBD/RGW I/O?
> 
> Will it be the MDS/CephFS part which breaks or are there potential issue
> due to OSD classes which might cause OSDs to crash due to bugs in CephFS?
> 
> I know you can't fully rule it out, but it would be useful to have this
> clarified.

I can't think of any issues that this would cause with the OSDs.  CephFS 
isn't using any rados classes; just core rados functionality that RGW also 
uses.

On the monitor side, there is a reasonably probability of triggering a 
CephFS related health warning.  There is also the potential for code in 
the MDSMonitor.cc code to crash the mon, but I don't think we've seen any 
problems there any time recently.

So, probably safe.

sage
