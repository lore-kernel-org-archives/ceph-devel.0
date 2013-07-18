From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: ceph file system: extended attributes differ between ceph.ko and
 ceph-fuse
Date: Thu, 18 Jul 2013 12:49:49 +0200
Message-ID: <20130718124949.00cfec42@doppio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from port-212-202-108-184.static.qsc.de ([212.202.108.184]:56864
	"EHLO mail.itxperts.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756944Ab3GRKt6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Jul 2013 06:49:58 -0400
Received: from itxmail.itxperts.de (qgate_dmz.itxperts.de [192.168.160.1])
	by mail.itxperts.de (8.14.0/8.14.0) with ESMTP id r6IApWfh015267
	for <ceph-devel@vger.kernel.org>; Thu, 18 Jul 2013 12:51:33 +0200
Received: from doppio (doppio.itxperts.de [192.168.140.7])
	by itxmail.itxperts.de (Postfix) with ESMTP id 5ECE513F02
	for <ceph-devel@vger.kernel.org>; Thu, 18 Jul 2013 13:53:02 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I am looking at ceph filesystem both via the kernel module
and ceph-fuse.

I am running on CentOS6.4 with
 - kernel 3.8.13 (for ceph.ko) and
 - ceph v0.61.4 userland components

I encounter an inconsistency between ceph.ko and ceph-fuse
regarding extended attributes:

- I have the ceph fs mounted at mount points
  /mnt/cephfs (using ceph.ko) and /mnt/cephfs-fuse

[root@rx37-2 fs_2]# mount | grep ceph
10.10.38.13:/ on /mnt/cephfs type ceph (name=admin,key=client.admin)
ceph-fuse on /mnt/cephfs-fuse type fuse.ceph-fuse
       (rw,nosuid,nodev,allow_other,default_permissions)

- I inspect the same file from the two mointpoints

[root@rx37-2 mnt]# getfattr -d -m - cephfs-fuse/ssd-pool-3/file1 
# file: cephfs-fuse/ssd-pool-3/file1
ceph.file.layout="stripe_unit=4194304 stripe_count=1
object_size=4194304 pool=SSD-group-2"

[root@rx37-2 mnt]# getfattr -d -m - cephfs/ssd-pool-3/file1 
# file: cephfs/ssd-pool-3/file1
ceph.file.layout="chunk_bytes=4194304\012stripe_count=1\012object_size=4194304\012"
ceph.layout="chunk_bytes=4194304\012stripe_count=1\012object_size=4194304\012"

Where getfattr returns info about the pool via ceph-fuse,
it doesn't show that info via ceph.ko.

- use ceph utilities to look at the file shows the missing pieces;
  at least, the results are consistent.

[root@rx37-2 mnt]# cephfs cephfs/ssd-pool-3/file1 show_layout
layout.data_pool:     3
layout.object_size:   4194304
layout.stripe_unit:   4194304
layout.stripe_count:  1
[root@rx37-2 mnt]# ceph osd dump | grep pool | \ 
              awk '{ print $1 " " $2 ": " $3 }'
pool 0: 'data'
pool 1: 'metadata'
pool 2: 'rbd'
pool 3: 'SSD-group-2'
pool 4: 'SSD-group-3'
pool 5: 'SAS-group-2'
pool 6: 'SAS-group-3'


Is that a real problem?


Best Regards

Andreas Bluemle


-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm
