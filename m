From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Poor read performance in KVM
Date: Sun, 15 Jul 2012 22:43:57 +0930
Message-ID: <5002C215.108@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:59099 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab2GONOX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 15 Jul 2012 09:14:23 -0400
Received: from x.logics.net.au (gw.logics.net.au [150.101.235.251] (may be forged))
	(authenticated bits=0)
	by mail.logics.net.au (8.14.5/8.14.1) with ESMTP id q6FDDvKo003609
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Sun, 15 Jul 2012 22:43:58 +0930
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

Lately I was trying to get KVM to perform well on RBD. But it still 
appears elusive.

[root@alpha etc]# rados -p rbd bench 120 seq -t 8

Total time run:        16.873277
Total reads made:     302
Read size:            4194304
Bandwidth (MB/sec):    71.592

Average Latency:       0.437984
Max latency:           3.26817
Min latency:           0.015786

Fairly good performance. But when I run in KVM:

[root@mail ~]# hdparm -tT /dev/vda

/dev/vda:
  Timing cached reads:   8808 MB in  2.00 seconds = 4411.49 MB/sec
  Timing buffered disk reads:  10 MB in  6.21 seconds =   1.61 MB/sec

Not even close to what rados bench show! I even seen 900KB/sec 
performance. Such slow read performance of course affecting guests.

Any ideas where to start to look for performance boost?

Regards,
Vladimir

