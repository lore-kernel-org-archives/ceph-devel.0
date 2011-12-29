From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 2/3] ceph: take a reference to the dentry in
 d_find_any_alias()
Date: Thu, 29 Dec 2011 08:34:38 -0600
Message-ID: <1325169278.1131.65.camel@doink>
References: <1325124315-3487-1-git-send-email-sage@newdream.net>
	 <1325124315-3487-3-git-send-email-sage@newdream.net>
	 <20111229091108.GB5257@infradead.org>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55193 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab1L2Oel (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Dec 2011 09:34:41 -0500
In-Reply-To: <20111229091108.GB5257@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Thu, 2011-12-29 at 04:11 -0500, Christoph Hellwig wrote:
> On Wed, Dec 28, 2011 at 06:05:14PM -0800, Sage Weil wrote:
> > From: Alex Elder <elder@dreamhost.com>
> > 
> > The ceph code duplicates __d_find_any_alias(), but it currently
> > does not take a reference to the returned dentry as it should.
> > Replace the ceph implementation with an exact copy of what's
> > found in "fs/dcache.c", and update the callers so they drop
> > their reference when they're done with it.
> > 
> > Unfortunately this requires the wholesale copy of the functions
> > that implement __dget().  It would be much nicer to just export
> > d_find_any_alias() from "fs/dcache.c" instead.
> 
> Just exporting it would indeed be much better.

Yes, that's the plan.  We were originally hoping to get
this into 3.2 and I figured it was too late in the cycle
to be suggesting a (albeit pretty harmless) change to
the dcache code.

I will respin the patches.  I'll wait an hour or two
to see what Sage plans to do with these.

					-Alex

