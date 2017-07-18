From: sheng qiu <herbert1984106@gmail.com>
Subject: cephfs performance
Date: Mon, 17 Jul 2017 22:27:36 -0700
Message-ID: <CAB7xdinWHk+y=AjfLeC_FV0HANKoZs_xGjywh3yNBjUfVvuQfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35792 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdGRF1h (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jul 2017 01:27:37 -0400
Received: by mail-qk0-f175.google.com with SMTP id p73so7946375qka.2
        for <ceph-devel@vger.kernel.org>; Mon, 17 Jul 2017 22:27:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,

I am evaluating the cephfs performance and see unreasonable
performance when multiple threads accessing same mount point.

there are 10k files (300MB each) in the fuse mount point, when
increase multiple fio threads accessing those 10k files, the
performance is not scaled and bounded to ~40MB/s.

the ceph cluster has 36 OSDs on three high end servers, each OSD
backed by a NVMe drive. Theres's another servers running one MDS
process and monitors.

if pushing IO via fio rbd engine to the cluster directly, it has
pretty reasonable performance. Is there any special configuration i
should pay attention when setup cephfs or fuse client is the problem?
or i should use more MDS?

any suggestions would be appreciated.

Thanks,
Sheng
