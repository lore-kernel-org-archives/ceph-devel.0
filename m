From: Linux Chips <linux.chips@gmail.com>
Subject: High memory usage kills OSD while peering
Date: Thu, 17 Aug 2017 17:13:12 +0300
Message-ID: <07113ad5-a799-5232-c617-81f323ce4038@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:38881 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbdHQONP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Aug 2017 10:13:15 -0400
Received: by mail-wr0-f178.google.com with SMTP id 5so19867511wrz.5
        for <ceph-devel@vger.kernel.org>; Thu, 17 Aug 2017 07:13:15 -0700 (PDT)
Received: from [172.31.3.160] ([37.239.255.253])
        by smtp.googlemail.com with ESMTPSA id z9sm4517048wrz.0.2017.08.17.07.13.13
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2017 07:13:13 -0700 (PDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello everybody,
I have Kraken cluster with 660 OSD, currently it is down due to not
being able to complete peering, OSDs start consuming lots of memory
draining the system and killing the node, so I set a limit on the OSD
service (on some OSDs 28G and others as high as 35G), so they get
killed before taking down the whole node.
Now I still can't peer, one OSD entering the cluster (with about 300
already up) makes memory usage of most other OSDs so high (15G+, some as much as 30G) and
sometimes kills them when they reach the service limit. which cause a spiral load and causing all the OSDs to consume all the available.

I found this thread with similar symptoms:

http://lists.ceph.com/pipermail/ceph-users-ceph.com/2017-April/017522.html

with a request for stack trace, I have a 14G core dump, we generated it by running the osd from the terminal, enabling the core dumps, and setting ulimits to 15G. what kind of a trace would be useful? all thread?! any better way to debug this?

What can I do do make it work, is this memory allocation normal?

some info about the cluster:
41 hdd nodes with 12 x 4TB osd each, 5 of the nodes have 8TB disks. 324 GB RAM and dula socket intel xeon.
7 nodes with 400GB x 24 ssd and 256GB RAM, and dual socket cpu.
3 monitors

all dual 10GB ethernet, except for the monitor with dual 1GB ethers.

all nodes running centos 7.2
it is an old cluster that was upgraded continuously for the past 3 years. the cluster was on jewel when the issue happened due to some accidental OSD map changes, causing a heavy recovery operations on the cluster. then we upgraded to kraken in the hope of less memory foot prints.

any advice on how to proceed?

Thanks in advance

