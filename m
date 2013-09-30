From: David Howells <dhowells@redhat.com>
Subject: Re: hung task on page invalidate
Date: Mon, 30 Sep 2013 14:56:04 +0100
Message-ID: <5858.1380549364@warthog.procyon.org.uk>
References: <CANP1eJGJMDB8hgegvncmsiXh3LtT029JWCs7rhaC=3P3GU97kQ@mail.gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49759 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754044Ab3I3N4I (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 Sep 2013 09:56:08 -0400
In-Reply-To: <CANP1eJGJMDB8hgegvncmsiXh3LtT029JWCs7rhaC=3P3GU97kQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: dhowells@redhat.com, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Franklin Cheung <franklin.cheung@adfin.com>

Milosz Tanski <milosz@adfin.com> wrote:

> In my test cluster I started seeing an issue when the fscache get
> stuck waiting on pending writes when doing page invalidate. The
> problem happens because it looks like the page never leaves the
> cookie->store page tree.
> 
> I've been reading the different code paths in fscache/page.c to
> understand why this could be the case, but on first look it looks like
> it does the correct thing. Do you have any ideas what could be causing
> this / where to look for the smoking gun.
> 
> I've only begun to see this recently, I think our work load on the
> test cluster changed a bit and it's been showing up more.

The most likely answer is that there's a race whereby a page is added to the
store tree, but the write-out operation isn't rescheduled.

David
