From: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Subject: cephfs set_layout - EINVAL
Date: Fri, 9 Aug 2013 09:44:57 +0200
Message-ID: <20130809074457.GA27330@oder.mch.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:14586 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967517Ab3HIHpB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 03:45:01 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Kasper Dieter <Dieter.Kasper@ts.fujitsu.com>

Hi,

my goal is to set the 'object size' used in the distribution inside rados
in an equal (or similar) way between RBD and CephFS.

To set obj_size=64k in RBD I use the command:
rbd create --size 1024000 --pool SSD-r2 ssd2-1T-64k --order 16  

On cephfs set_layout '-s 65536' runs into EINVAL:
cephfs /mnt/cephfs/fio-64k/ set_layout -p 3 -s   65536 -u 4194304 -c 1
Error setting layout: Invalid argument

cephfs /mnt/cephfs/fio-64k/ set_layout -p 3 -s   65536 -u 65536 -c 1
cephfs /mnt/cephfs/fio-64k/ show_layout
layout.data_pool:     3
layout.object_size:   65536
layout.stripe_unit:   65536
layout.stripe_count:  1

The man page of cephfs says
---snip---
       -u --stripe_unit
              Set the size of each stripe

       -c --stripe_count
              Set the number of objects to stripe across

       -s --object_size
              Set the size of the objects to stripe across
---snip---

What is the equivalent command on cephfs to 'rbd create --order 16' ?
Can you please give same explanation how "--stripe_unit --stripe_count --object_size"
should be used in combination to achieve different layouts on CephFS directories
(e.g. optimized for streaming, small sequential IOs, small random IOs)
?

Thanks,
-Dieter
