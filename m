From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: flashcache
Date: Wed, 16 Jan 2013 22:22:18 +0100
Message-ID: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36983 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756332Ab3APVWT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 16:22:19 -0500
Received: by mail-wg0-f50.google.com with SMTP id es5so1157069wgb.17
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 13:22:18 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In a ceph cluster, flashcache with writeback is considered safe?
In case of SSD failure, the flashcache contents should be already been
replicated (by ceph) in other servers, right?

I'm planning to use this configuration: Supermicro with 12 spinning
disks e 2 SSD.
6 spinning disks will have ceph journal on SSD1, the other 6 disks
will have ceph journal on disks2.

One OSD for each spinning disk (a single XFS filesystem for the whole disk).
XFS metadata to a parition of SSD1
XFS flashcache to another partition of SSD1

So, 3 partitions for each OSD on the SSD.
How big should be these partitions? Any advice?

No raid at all, except for 1 RAID-1 volume made with a 10GB partitions
on each SSD, for the OS. Log files will be replicated to a remote
server, so writes on OS partitions are very very low.

Any hint? Adivice? Critics?
