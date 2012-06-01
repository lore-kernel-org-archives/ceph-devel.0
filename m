From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 07/13] libceph: embed ceph connection structure in
 mon_client
Date: Fri, 1 Jun 2012 10:10:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206011009430.9007@cobra.newdream.net>
References: <4FC673FC.3060004@inktank.com> <4FC67662.2060005@inktank.com>
 <Pine.LNX.4.64.1205312108540.2166@cobra.newdream.net> <4FC8F737.7080905@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53213 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760093Ab2FARKb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jun 2012 13:10:31 -0400
In-Reply-To: <4FC8F737.7080905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Fri, 1 Jun 2012, Alex Elder wrote:
> On 05/31/2012 11:24 PM, Sage Weil wrote:
> > Also: when poking around, I noticed that ceph_con_get() and put() are
> > called directly from osd_client.c... that's a bug!  Those connections have
> > a get and put op defined that twiddles the containing ceph_osd struct's
> > ref count.
> 
> So are you saying that the calls in "osd_client.c" to ceph_con_get()
> and ceph_con_put() should instead be calls to get_osd_con() and
> put_osd_con(), respectively?  (Or more generally con->ops->get()
> and con->ops->put()?)

Yeah.. one of the patches I pushed [er, and pushing now] fixes that.  

sage
