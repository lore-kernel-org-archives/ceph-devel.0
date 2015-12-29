From: Fengguang Gong <fengguanggong@gmail.com>
Subject: Create one millon empty files with cephfs
Date: Tue, 29 Dec 2015 21:13:37 +0800
Message-ID: <CAJ2LqzjocS7aszq77X5MiOJSTOPvG9J1=FEvbncANLOikk5dJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38275 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbbL2NNj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Dec 2015 08:13:39 -0500
Received: by mail-wm0-f51.google.com with SMTP id b14so12920533wmb.1
        for <ceph-devel@vger.kernel.org>; Tue, 29 Dec 2015 05:13:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,
We create one million empty files through filebench, here is the test env:
MDS: one MDS
MON: one MON
OSD: two OSD, each with one Inter P3700; data on OSD with 2x replica
Network: all nodes are connected through 10 gigabit network

We use more than one client to create files, to test the scalability
of MDS. Here are the results:
IOPS under one client: 850
IOPS under two client: 1150
IOPS under four client: 1180

As we can see, the IOPS almost maintains unchanged when the number of
client increase from 2 to 4.

Cephfs may have a low scalability under one MDS, and we think its the
big lock in
MDSDamon::ms_dispatch()::Mutex::locker(every request acquires this
lock), who limits the scalability of MDS.

We think this big lock could be removed through the following steps:
1. separate the process of ClientRequest with other requests, so we
can parallel the process of ClientRequest
2. use some small granularity locks instead of big lock to ensure consistency

Wondering this idea is reasonable?

thanks
