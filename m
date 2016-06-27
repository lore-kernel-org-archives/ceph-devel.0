From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: is the renewal in dentry_lease_is_valid necessary?
Date: Mon, 27 Jun 2016 13:11:11 -0700
Message-ID: <CAJ4mKGZe3RH8NsbiyhXMpOBsoban7GNUJ-d7_e=Jhi-QuUtBNA@mail.gmail.com>
References: <1467054441.25213.20.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34099 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbcF0ULN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2016 16:11:13 -0400
Received: by mail-vk0-f48.google.com with SMTP id c2so216586606vkg.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2016 13:11:12 -0700 (PDT)
In-Reply-To: <1467054441.25213.20.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Zheng Yan <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 27, 2016 at 12:07 PM, Jeff Layton <jlayton@redhat.com> wrote:
> I'm eyeballing how to make ceph dentry revalidation occur in rcu-walk
> mode in the kernel cephfs client. It looks fairly straightforward, but
> for one thing:
>
> dentry_lease_is_valid queues an asynchronous lease renewal if we're
> halfway to the next lease renewal time:
>
>         if (session) {
>                 ceph_mdsc_lease_send_msg(session, dir, dentry,
>                                          CEPH_MDS_LEASE_RENEW, seq);
>                 ceph_put_mds_session(session);
>         }
>
> That can sleep, so we have to drop out of rcu walk mode in that case.
>
> Is this lease renewal strictly necessary? I can make the code drop out
> of rcuwalk mode and try again in that case, but if this is just an
> opportunistic thing, then it may be better for performance to take a
> pass on renewing the lease early if we're still in RCU walk mode.

I'm just guessing based on the function names (and what I know of the
algorithms), but as long as something *else* will do the renewal, it
shouldn't need to be done here. There's nothing magic about half the
lease time.
-Greg
