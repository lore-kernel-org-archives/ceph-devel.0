From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: is the renewal in dentry_lease_is_valid necessary?
Date: Tue, 28 Jun 2016 21:03:39 +0800
Message-ID: <CAAM7YAm7qHJkKjXSiG2bz-D04uNVJTbDw4XbvZ9mnU==u9eT2Q@mail.gmail.com>
References: <1467054441.25213.20.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35508 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbcF1NDl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 09:03:41 -0400
Received: by mail-vk0-f46.google.com with SMTP id j2so20654774vkg.2
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 06:03:40 -0700 (PDT)
In-Reply-To: <1467054441.25213.20.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Zheng Yan <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jun 28, 2016 at 3:07 AM, Jeff Layton <jlayton@redhat.com> wrote:
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
>

dentry_lease_is_valid is the only place that renew lease. I think it's
better to drop out of rcuwalk and try again

Regards
Yan, Zheng


> --
> Jeff Layton <jlayton@redhat.com>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
