From: Matt Weil <mweil@genome.wustl.edu>
Subject: pg stuck on creating
Date: Mon, 17 Aug 2015 14:54:03 -0500
Message-ID: <55D23BDB.9050601@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gscsmtp.wustl.edu ([128.252.233.26]:40217 "HELO
	gscsmtp.wustl.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750902AbbHQTyI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Aug 2015 15:54:08 -0400
Received: from Matts-MacBook-Pro.local (unknown [10.0.7.131])
	by gscsmtp.wustl.edu (Postfix) with ESMTPSA id 1B6BE40084
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2015 14:54:08 -0500 (CDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

All,

Just made a new cluster added 4 OSD and the pgs seem to be stuck on 
creation.
     cluster 9cccdd9d-8845-4f4f-b8f4-d2f85469f958
      health HEALTH_WARN
             320 pgs stuck inactive
             320 pgs stuck unclean
      monmap e1: 2 mons at 
{linuscs106=10.100.7.173:6789/0,linuscs89=10.100.3.179:6789/0}
             election epoch 26, quorum 0,1 linuscs89,linuscs106
      osdmap e19: 4 osds: 0 up, 0 in
       pgmap v20: 320 pgs, 3 pools, 0 bytes data, 0 objects
             0 kB used, 0 kB / 0 kB avail
                  320 creating
any assistance would be appreciated.

____
This email message is a private communication. The information transmitted, including attachments, is intended only for the person or entity to which it is addressed and may contain confidential, privileged, and/or proprietary material. Any review, duplication, retransmission, distribution, or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is unauthorized by the sender and is prohibited. If you have received this message in error, please contact the sender immediately by return email and delete the original message from all computer systems. Thank you.
