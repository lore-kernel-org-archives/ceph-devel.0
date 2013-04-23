From: Sage Weil <sage@inktank.com>
Subject: Re: Authentication question with RBD+STGT
Date: Mon, 22 Apr 2013 20:49:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304222049070.19511@cobra.newdream.net>
References: <51757CD2.2070404@liquidweb.com> <5175CAFF.3020509@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41290 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab3DWDtn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 23:49:43 -0400
In-Reply-To: <5175CAFF.3020509@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Scott Sullivan <ssullivan@liquidweb.com>, ceph-devel@vger.kernel.org

On Mon, 22 Apr 2013, Dan Mick wrote:
> On 04/22/2013 11:09 AM, Scott Sullivan wrote:
> > Referring to this:
> > http://ceph.com/dev-notes/adding-support-for-rbd-to-stgt/
> > 
> > I compiled the latest tgt with RBD support. My question is when using
> > this method to access RBD volumes, where do you tell it what user to
> > authenticate to the cluster with? I do see the above linked page
> > mentions it will read a local ceph.conf.
> 
> Yes, as Wido hints at, it passes NULL to rados_create()'s second arg; that
> means it will authenticate as client.admin.  This could certainly be easily
> fixed.

While we're talking about tgt, I think we should also switch this over to 
use the aio librbd calls instead of the sync ones.  It's functionally 
equivalent, but more efficient and cleaner.

sage

