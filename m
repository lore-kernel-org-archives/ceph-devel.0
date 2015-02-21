From: Christoph Hellwig <hch@infradead.org>
Subject: Re: NewStore update
Date: Sat, 21 Feb 2015 07:50:58 -0800
Message-ID: <20150221155058.GA14888@infradead.org>
References: <alpine.DEB.2.00.1502191502030.14702@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36516 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbbBUPu6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Feb 2015 10:50:58 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1502191502030.14702@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Feb 19, 2015 at 03:50:45PM -0800, Sage Weil wrote:
>  - assemble the transaction
>  - start any aio writes (we could use O_DIRECT here if the new hints 
> include WONTNEED?)

Note that kernel aio only is async if you specifiy O_DIRECT, otherwise
io_submit will simply block.
