From: Anders Saaby <as@one.com>
Subject: placement group sizing
Date: Thu, 25 Apr 2013 14:36:45 +0200
Message-ID: <64829650-86C1-4BF2-87B0-19ED8EB808C1@one.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from kontorsmtp1.one.com ([195.47.247.16]:50274 "EHLO
	kontorsmtp1.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034Ab3DYMmP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Apr 2013 08:42:15 -0400
Received: from [172.16.16.22] (unknown [46.30.211.29])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by kontorsmtp1.one.com (Postfix) with ESMTP id C1DF3800361CA
	for <ceph-devel@vger.kernel.org>; Thu, 25 Apr 2013 14:36:45 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

We are working on prototype infrastructure for RADOS clusters, and are now ready to deploy the first production size storage pool. One question remains; How many placement groups will we need, balancing memory footprint and ability to level data placement and data reads. - And still keeping stuff within sane limits. 

Our initial plan is to deploy 4PB pools, based on 4TB drives with 3 replicas (One OSD/disk). So, 3.000 disks per pool.

Acording to the documentation 1), we should have: 3.000 OSDs * 100 / 3 replicas == 100.000 placement groups.

From the maillist, 100.000 PG's is way more than I have seen, so, do you have any insights and advises on pg_num for a RADOS pool with these characteristics? Also, will it be a problem with a pg_num size this bit, if the pool is started out with only ~100 OSDs, and then grown to 3.000.


Thanks in advance,
Anders

1: http://ceph.com/docs/master/rados/operations/placement-groups/
