From: "Jim Schutt" <jaschut@sandia.gov>
Subject: cephfs set_layout on filesystem root?
Date: Wed, 19 Jan 2011 09:46:46 -0700
Message-ID: <1295455606.6777.23.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:34215 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab1ASQrd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jan 2011 11:47:33 -0500
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1F1BF4DC773
	for <ceph-devel@vger.kernel.org>; Wed, 19 Jan 2011 09:47:29 -0700 (MST)
Received: from mail.sandia.gov (cas1.sandia.gov [134.253.165.159]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id p0JGlAPo031792 for
 <ceph-devel@vger.kernel.org>; Wed, 19 Jan 2011 09:47:12 -0700
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I've been experimenting with using cephfs to set
the object/stripe size on a Ceph filesystem root,
and it seems to not persist across a filesystem
restart.  Is that expected behavior?

To reproduce on current testing branch (6d0dc4bf6):

---
# create a new filesystem, mount it; then
# from a client:

[root@an1024 ~]# df -h /mnt/ceph
Filesystem            Size  Used Avail Use% Mounted on
172.17.40.34:/         13T  510M   13T   1% /ram/mnt/ceph

[root@an1024 ~]# cephfs /mnt/ceph/ show_layout
layout.data_pool:     0
layout.object_size:   4194304
layout.stripe_unit:   4194304
layout.stripe_count:  1
layout.preferred_osd: -1

[root@an1024 ~]# cephfs /mnt/ceph set_layout -s 262144 -c 1 -u 262144
[root@an1024 ~]# cephfs /mnt/ceph/ show_layout
layout.data_pool:     0
layout.object_size:   262144
layout.stripe_unit:   262144
layout.stripe_count:  1
layout.preferred_osd: -1

[root@an1024 ~]# touch /mnt/ceph/test1
[root@an1024 ~]# cephfs /mnt/ceph/test1 show_layout
layout.data_pool:     0
layout.object_size:   262144
layout.stripe_unit:   262144
layout.stripe_count:  1
layout.preferred_osd: -1

[root@an1024 ~]# umount /mnt/ceph
[root@an1024 ~]# mount.ceph an14-ib0:/ /mnt/ceph
[root@an1024 ~]# df -h /mnt/ceph
Filesystem            Size  Used Avail Use% Mounted on
172.17.40.34:/         13T  178M   13T   1% /ram/mnt/ceph

[root@an1024 ~]# cephfs /mnt/ceph/ show_layout
layout.data_pool:     0
layout.object_size:   262144
layout.stripe_unit:   262144
layout.stripe_count:  1
layout.preferred_osd: -1
---

OK, so far.  After filesystem unmount/shutdown/restart/mount:

---

[root@an1024 ~]# df -h /mnt/ceph
Filesystem            Size  Used Avail Use% Mounted on
172.17.40.34:/         13T  450M   13T   1% /ram/mnt/ceph

[root@an1024 ~]# cephfs /mnt/ceph/ show_layout
layout not specified

---
Hmmm, not what I was expecting.  Also:
---

[root@an1024 ~]# cephfs /mnt/ceph/test1 show_layout
layout.data_pool:     0
layout.object_size:   262144
layout.stripe_unit:   262144
layout.stripe_count:  1
layout.preferred_osd: -1

[root@an1024 ~]# touch /mnt/ceph/test2
[root@an1024 ~]# cephfs /mnt/ceph/test2 show_layout
layout.data_pool:     0
layout.object_size:   4194304
layout.stripe_unit:   4194304
layout.stripe_count:  1
layout.preferred_osd: -1

---
Also not what I was expecting.  I thought my
256 KiB setting from before should still be in
effect.

Am I missing something?

Thanks -- Jim




