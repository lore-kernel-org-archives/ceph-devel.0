From: Wido den Hollander <wido@widodh.nl>
Subject: Unmountable btrfs filesystems
Date: Sat, 16 Jun 2012 20:46:28 +0200
Message-ID: <4FDCD484.50706@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:58616 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956Ab2FPSqa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Jun 2012 14:46:30 -0400
Received: from [IPv6:2a00:f10:11c:ab:45ee:de40:e6fa:1946] (unknown [IPv6:2a00:f10:11c:ab:45ee:de40:e6fa:1946])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPA id BAF3C40196
	for <ceph-devel@vger.kernel.org>; Sat, 16 Jun 2012 20:46:28 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On my dev cluster (10 nodes, 40 OSD's) I'm still trying to run Ceph on 
btrfs, but over the last couple of months I've lost multiple OSD's due 
to btrfs.

On my nodes I've set kernel.panic=60 so that whenever a kernel panic 
occurs I get the node back within two minutes.

Now, over the last time I've seen multiple nodes reboot (didn't see the 
strace), but afterwards the btrfs filesystems on that node were unmountable.

"btrfs: open_ctree failed"

I tried various kernels, the most recent 3.3.0 from kernel.ubuntu.com, 
but I'm still seeing this.

Is anyone seeing the same or did everybody migrate away to ext4 or XFS?

I still prefer btrfs due to the snapshotting, but loosing all these 
OSD's all the time is getting kind of frustrating.

Any thoughts or comments?

Wido
