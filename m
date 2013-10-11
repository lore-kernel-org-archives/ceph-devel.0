From: David Howells <dhowells@redhat.com>
Subject: Re: hung task on page invalidate
Date: Fri, 11 Oct 2013 23:45:28 +0100
Message-ID: <7092.1381531528@warthog.procyon.org.uk>
References: <CANP1eJGYkrW1gUBf7D0_petBTPUgtnUG6Uc=WhUTY-rcYd4=aQ@mail.gmail.com> <CANP1eJGJMDB8hgegvncmsiXh3LtT029JWCs7rhaC=3P3GU97kQ@mail.gmail.com> <CAAM7YAkPRtcu=QFA1n-aO0sDdAp1mKX_YZjgtOg04EhNA26kFw@mail.gmail.com> <CANP1eJGu6nWgqLkBAAEEtvW8zJ4r5X+KJN3iiCMnN3x_mTkWaw@mail.gmail.com> <CANP1eJEpH-0_XhYmk3YUXt9aovQFTj3j1=YErXEVJiHm0Ceuzg@mail.gmail.com> <24718.1380818600@warthog.procyon.org.uk>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38029 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273Ab3JKWpd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 11 Oct 2013 18:45:33 -0400
In-Reply-To: <CANP1eJGYkrW1gUBf7D0_petBTPUgtnUG6Uc=WhUTY-rcYd4=aQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: dhowells@redhat.com, "Yan, Zheng" <ukernel@gmail.com>, "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Franklin Cheung <franklin.cheung@adfin.com>

Milosz Tanski <milosz@adfin.com> wrote:

> The patch that you sent me in private last week solved this issue and
> I haven't experienced it. I haven't seen the patch go into your
> linus-fs.git tree, so I don't know if you submitted the fix upstream
> to the linux kernel. So I'm following up to see if you plan are
> sending to mainline since it'll benefit all the fscache enabled
> filesystems.

Sorry, been fighting keyrings problems and computer problems.  I'll try to get
round to it on Monday.

David
