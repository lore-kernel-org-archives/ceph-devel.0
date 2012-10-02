From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] ceph: avoid 32-bit page index overflow
Date: Tue, 2 Oct 2012 12:32:25 -0400
Message-ID: <20121002163225.GA26594@infradead.org>
References: <506B0818.1040407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:60157
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755031Ab2JBQc0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 12:32:26 -0400
Content-Disposition: inline
In-Reply-To: <506B0818.1040407@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 02, 2012 at 10:28:24AM -0500, Alex Elder wrote:
> A pgoff_t is defined (by default) to have type (unsigned long).  On
> architectures such as i686 that's a 32-bit type.  The ceph address
> space code was attempting to produce 64 bit offsets by shifting a
> page's index by PAGE_CACHE_SHIFT, but the result was not what was
> desired because the shift occurred before the result got promoted
> to 64 bits.
> 
> Fix this by casting all uses of page->index used in this way to
> the desired 64-bit type.

It would be cleaner if you'd use the page_offset helper, which was
added to fix this problem without having to remember the right casts
everywhere.
