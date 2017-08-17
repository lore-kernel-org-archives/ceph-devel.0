From: Gregory Farnum <gfarnum@redhat.com>
Subject: "ceph versions" dump (was Re: [Ceph-maintainers] [ceph-users] v12.1.4
 Luminous (RC) released)
Date: Thu, 17 Aug 2017 09:28:39 -0700
Message-ID: <CAJ4mKGaeF1NdkRr5grxS2LN2jxqXB4u1Nn+O-yLYbgF5tD4dMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:34319 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbdHQQ2l (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Aug 2017 12:28:41 -0400
Received: by mail-it0-f42.google.com with SMTP id f16so1590826itb.1
        for <ceph-devel@vger.kernel.org>; Thu, 17 Aug 2017 09:28:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@teradata.com>
Cc: Dan Mick <dmick@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 17, 2017 at 9:18 AM, Kamble, Nitin A
<Nitin.Kamble@teradata.com> wrote:
>
>
> On 8/16/17, 6:42 PM, "Dan Mick" <dmick@redhat.com> wrote:
>
>
>     >     >     "overall": {
>     >     >         "ceph version 12.1.0 (262617c9f16c55e863693258061c5b25dea5b086) luminous (dev)": 50,
>     >     >         "ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)": 3
>     >     >     }
>     >     > }
>     >     >
>     >     >
>     >     > # ceph-osd --version
>     >     > ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)
>     >     >
>     >     > Why is it showing old 12.1.0 version for the 50 osds, while all the nodes show ceph osd version as 12.1.4?
>     >
>     >     You didn't say you restarted the osds.  Did you?
>     >
>     > Yes, I did restart them, and that too more than once.
>
>     Dunno, then.  That seems impossible.
>
> It is showing the version of OSD before the upgrade.
> Is it possible the old version gets cached somewhere, and that is not getting updated after upgrade?

I looked at the source for this briefly yesterday and it did not seem
possible; the OSDs report their version as part of the "daemon
metadata" and that is committed to disk/paxos when they boot. It's
then read out of their to support this command.
If you could create a ticket at tracker.ceph.com for this, that would be good!
