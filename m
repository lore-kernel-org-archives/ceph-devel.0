From: John Spray <jspray@redhat.com>
Subject: Re: [ceph-users] fsping, why you no work no mo?
Date: Sun, 16 Apr 2017 22:57:01 +0100
Message-ID: <CALe9h7e9Q7+MnxG+Lgoq64AiCNOmFZrHwzf+iUjV5fwe__N-Rg@mail.gmail.com>
References: <CABZ+qqnUUxq-OVTs6MFYVqnDZdmWqPzq0TjCePAjZtnKGD0E-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36690 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756638AbdDPV5X (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Apr 2017 17:57:23 -0400
Received: by mail-wr0-f177.google.com with SMTP id c55so75012112wrc.3
        for <ceph-devel@vger.kernel.org>; Sun, 16 Apr 2017 14:57:22 -0700 (PDT)
In-Reply-To: <CABZ+qqnUUxq-OVTs6MFYVqnDZdmWqPzq0TjCePAjZtnKGD0E-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On Thu, Apr 13, 2017 at 6:41 PM, Dan van der Ster <dan@vanderster.com> wrote:
> Dear ceph-*,
>
> A couple weeks ago I wrote this simple tool to measure the round-trip
> latency of a shared filesystem.
>
>    https://github.com/dvanders/fsping
>
> In our case, the tool is to be run from two clients who mount the same
> CephFS.
>
> First, start the server (a.k.a. the ping reflector) on one machine in a
> CephFS directory:
>
>    ./fsping --server
>
> Then, from another client machine and in the same directory, start the
> fsping client (aka the ping emitter):
>
>     ./fsping --prefix <prefix from the server above>
>
> The idea is that the "client" writes a syn file, the reflector notices it,
> and writes an ack file. The time for the client to notice the ack file is
> what I call the rtt.
>
> And the output looks like normal ping, so that's neat. (The README.md shows
> a working example)
>
>
> Anyway, two weeks ago when I wrote this, it was working very well on my
> CephFS clusters (running 10.2.5, IIRC). I was seeing ~20ms rtt for small
> files, which is more or less what I was expecting on my test cluster.
>
> But when I run fsping today, it does one of two misbehaviours:
>
>   1. Most of the time it just hangs, both on the reflector and on the
> emitter. The fsping processes are stuck in some uninterruptible state --
> only an MDS failover breaks them out. I tried with and without
> fuse_disable_pagecache -- no big difference.
>
>   2. When I increase the fsping --size to 512kB, it works a bit more
> reliably. But there is a weird bimodal distribution with most "packets"
> having 20-30ms rtt, some ~20% having ~5-6 seconds rtt, and some ~5% taking
> ~10-11s. I suspected the mds_tick_interval -- but decreasing that didn't
> help.
>
>
> In summary, if someone is curious, please give this tool a try on your
> CephFS cluster -- let me know if its working or not (and what rtt you can
> achieve with which configuration).
> And perhaps a dev would understand why it is not working with latest jewel
> ceph-fuse / ceph MDS's?

Yes, this immediately seizes up on my development environment (i.e.
master) and shows up as two blocked requests on the MDS.  We have
broken something...

Opened ticket here: http://tracker.ceph.com/issues/19635

John

> Best Regards,
>
> Dan
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
