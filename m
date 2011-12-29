From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/3] ceph: take a reference to the dentry in
 d_find_any_alias()
Date: Thu, 29 Dec 2011 09:54:50 -0500
Message-ID: <20111229145450.GA17192@infradead.org>
References: <1325124315-3487-1-git-send-email-sage@newdream.net>
 <1325124315-3487-3-git-send-email-sage@newdream.net>
 <20111229091108.GB5257@infradead.org>
 <1325169278.1131.65.camel@doink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:38330
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751929Ab1L2Oyx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Dec 2011 09:54:53 -0500
Content-Disposition: inline
In-Reply-To: <1325169278.1131.65.camel@doink>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: Christoph Hellwig <hch@infradead.org>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Thu, Dec 29, 2011 at 08:34:38AM -0600, Alex Elder wrote:
> Yes, that's the plan.  We were originally hoping to get
> this into 3.2 and I figured it was too late in the cycle
> to be suggesting a (albeit pretty harmless) change to
> the dcache code.
> 
> I will respin the patches.  I'll wait an hour or two
> to see what Sage plans to do with these.

I don't think getting the export in should be a problem.  Cc Al to make
sure, but IMHO this is still easily doable for 3.2.  It's a much smaller
change than duplicating all that code, too.
