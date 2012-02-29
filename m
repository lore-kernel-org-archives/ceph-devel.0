From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] ceph: use a shared zero page rather than one per
 messenger
Date: Tue, 28 Feb 2012 23:18:51 -0500
Message-ID: <20120229041851.GA1865@infradead.org>
References: <4F4D962E.7020304@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:56262
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752207Ab2B2ESx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Feb 2012 23:18:53 -0500
Content-Disposition: inline
In-Reply-To: <4F4D962E.7020304@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Feb 28, 2012 at 07:06:22PM -0800, Alex Elder wrote:
> Each messenger allocates a page to be used when writing zeroes
> out in the event of error or other abnormal condition.  Just
> allocate one at initialization time and have them all share it.

Any reason you don't simply use the kernel-wide ZERO_PAGE()?

