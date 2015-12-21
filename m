From: Wido den Hollander <wido@42on.com>
Subject: RBD performance with many childs and snapshots
Date: Mon, 21 Dec 2015 20:06:17 +0100
Message-ID: <56784DA9.9060304@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:45865 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbbLUTGW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Dec 2015 14:06:22 -0500
Received: from [192.168.8.128] (cable-178-107.zeelandnet.nl [82.176.178.107])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id 940D34007F
	for <ceph-devel@vger.kernel.org>; Mon, 21 Dec 2015 20:06:17 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

While implementing the buildvolfrom method in libvirt for RBD I'm stuck
at some point.

$ virsh vol-clone --pool myrbdpool image1 image2

This would clone image1 to a new RBD image called 'image2'.

The code I've written now does:

1. Create a snapshot called image1@libvirt-<epochtimestamp>
2. Protect the snapshot
3. Clone the snapshot to 'image1'

wido@wido-desktop:~/repos/libvirt$ ./tools/virsh vol-clone --pool
rbdpool image1 image2
Vol image2 cloned from image1

wido@wido-desktop:~/repos/libvirt$

root@alpha:~# rbd -p libvirt info image2
rbd image 'image2':
	size 10240 MB in 2560 objects
	order 22 (4096 kB objects)
	block_name_prefix: rbd_data.1976451ead36b
	format: 2
	features: layering, striping
	flags:
	parent: libvirt/image1@libvirt-1450724650
	overlap: 10240 MB
	stripe unit: 4096 kB
	stripe count: 1
root@alpha:~#

But this could potentially lead to a lot of snapshots with children on
'image1'.

image1 itself will probably never change, but I'm wondering about the
negative performance impact this might have on a OSD.

I'd rather not hardcode a snapshot name like 'libvirt-parent-snapshot'
into libvirt. There is however no way to pass something like a snapshot
name in libvirt when cloning.

Any bright suggestions? Or is it fine to create so many snapshots?

-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
