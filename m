From: Sage Weil <sweil@redhat.com>
Subject: Re: NewStore update
Date: Sat, 21 Feb 2015 09:53:45 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502210952130.14643@cobra.newdream.net>
References: <alpine.DEB.2.00.1502191502030.14702@cobra.newdream.net> <20150221155058.GA14888@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48379 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbbBURyM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 21 Feb 2015 12:54:12 -0500
In-Reply-To: <20150221155058.GA14888@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ceph-devel@vger.kernel.org

On Sat, 21 Feb 2015, Christoph Hellwig wrote:
> On Thu, Feb 19, 2015 at 03:50:45PM -0800, Sage Weil wrote:
> >  - assemble the transaction
> >  - start any aio writes (we could use O_DIRECT here if the new hints 
> > include WONTNEED?)
> 
> Note that kernel aio only is async if you specifiy O_DIRECT, otherwise
> io_submit will simply block.

Ah, thanks. I guess in the buffered case though we won't block normally 
anyway (unless we've hit the bdi dirty threshold).  So it's probably 
either aio direct or buffered write + aio fsync, depending on the cache 
hints?

sage
