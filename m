From: David Butterfield <dab21774@gmail.com>
Subject: Re: global backfill reservation?
Date: Sat, 20 May 2017 21:34:28 -0600
Message-ID: <CALiN7rxAHTWEv+c5=10jWWAuYS0tDW9CZ_R_ZCiGf3SZvUrG1w@mail.gmail.com>
References: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal> <CALZt5jxT8WvD9hiPVf_YUy3pxWR3pgHW0ZiQo2+YyeiB=Jya_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36596 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756291AbdEUDea (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 20 May 2017 23:34:30 -0400
Received: by mail-vk0-f50.google.com with SMTP id p85so27458786vkd.3
        for <ceph-devel@vger.kernel.org>; Sat, 20 May 2017 20:34:30 -0700 (PDT)
In-Reply-To: <CALZt5jxT8WvD9hiPVf_YUy3pxWR3pgHW0ZiQo2+YyeiB=Jya_Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, May 20, 2017 at 8:24 AM, Ning Yao <zay11022@gmail.com> wrote:
> so it seems pretty reasonable to do it
> with dynamic QoS strategy and serve the user IO first at anytime. Only
> in this way, it can achieve the final goal for this issue.

But part of the final goal is to minimize unhappiness including from loss
of data after a double failure, which means completing a timely recovery.
Giving strict priority to user I/O could starve recovery indefinitely.  Some
systems are *always* busy.

It seems likely to result in highly variable and unpredictable recovery times.
I think unpredictability about when their data "will be fully protected again"
is a source of anxiety for customers, if it can take more than a few hours.

One nice thing about controlling with queue depth is that it self-adjusts to
the load.  If the network and peer machine are idle, the operations will flow
at their maximum rate for a given queue depth (IOPS = QD / RTT, the
round-trip time of the entire circuit of the network and the peer service
together).

But if other load is present on the network or on the peer CPU, its requested
operations will interleave with the recovery I/O; this drives up RTT (by
slowing the peer server and/or delaying the network), automatically reducing
IOPS without adjusting Queue Depth.  Under high client load there will be
many client I/O operations for each recovery operation.

The Queue Depth can still be adjusted to set the overall aggressiveness
of the recovery process.
