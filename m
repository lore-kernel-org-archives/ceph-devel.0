From: Christoph Hellwig <hch@infradead.org>
Subject: Re: NewStore update
Date: Sun, 22 Feb 2015 07:51:53 -0800
Message-ID: <20150222155153.GA19387@infradead.org>
References: <alpine.DEB.2.00.1502191502030.14702@cobra.newdream.net>
 <20150221155058.GA14888@infradead.org>
 <alpine.DEB.2.00.1502210952130.14643@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47294 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbbBVPvy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Feb 2015 10:51:54 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1502210952130.14643@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Feb 21, 2015 at 09:53:45AM -0800, Sage Weil wrote:
> Ah, thanks. I guess in the buffered case though we won't block normally 
> anyway (unless we've hit the bdi dirty threshold).  So it's probably 
> either aio direct or buffered write + aio fsync, depending on the cache 
> hints?

buffered I/O will also block on:

 - acquiring i_mutex (do you plan on having parallel writers to the same
   file?)
 - reading in the page for read-modify-write cycles
 - waiting for writeback to finish for a previous write to the page

In adition to all the other ways even O_DIRECT aio could block (most
importantly block allocation)

I have a hacked prototype to do non-blocking writes similar to the
non-blocking reads we've been discussion on fsdevel for the last half
year.
