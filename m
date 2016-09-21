From: John Spray <jspray@redhat.com>
Subject: Re: A design for CephFS forward scrub with multiple MDS
Date: Wed, 21 Sep 2016 14:45:01 +0100
Message-ID: <CALe9h7fCUQBV+Zfm_AYZebvHxvvzWsg5+GVNt-6bQmS8LS3N3g@mail.gmail.com>
References: <45C6F82E-6242-41CE-BBA6-1F5200E0B9BC@redhat.com>
 <CALe9h7cTGVVkkuKxc4CCRFC-xpyiPRfKXFj3i5Kof09Z3yfWhg@mail.gmail.com> <511F3635-C7D2-4F6B-9B0F-7AD9D9C9F7B2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35283 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755709AbcIUNpW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 09:45:22 -0400
Received: by mail-qk0-f173.google.com with SMTP id t7so45623729qkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 06:45:22 -0700 (PDT)
In-Reply-To: <511F3635-C7D2-4F6B-9B0F-7AD9D9C9F7B2@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Gregory Farnum <gfarnum@redhat.com>

On Wed, Sep 21, 2016 at 2:25 PM, Douglas Fuller <dfuller@redhat.com> wrote:
>
>>> Outbound scrub requests will need to be tracked and restarted in the case of MDS failure.
>>
>> One thing we didn't discuss was the backwards case, where I (an MDS)
>> am told by another MDS to scrub a subtree, but he fails before I can
>> tell him the result of my scrub.  Simplest thing seems to be to abort
>> scrubs in this case, and say that (for the moment) a scrub is only
>> guaranteed to complete if the MDS where it was initiated stays online?
>
> That makes sense as a first pass. For the future, we could resend the completion to the new subtree root owner after reconnecting and at least update the rstats. The scrub may even complete in that case.

Yes, although for the completely general case (including all MDSs
offline simultaneously) we would need to start persisting something.
Not sure if we'd ever want to do that silently inside the MDSs though,
as spending IOPs on scrub is probably not desired behaviour fresh from
a power cycle.  #futurework

John
