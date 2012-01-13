From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 3/4] ceph: make session->s_cap_gen atomic
Date: Fri, 13 Jan 2012 12:32:33 -0800
Message-ID: <1326486753.3334.33.camel@doink>
References: <1326484207.3334.30.camel@doink>
	 <Pine.LNX.4.64.1201131153030.16683@cobra.newdream.net>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55552 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759089Ab2AMUce (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jan 2012 15:32:34 -0500
In-Reply-To: <Pine.LNX.4.64.1201131153030.16683@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Fri, 2012-01-13 at 11:56 -0800, Sage Weil wrote:
> On Fri, 13 Jan 2012, Alex Elder wrote:
> > The ceph_mds_session s_cap_gen field can be accessed concurrently
> > and is used for synchronization.  Change it to be an atomic_t to
> > make the desired atomicity explicit.
> > 
> > Signed-off-by: Alex Elder <elder@dreamhost.com>

. . .

> > @@ -2874,7 +2874,7 @@ void ceph_mdsc_lease_release(struct
> > ceph_mds_client *mdsc, struct inode *inode,
> >  	di = ceph_dentry(dentry);
> >  	if (!di || !di->lease_session ||
> >  	    di->lease_session->s_mds < 0 ||
> > -	    di->lease_gen != di->lease_session->s_cap_gen ||
> > +	    di->lease_gen != atomic_read(&di->lease_session->s_cap_gen) ||
> 
> Okay, this one needs synchronization.  It looks like the only one, too.  
> Can we just use the spinlock for it?

I'll rework the series.  I will change this one to just include
the use of the spinlock instead in this one spot, and will
drop the next one.

Thanks a lot for the review.

					-Alex

. . .

