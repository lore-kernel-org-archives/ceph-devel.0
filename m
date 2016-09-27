From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Initial results of CephFS performance evaluation
Date: Mon, 26 Sep 2016 23:28:11 -0400
Message-ID: <CA+2bHPaAmgVL3vSnzEK=3Oiv-8vO-D=+kv+5M6YbPC_EUJ8MJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:32938 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbcI0D2n (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Sep 2016 23:28:43 -0400
Received: by mail-qk0-f181.google.com with SMTP id g67so1223040qkd.0
        for <ceph-devel@vger.kernel.org>; Mon, 26 Sep 2016 20:28:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I wanted to share some of the initial performance results of CephFS
using single and multiple MDS. These results are currently hosted
here:

https://github.com/batrick/cephfs-perf

It has been some time since we've done an analysis of MDS performance
(especially multiple active MDS). One of the goals of this study is to
obtain performance metrics which confirm multiple active metadata
servers (multimds) function in ways we expect. We are also looking to
establish a base-line performance for a single active metadata server,
such as how many concurrent clients one MDS can handle.

The first experiment [3] is evaluating the performance of one and
three active metadata servers against parallel kernel builds by
clients (8 and 16). This is a situation we would expect multiple
metadata servers to excel at with dynamic sub-tree partitioning [1,2].
Additionally, because clients operate in independent trees, lock
contention and forced journal flushes should be mostly eliminated.

While there is still performance data to analyze, the initial results
indicate multimds can give impressive performance gains, especially as
the number of clients increase. For example, with 16 clients we saw
improvements of 74% in execution time of the clients and an 84%
reduction in client request latency (time spent by the client waiting
for a result from the MDS).

Future tests are being planned. If anyone has
comments/questions/suggestions, please do share.

[1] http://dl.acm.org/citation.cfm?id=1049948
[2] http://ceph.com/papers/weil-mds-sc04.pdf
[3] https://github.com/batrick/cephfs-perf/tree/master/kernel-build

-- 
Patrick Donnelly
