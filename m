From: Junqin JQ7 Zhang <zhangjq7@lenovo.com>
Subject: Ceph Bluestore OSD CPU utilization
Date: Tue, 11 Jul 2017 10:34:47 +0000
Message-ID: <694B98CBCEF42547AE4CD1A693225B5D085533EA@CNMAILEX04.lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.10]:43044 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755525AbdGKKhu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 11 Jul 2017 06:37:50 -0400
Content-Language: zh-CN
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I installed Ceph luminous v12.1.0 in 3 nodes cluster with BlueStore and did some fio test.
During test,  I found the each OSD CPU utilization rate was only aroud 30%.
And the performance seems not good to me.
Is  there any configuration to help increase OSD CPU utilization to improve performance?
Change kernel.pid_max? Any BlueStore specific configuration?

Thanks a lot!

B.R.
Junqin Zhang
