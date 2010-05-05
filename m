From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: Replacing DRBD use with RBD
Date: Wed, 05 May 2010 00:30:39 -0700
Message-ID: <hrr69o$fhb$1@dough.gmane.org>
References: <801672.55708.qm@web36106.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:49178 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880Ab0EEHZE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 5 May 2010 03:25:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1O9Yyd-0006AZ-16
	for ceph-devel@vger.kernel.org; Wed, 05 May 2010 09:25:03 +0200
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 05 May 2010 09:25:03 +0200
Received: from eternaleye by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 05 May 2010 09:25:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Martin Fick wrote:

> Hello,
> 
> I have a questions with respect to RADOS and RBD and the cluster monitor
> daemons.

I'm not one of the developers, but I've been following for a while and one 
of your sub-questions intriqued me; specifically:

>...This would open up the use of RBD devices for linux
> containers or linux vservers which could run on any machine in a cluster
> (similar to the idea of using it with kvm/qemu).

As it currently stands you could likely run a vserver or an 
OpenVZ/Virtuozzo/LXC container on Ceph (the distributed FS) directly, rather 
than layering a local FS over RBD. Also, this would probably provide better 
performance in the end. As a side benefit, you would gain the ability to 
make fine-grained snapshots of the guests' filesystems, access them directly 
from the host (or another Ceph client), and adjust quotas for the guest 
while running. This is probably a better solution for container-based 
virtualization than RBD-based options, due to the advantage one can take of 
all guests sharing a kernel with the host. RBD is more likely to be useful 
for full virtualization like KVM, but even in that case you could probably 
make a specialized initramfs that mounts a rootfs over Ceph with a prefix 
(taking advantage of that Ceph allows mounting a subdirectory as if it was 
the whole FS).

Hope this helps!

