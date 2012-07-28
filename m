From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Increasing number of PGs
Date: Sat, 28 Jul 2012 19:23:11 +0930
Message-ID: <5013B687.6020103@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:37843 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab2G1Jzn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Jul 2012 05:55:43 -0400
Received: from x.logics.net.au (gw.logics.net.au [150.101.235.251] (may be forged))
	(authenticated bits=0)
	by mail.logics.net.au (8.14.5/8.14.1) with ESMTP id q6S9rBPD017770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Sat, 28 Jul 2012 19:23:12 +0930
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I am working on optimization of ceph performance: CPU load vs OSD data 
load. Right now I have 576 PGs in total. Three pools: metadata, data, 
rbd. Each pool has 192 PGs. data is not used heavily, rbd is in heavy 
use. In total 6 OSDs in cluster. I have read recommendation about 100 
PGs per OSD. Roughly I do have 100 PGs per OSD. But now it seems that 
PGs in data pool are mostly empty while PGs in rbd pool are quite busy. 
Would it make sense to increase number of PGs to be 100 per rbd pool per 
OSD? Technically it should take some memory and CPU but because other 
two pools are virtually stand still it should not make big difference 
while improving data placement on OSDs (which is currently somewhat skewed).

So here two questions:

1. Should I increase number of PGs in rbd pool or better leave it where 
it is?
2. Wiki says that increase in PGs is not tested and only should be 
attempted on empty pool. Date on Wiki is quite old. Is this still an 
issue? Is it safe to increase PGs number on 0.49 on pool in use?

Regards,
Vladimir
