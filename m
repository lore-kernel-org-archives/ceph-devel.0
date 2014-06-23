From: Guang Yang <yguang11@outlook.com>
Subject: XFS - number of files in a directory
Date: Mon, 23 Jun 2014 19:26:10 +0800
Message-ID: <BLU436-SMTP1816E100B6B632433B8272DF1F0@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc4s5.hotmail.com ([65.55.111.144]:62968 "EHLO
	BLU004-OMC4S5.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbaFWL0L convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jun 2014 07:26:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hello Cephers,
We used to have a Ceph cluster and setup our data pool as 3 replicas, we estimated the number of files (given disk size and object size) for each PG was around 8K, we disabled folder splitting which mean all files located at the root PG folder. Our testing showed a good performance with such setup.

Right now we are evaluating erasure coding, which split the object into a number of chunks and increase the number of files several times, although XFS claims a good support for large directories [1], some testing also showed that we may expect performance degradation for large directories.

I would like to check with your experience on top of this for your Ceph cluster if you are using XFS. Thanks.

[1] http://www.scs.stanford.edu/nyu/02fa/sched/xfs.pdf

Thanks,
Guang