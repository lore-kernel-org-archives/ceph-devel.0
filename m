From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Initial results of CephFS performance evaluation
Date: Tue, 27 Sep 2016 07:59:10 -0500
Message-ID: <cddef496-96cd-e130-cf04-d4998dfb5690@redhat.com>
References: <CA+2bHPaAmgVL3vSnzEK=3Oiv-8vO-D=+kv+5M6YbPC_EUJ8MJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbcI0M7O (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 27 Sep 2016 08:59:14 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8EF147EA91
        for <ceph-devel@vger.kernel.org>; Tue, 27 Sep 2016 12:59:13 +0000 (UTC)
In-Reply-To: <CA+2bHPaAmgVL3vSnzEK=3Oiv-8vO-D=+kv+5M6YbPC_EUJ8MJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Nice job Patrick!

I wonder how tough it would be to wrap your scripts in some python and 
add this as a CephFS benchmark in CBT. Seems like a good real-world test.

It would be interesting to see some mdtest results for multi-active mds 
as well.

Mark

On 09/26/2016 10:28 PM, Patrick Donnelly wrote:
> I wanted to share some of the initial performance results of CephFS
> using single and multiple MDS. These results are currently hosted
> here:
>
> https://github.com/batrick/cephfs-perf
>
> It has been some time since we've done an analysis of MDS performance
> (especially multiple active MDS). One of the goals of this study is to
> obtain performance metrics which confirm multiple active metadata
> servers (multimds) function in ways we expect. We are also looking to
> establish a base-line performance for a single active metadata server,
> such as how many concurrent clients one MDS can handle.
>
> The first experiment [3] is evaluating the performance of one and
> three active metadata servers against parallel kernel builds by
> clients (8 and 16). This is a situation we would expect multiple
> metadata servers to excel at with dynamic sub-tree partitioning [1,2].
> Additionally, because clients operate in independent trees, lock
> contention and forced journal flushes should be mostly eliminated.
>
> While there is still performance data to analyze, the initial results
> indicate multimds can give impressive performance gains, especially as
> the number of clients increase. For example, with 16 clients we saw
> improvements of 74% in execution time of the clients and an 84%
> reduction in client request latency (time spent by the client waiting
> for a result from the MDS).
>
> Future tests are being planned. If anyone has
> comments/questions/suggestions, please do share.
>
> [1] http://dl.acm.org/citation.cfm?id=1049948
> [2] http://ceph.com/papers/weil-mds-sc04.pdf
> [3] https://github.com/batrick/cephfs-perf/tree/master/kernel-build
>
