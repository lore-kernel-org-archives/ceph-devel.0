From: Loic Dachary <loic@dachary.org>
Subject: jewel rgw backport issue with metadata
Date: Thu, 4 Aug 2016 15:12:03 +0200
Message-ID: <57A33F23.8080606@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:44061 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933774AbcHDNeG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Aug 2016 09:34:06 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id A088E47AC6E
	for <ceph-devel@vger.kernel.org>; Thu,  4 Aug 2016 15:13:08 +0200 (CEST)
Received: from mfilter42-d.gandi.net (mfilter42-d.gandi.net [217.70.178.172])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 2E40FFB8B1
	for <ceph-devel@vger.kernel.org>; Thu,  4 Aug 2016 15:12:06 +0200 (CEST)
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter42-d.gandi.net (mfilter42-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id R5d5TJ8p5IB5 for <ceph-devel@vger.kernel.org>;
	Thu,  4 Aug 2016 15:12:04 +0200 (CEST)
Received: from [192.168.3.6] (xd9ba6520.dyn.telefonica.de [217.186.101.32])
	(Authenticated sender: loic@dachary.org)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 457A5FB8D2
	for <ceph-devel@vger.kernel.org>; Thu,  4 Aug 2016 15:12:03 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

In the current jewel branch, 

rgw/singleton/{overrides.yaml xfs.yaml all/radosgw-admin-data-sync.yaml frontend/apache.yaml fs/xfs.yaml rgw_pool_type/ec-profile.yaml}

consistently succeeds[1]. However, when backporting it frequently fails on the integration branch[2]. Out of the commits merged in the integration branch for jewel[3] only a few relate to rgw and I'm unclear which one could cause that kind of failure. If anyone has an idea, I'll take it :-) Otherwise I'll keep digging.

Cheers

[1] http://pulpito.ceph.com/loic-2016-08-04_03:45:32-rgw-jewel---basic-smithi/ and http://pulpito.ceph.com/loic-2016-06-28_23:57:48-rgw-jewel-backports---basic-smithi/
[2] http://pulpito.ceph.com/loic-2016-07-07_08:16:03-rgw-jewel-backports---basic-smithi/300632 and http://pulpito.ceph.com/loic-2016-08-03_00:04:42-rgw-jewel-backports---basic-smithi/347441
[3] http://tracker.ceph.com/issues/16344#note-10
-- 
Loïc Dachary, Artisan Logiciel Libre
