From: Loic Dachary <loic@dachary.org>
Subject: Re: jewel rgw backport issue with metadata
Date: Thu, 4 Aug 2016 16:05:20 +0200
Message-ID: <57A34BA0.2060707@dachary.org>
References: <57A33F23.8080606@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:37050 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933826AbcHDOHu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Aug 2016 10:07:50 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 2CA8E47A036
	for <ceph-devel@vger.kernel.org>; Thu,  4 Aug 2016 16:07:14 +0200 (CEST)
Received: from mfilter30-d.gandi.net (mfilter30-d.gandi.net [217.70.178.161])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 37BBFFB8C6
	for <ceph-devel@vger.kernel.org>; Thu,  4 Aug 2016 16:05:23 +0200 (CEST)
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter30-d.gandi.net (mfilter30-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id qNsNI7cK5Oym for <ceph-devel@vger.kernel.org>;
	Thu,  4 Aug 2016 16:05:21 +0200 (CEST)
Received: from [192.168.3.6] (xd9ba6520.dyn.telefonica.de [217.186.101.32])
	(Authenticated sender: loic@dachary.org)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 882F6FB8BF
	for <ceph-devel@vger.kernel.org>; Thu,  4 Aug 2016 16:05:21 +0200 (CEST)
In-Reply-To: <57A33F23.8080606@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I was wrong: the problem does not always show on the jewel-backport branch : it succeeds sometimes http://pulpito.ceph.com/loic-2016-08-04_05:47:34-rgw-jewel-backports---basic-smithi/

On 04/08/2016 15:12, Loic Dachary wrote:
> Hi,
> 
> In the current jewel branch, 
> 
> rgw/singleton/{overrides.yaml xfs.yaml all/radosgw-admin-data-sync.yaml frontend/apache.yaml fs/xfs.yaml rgw_pool_type/ec-profile.yaml}
> 
> consistently succeeds[1]. However, when backporting it frequently fails on the integration branch[2]. Out of the commits merged in the integration branch for jewel[3] only a few relate to rgw and I'm unclear which one could cause that kind of failure. If anyone has an idea, I'll take it :-) Otherwise I'll keep digging.
> 
> Cheers
> 
> [1] http://pulpito.ceph.com/loic-2016-08-04_03:45:32-rgw-jewel---basic-smithi/ and http://pulpito.ceph.com/loic-2016-06-28_23:57:48-rgw-jewel-backports---basic-smithi/
> [2] http://pulpito.ceph.com/loic-2016-07-07_08:16:03-rgw-jewel-backports---basic-smithi/300632 and http://pulpito.ceph.com/loic-2016-08-03_00:04:42-rgw-jewel-backports---basic-smithi/347441
> [3] http://tracker.ceph.com/issues/16344#note-10
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
