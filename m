From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 07/13] libceph: embed ceph connection structure in
 mon_client
Date: Fri, 1 Jun 2012 09:39:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206010936441.9007@cobra.newdream.net>
References: <4FC673FC.3060004@inktank.com> <4FC67662.2060005@inktank.com>
 <Pine.LNX.4.64.1205312108540.2166@cobra.newdream.net> <4FC8B19D.2080204@inktank.com>
 <4FC8C410.3080703@inktank.com> <Pine.LNX.4.64.1206010918020.9007@cobra.newdream.net>
 <4FC8EEBA.5050402@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42294 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965514Ab2FAQj3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 12:39:29 -0400
In-Reply-To: <4FC8EEBA.5050402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Fri, 1 Jun 2012, Alex Elder wrote:
> On 06/01/2012 11:20 AM, Sage Weil wrote:
> > The problem is that socket events queue work, which can take a while, and
> > race with, say, osd_client getting an osdmap and dropping it's
> > struct ceph_osd.  The ->get and ->put ops just twiddle the containing
> > struct's refcount, in that case, so the con_work will find the (now
> > closed) ceph_connection and do nothing...
> 
> I think you're saying that the connection (or its socket) needs to
> be protected from its containing structure going away.  So the
> connection needs to hold a reference to its container.  If that's
> the case then the disposal of the ceph_osd needs to clean up
> the connection fully before it goes away.

Yeah.  I think it happens already before we drop the ref:

static void __remove_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
{
	dout("__remove_osd %p\n", osd);
	BUG_ON(!list_empty(&osd->o_requests));
	rb_erase(&osd->o_node, &osdc->osds);
	list_del_init(&osd->o_osd_lru);
	ceph_con_close(&osd->o_con);
	put_osd(osd);
}

So it's just the con reference in the workqueue that matters.

sage



> 
> Anyway, I think I see why there might be a need for the ref counts
> and they obviously won't go away if they're needed...
> 
> 					-Alex
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
