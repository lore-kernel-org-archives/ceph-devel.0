From: David Blundell <David.Blundell@100percentit.com>
Subject: Slow request warnings on 0.48
Date: Wed, 4 Jul 2012 16:53:02 +0000
Message-ID: <45F11B42CB5830479EF0E56A27F4E68D7F2E2E@exchange1.ad.100it.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.100percentit.com ([217.25.0.14]:60478 "EHLO
	smtp.100percentit.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751755Ab2GDQxI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 12:53:08 -0400
Received: from exchange1.ad.100it.net (unknown [87.254.25.14])
	by smtp.100percentit.com (Postfix) with ESMTP id 45702D8126
	for <ceph-devel@vger.kernel.org>; Wed,  4 Jul 2012 17:53:07 +0100 (BST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have three servers running mon and osd using Ubuntu 12.04 that I have been testing with RADOS storing RBD KVM instances

0.47.3 worked extremely well (once I got over a few btrfs issues).  The same servers running 0.48 give a large number of "[WRN] slow request" messages whenever I generate a lot of random IO in the KVM instances using iozone.  The slow responses eventually leads to disk timeouts on the KVM instances.

I have erased the osds and recreated on new btrfs volumes with the same result.

I have also tried switching to xfs using mkfs.xfs -n size=64k with noatime, inode64,delaylog,logbufs=8,logbsize=256k

Xfs gives the same result - the iozone tests run fine until the random IO starts and then there are lots of slow request warnings.

Does anyone have any ideas about the best place to start troubleshooting / debugging?

Thanks,

David
