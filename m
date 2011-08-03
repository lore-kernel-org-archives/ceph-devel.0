From: "H. Andres Lagar-Cavilla" <andres@research.att.com>
Subject: Before deploying a rados cluster, three questions
Date: Wed, 3 Aug 2011 15:46:39 -0400
Message-ID: <6514406A-D350-40F2-ADA7-0978DDD20667@research.att.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pink.research.att.com ([192.20.225.111]:53826 "EHLO
	mail-pink.research.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752605Ab1HCUAL convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Aug 2011 16:00:11 -0400
Received: from mail-blue.research.att.com (unknown [135.207.178.11])
	by mail-pink.research.att.com (Postfix) with ESMTP id 660B3120435
	for <ceph-devel@vger.kernel.org>; Wed,  3 Aug 2011 15:38:45 -0400 (EDT)
Received: from bigmail.research.att.com (bigmail.research.att.com [135.207.177.180])
	by mail-blue.research.att.com (Postfix) with ESMTP id 61155EF6D0
	for <ceph-devel@vger.kernel.org>; Wed,  3 Aug 2011 15:38:45 -0400 (EDT)
Received: from [135.207.175.254] ([135.207.175.254])
	by bigmail.research.att.com (8.13.8+Sun/8.11.6) with ESMTP id p73JcjLm017294
	for <ceph-devel@vger.kernel.org>; Wed, 3 Aug 2011 15:38:45 -0400 (EDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,
I''ve been looking at ceph for a little while and following the mailing list. We are thinking of using just rados (i.e. no mds) for a data warehouse that does not need posix compliance. Three questions come to mind

1. what is a good kernel+backing filesystem combo to use on each individual rados node. Recently people have been reporting xattrs issues with 3.0 and ext4, and performance leaks with btrfs. What is recommended by core ceph developers as stable?

2. Layout: we have 10 beefy nodes (maybe more, stick with 10 for now). I'd like to use all ten for osds, but we also need monitors. So:
2.1. Do monitors need beefy machines (I guess not)
2.2. two/three monitors is ok for O(10) osds?

3. API examples. The rgw looks like a prime example of a chunk of code that interfaces directly with rados. Any other examples? librbd?

Thanks a lot!
Andres