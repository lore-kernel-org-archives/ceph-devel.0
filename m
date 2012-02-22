From: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Subject: How to easily determine what version of Ceph is included in a
 kernel?
Date: Wed, 22 Feb 2012 11:29:29 +1000
Message-ID: <81C477727102DA4E9B2605AC748C495407E36DF7EF@exch10>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mf4.mach.net.au ([74.55.157.90]:51122 "EHLO mf4.mach.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546Ab2BVBa2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 20:30:28 -0500
Received: from exch13.ad.mach.net.au (unknown [115.165.169.9])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mf4.mach.net.au (Postfix) with ESMTP id C74102892F
	for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2012 11:29:38 +1000 (EST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

G'day all

We wish to document a simple way to determine what version of ceph/rbd is included with a given kernel on a Client machine, i.e. not the Ceph Cluster nodes themselves (which we are running v0.42 on). "modinfo ceph" (per below) gives a "srcversion" value, but I do not know how to correlate that value to an equivalent v0.40, v0.41, etc version tag value.

Ideas?

Thanks!

Paul


root@server:~/linux-3.2.0/fs/ceph# modinfo ceph
filename:       /lib/modules/3.2.0-17-generic/kernel/fs/ceph/ceph.ko
license:        GPL
description:    Ceph filesystem for Linux
author:         Patience Warnick <patience@newdream.net>
author:         Yehuda Sadeh <yehuda@hq.newdream.net>
author:         Sage Weil <sage@newdream.net>
srcversion:     D70472130C6DBCE761D6262
depends:        libceph
intree:         Y
vermagic:       3.2.0-17-generic SMP mod_unload modversions


root@server:~/linux-3.2.0/fs/ceph# modinfo rbd
filename:       /lib/modules/3.2.0-17-generic/kernel/drivers/block/rbd.ko
license:        GPL
author:         Jeff Garzik <jeff@garzik.org>
description:    rados block device
author:         Yehuda Sadeh <yehuda@hq.newdream.net>
author:         Sage Weil <sage@newdream.net>
srcversion:     B134592CFB5E258DBFC7688
depends:        libceph
intree:         Y
vermagic:       3.2.0-17-generic SMP mod_unload modversions


