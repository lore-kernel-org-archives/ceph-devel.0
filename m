From: Milosz Tanski <milosz@adfin.com>
Subject: Re: hung task on page invalidate
Date: Fri, 11 Oct 2013 15:09:09 -0400
Message-ID: <CANP1eJGYkrW1gUBf7D0_petBTPUgtnUG6Uc=WhUTY-rcYd4=aQ@mail.gmail.com>
References: <CANP1eJGJMDB8hgegvncmsiXh3LtT029JWCs7rhaC=3P3GU97kQ@mail.gmail.com>
	<CAAM7YAkPRtcu=QFA1n-aO0sDdAp1mKX_YZjgtOg04EhNA26kFw@mail.gmail.com>
	<CANP1eJGu6nWgqLkBAAEEtvW8zJ4r5X+KJN3iiCMnN3x_mTkWaw@mail.gmail.com>
	<CANP1eJEpH-0_XhYmk3YUXt9aovQFTj3j1=YErXEVJiHm0Ceuzg@mail.gmail.com>
	<24718.1380818600@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53752 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab3JKTJN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Oct 2013 15:09:13 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn3so1562830wib.5
        for <ceph-devel@vger.kernel.org>; Fri, 11 Oct 2013 12:09:12 -0700 (PDT)
In-Reply-To: <24718.1380818600@warthog.procyon.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Franklin Cheung <franklin.cheung@adfin.com>

David,

The patch that you sent me in private last week solved this issue and
I haven't experienced it. I haven't seen the patch go into your
linus-fs.git tree, so I don't know if you submitted the fix upstream
to the linux kernel. So I'm following up to see if you plan are
sending to mainline since it'll benefit all the fscache enabled
filesystems.

Thanks,
- Milosz

On Thu, Oct 3, 2013 at 12:43 PM, David Howells <dhowells@redhat.com> wrote:
> Milosz Tanski <milosz@adfin.com> wrote:
>
>> Stores : ops=10257 run=67477 pgs=57220 rxd=62216 olm=14
>
> I think this line probably shows the problem.  The olm=14 indicates that 14
> pages were found over the store limit set on the object.  Look in
> fscache_write_op() for:
>
>         if (page->index > op->store_limit) {
>                 fscache_stat(&fscache_n_store_pages_over_limit);
>                 goto superseded;
>         }
>
> If we find a page that's over the store limit, we immediately abandon the
> storage attempt - which is wrong.  We need to do something similar to
> fscache_end_page_write() but clearing COOKIE_PENDING_TAG - and then we need to
> continue and clear all pages over the limit.
>
> David
