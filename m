From: Mark Nelson <mnelson@redhat.com>
Subject: async messenger random read performance on NVMe
Date: Wed, 21 Sep 2016 13:49:58 -0500
Message-ID: <9a0e4578-6143-378f-20cf-8e7e8b9cf98b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933016AbcIUSuB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Sep 2016 14:50:01 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A49F9E62B
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 18:50:01 +0000 (UTC)
Received: from [10.3.112.71] (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8LInx5L030352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 14:50:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Recently in master we made async messenger default.  After doing a bunch 
of bisection, it turns out that this caused a fairly dramatic decrease 
in bluestore random read performance.  This is on a cluster with fairly 
fast NVMe cards, 16 OSDs across 4 OSD hosts.  There are 8 fio client 
processes with 32 concurrent threads each.

Ceph master using bluestore

Parameters tweaked:

ms_async_send_inline
ms_async_op_threads
ms_async_max_op_threads

simple: 168K IOPS

send_inline: true
async 3/5   threads: 111K IOPS
async 4/8   threads: 125K IOPS
async 8/16  threads: 128K IOPS
async 16/32 threads: 128K IOPS
async 24/48 threads: 128K IOPS
async 25/50 threads: segfault
async 26/52 threads: segfault
async 32/64 threads: segfault

send_inline: false
async 3/5   threads: 153K IOPS
async 4/8   threads: 153K IOPS
async 8/16  threads: 152K IOPS

So definitely setting send_inline to false helps pretty dramatically, 
though we're still a little slower for small random reads than simple 
messenger.  Haomai, regarding the segfaults, I took a quick look with 
gdb at the core file but didn't see anything immediately obvious.  It 
might be worth seeing if you can reproduce.

On the performance front, I'll try to see if I can see anything obvious 
in perf.

Mark
