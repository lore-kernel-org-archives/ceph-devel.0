From: David Howells <dhowells@redhat.com>
Subject: Re: hung task on page invalidate
Date: Thu, 03 Oct 2013 17:43:20 +0100
Message-ID: <24718.1380818600@warthog.procyon.org.uk>
References: <CANP1eJEpH-0_XhYmk3YUXt9aovQFTj3j1=YErXEVJiHm0Ceuzg@mail.gmail.com> <CANP1eJGJMDB8hgegvncmsiXh3LtT029JWCs7rhaC=3P3GU97kQ@mail.gmail.com> <CAAM7YAkPRtcu=QFA1n-aO0sDdAp1mKX_YZjgtOg04EhNA26kFw@mail.gmail.com> <CANP1eJGu6nWgqLkBAAEEtvW8zJ4r5X+KJN3iiCMnN3x_mTkWaw@mail.gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51974 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754003Ab3JCQnZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Oct 2013 12:43:25 -0400
In-Reply-To: <CANP1eJEpH-0_XhYmk3YUXt9aovQFTj3j1=YErXEVJiHm0Ceuzg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: dhowells@redhat.com, "Yan, Zheng" <ukernel@gmail.com>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Franklin Cheung <franklin.cheung@adfin.com>

Milosz Tanski <milosz@adfin.com> wrote:

> Stores : ops=10257 run=67477 pgs=57220 rxd=62216 olm=14

I think this line probably shows the problem.  The olm=14 indicates that 14
pages were found over the store limit set on the object.  Look in
fscache_write_op() for:

	if (page->index > op->store_limit) {
		fscache_stat(&fscache_n_store_pages_over_limit);
		goto superseded;
	}

If we find a page that's over the store limit, we immediately abandon the
storage attempt - which is wrong.  We need to do something similar to
fscache_end_page_write() but clearing COOKIE_PENDING_TAG - and then we need to
continue and clear all pages over the limit.

David
