From: Loic Dachary <loic@dachary.org>
Subject: rbd_fsx_nbd timesout on jewel
Date: Thu, 4 Aug 2016 15:58:27 +0200
Message-ID: <57A34A03.5000904@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:47977 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933837AbcHDN7I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Aug 2016 09:59:08 -0400
Received: from mfilter34-d.gandi.net (mfilter34-d.gandi.net [217.70.178.165])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 45FCA41C08D
	for <ceph-devel@vger.kernel.org>; Thu,  4 Aug 2016 15:58:29 +0200 (CEST)
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter34-d.gandi.net (mfilter34-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id S1brvSpAz7jS for <ceph-devel@vger.kernel.org>;
	Thu,  4 Aug 2016 15:58:28 +0200 (CEST)
Received: from [192.168.3.6] (xd9ba6520.dyn.telefonica.de [217.186.101.32])
	(Authenticated sender: loic@dachary.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D783C41C08B
	for <ceph-devel@vger.kernel.org>; Thu,  4 Aug 2016 15:58:27 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

rbd/thrash/{base/install.yaml clusters/{fixed-2.yaml openstack.yaml} fs/xfs.yaml msgr-failures/few.yaml thrashers/default.yaml workloads/rbd_fsx_nbd.yaml} 

consistently timesout on jewel[1]. Looking at the jewel branch of ceph-qa-suite, it does not seem to miss a commit that would make a difference. It looks like ceph_test_librbd_fsx is not making any progress. The -p 100 should show a debug line every 100 test call but there are not any.

Any idea what is going on ?

Cheers

[1] http://pulpito.ceph.com/teuthology-2016-07-20_02:00:02-rbd-jewel-distro-basic-smithi/324668/

-- 
Loïc Dachary, Artisan Logiciel Libre
