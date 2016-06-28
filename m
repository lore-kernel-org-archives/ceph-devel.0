From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: is the renewal in dentry_lease_is_valid necessary?
Date: Tue, 28 Jun 2016 11:58:44 -0700
Message-ID: <CAJ4mKGboE8oaqb1KBCEULpADyaSFmNTO5w6A5nMm80-rqFS6aQ@mail.gmail.com>
References: <1467054441.25213.20.camel@redhat.com> <CAAM7YAm7qHJkKjXSiG2bz-D04uNVJTbDw4XbvZ9mnU==u9eT2Q@mail.gmail.com>
 <1467122456.32374.15.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34899 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbcF1S6p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 14:58:45 -0400
Received: by mail-vk0-f42.google.com with SMTP id j2so35098585vkg.2
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 11:58:45 -0700 (PDT)
In-Reply-To: <1467122456.32374.15.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Zheng Yan <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jun 28, 2016 at 7:00 AM, Jeff Layton <jlayton@redhat.com> wrote:
> On Tue, 2016-06-28 at 21:03 +0800, Yan, Zheng wrote:
>> On Tue, Jun 28, 2016 at 3:07 AM, Jeff Layton <jlayton@redhat.com> wrote:
>> >
>> > I'm eyeballing how to make ceph dentry revalidation occur in rcu-walk
>> > mode in the kernel cephfs client. It looks fairly straightforward, but
>> > for one thing:
>> >
>> > dentry_lease_is_valid queues an asynchronous lease renewal if we're
>> > halfway to the next lease renewal time:
>> >
>> >         if (session) {
>> >                 ceph_mdsc_lease_send_msg(session, dir, dentry,
>> >                                          CEPH_MDS_LEASE_RENEW, seq);
>> >                 ceph_put_mds_session(session);
>> >         }
>> >
>> > That can sleep, so we have to drop out of rcu walk mode in that case.
>> >
>> > Is this lease renewal strictly necessary? I can make the code drop out
>> > of rcuwalk mode and try again in that case, but if this is just an
>> > opportunistic thing, then it may be better for performance to take a
>> > pass on renewing the lease early if we're still in RCU walk mode.
>> >
>> dentry_lease_is_valid is the only place that renew lease. I think it's
>> better to drop out of rcuwalk and try again
>>
>> Regards
>> Yan, Zheng
>>
>
> That seems really odd to me.
>
> That call is only ever done in the d_revalidate codepath, so you'll
> only get a lease renewal when you have repeated path-based access to an
> existing dentry.
>
> Maybe this means that I don't really understand ceph leases. More
> questions...
>
> What exactly does the lease cover here?
>
> Shouldn't we be renewing it even if we're _not_ doing any path-based
> access? For instance, if I open a file and issue reads and writes
> against it, that doesn't involve pathnames and the lease doesn't get an
> explicit renewal. Doesn't it still need to be renewed though?

Ah. Leases cover the dentries, and are separate from the capabilities
covering file IO and the inode itself. So actually, no, if nobody is
doing dentry operations (directory listing, name resolution, etc) we
don't care.

This isn't a part of the protocol I'm very familiar with (it doesn't
really come up in userspace code), but that might mean it's easier to
understand if you look at the userspace version of it...?
-Greg
