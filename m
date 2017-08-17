From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: High memory usage kills OSD while peering
Date: Thu, 17 Aug 2017 10:53:04 -0700
Message-ID: <CAJ4mKGa6Nt1Eic9gk=SMbRufUCPnEcGijgJj-K8vHQP7A=HQKw@mail.gmail.com>
References: <07113ad5-a799-5232-c617-81f323ce4038@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:36910 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753189AbdHQRxG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Aug 2017 13:53:06 -0400
Received: by mail-it0-f45.google.com with SMTP id 76so5438571ith.0
        for <ceph-devel@vger.kernel.org>; Thu, 17 Aug 2017 10:53:06 -0700 (PDT)
In-Reply-To: <07113ad5-a799-5232-c617-81f323ce4038@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linux Chips <linux.chips@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 17, 2017 at 7:13 AM, Linux Chips <linux.chips@gmail.com> wrote:
> Hello everybody,
> I have Kraken cluster with 660 OSD, currently it is down due to not
> being able to complete peering, OSDs start consuming lots of memory
> draining the system and killing the node, so I set a limit on the OSD
> service (on some OSDs 28G and others as high as 35G), so they get
> killed before taking down the whole node.
> Now I still can't peer, one OSD entering the cluster (with about 300
> already up) makes memory usage of most other OSDs so high (15G+, some as
> much as 30G) and
> sometimes kills them when they reach the service limit. which cause a spiral
> load and causing all the OSDs to consume all the available.
>
> I found this thread with similar symptoms:
>
> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-April/017522.html
>
> with a request for stack trace, I have a 14G core dump, we generated it by
> running the osd from the terminal, enabling the core dumps, and setting
> ulimits to 15G. what kind of a trace would be useful? all thread?! any
> better way to debug this?
>
> What can I do do make it work, is this memory allocation normal?
>
> some info about the cluster:
> 41 hdd nodes with 12 x 4TB osd each, 5 of the nodes have 8TB disks. 324 GB
> RAM and dula socket intel xeon.
> 7 nodes with 400GB x 24 ssd and 256GB RAM, and dual socket cpu.
> 3 monitors
>
> all dual 10GB ethernet, except for the monitor with dual 1GB ethers.
>
> all nodes running centos 7.2
> it is an old cluster that was upgraded continuously for the past 3 years.
> the cluster was on jewel when the issue happened due to some accidental OSD
> map changes, causing a heavy recovery operations on the cluster. then we
> upgraded to kraken in the hope of less memory foot prints.
>
> any advice on how to proceed?

It's not normal but if something really bad happened to your cluster,
it's been known to occur. You should go through the troubleshooting
guides at docs.ceph.com, but the general strategy is to set
nodown/noout/etc flags, undo whatever horrible thing you tried to make
the map do, and then turn all the OSDs back on.
-Greg
