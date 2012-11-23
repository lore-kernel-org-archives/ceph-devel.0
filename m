From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: syncfs via syscall doesn not work
Date: Fri, 23 Nov 2012 09:19:55 +0100
Message-ID: <50AF31AB.1050402@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:37511 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab2KWIUF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 03:20:05 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i've seen that next branch caontains the "Try using syscall() for syncfs 
if not supported directly by glibc" patch. But this does not work for me.

I've tested this on a Debian Squeeze box with default glibc and a 3.6.7 
Kernel.

The OSD gives me the following output:
2012-11-23 08:55:54.650182 7f7bc7c1f780  0 filestore(/ceph/osd.11/) 
mount FIEMAP ioctl is supported and appears to work
2012-11-23 08:55:54.650190 7f7bc7c1f780  0 filestore(/ceph/osd.11/) 
mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
2012-11-23 08:55:54.650355 7f7bc7c1f780  0 filestore(/ceph/osd.11/) 
mount did NOT detect btrfs
2012-11-23 08:55:54.650358 7f7bc7c1f780  0 filestore(/ceph/osd.11/) 
mount syncfs(2) syscall not support by glibc
2012-11-23 08:55:54.650361 7f7bc7c1f780  0 filestore(/ceph/osd.11/) 
mount no syncfs(2), must use sync(2).
2012-11-23 08:55:54.650362 7f7bc7c1f780  0 filestore(/ceph/osd.11/) 
mount WARNING: multiple ceph-osd daemons on the same host will be slow
2012-11-23 08:55:54.650391 7f7bc7c1f780  0 filestore(/ceph/osd.11/) 
mount found snaps <>
2012-11-23 08:55:54.652413 7f7bc7c1f780  0 filestore(/ceph/osd.11/) 
mount: enabling WRITEAHEAD journal mode: btrfs not detected

When i build ceph against a patched glibc i get:

2012-11-23 09:19:39.339597 7fee3e497780  0 ceph version 
0.54-676-g9d366a0 (9d366a0706a58b1612dd95831533c5a02b87f5fc), process 
ceph-osd, pid 9165
starting osd.11 at :/0 osd_data /ceph/osd.11/ /ceph/journal/osd.11.journal
2012-11-23 09:19:39.347924 7fee3e497780  0 filestore(/ceph/osd.11/) 
mount FIEMAP ioctl is supported and appears to work
2012-11-23 09:19:39.347932 7fee3e497780  0 filestore(/ceph/osd.11/) 
mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
2012-11-23 09:19:39.348111 7fee3e497780  0 filestore(/ceph/osd.11/) 
mount did NOT detect btrfs
2012-11-23 09:19:39.349415 7fee3e497780  0 filestore(/ceph/osd.11/) 
mount syncfs(2) syscall fully supported (by glibc and kernel)
2012-11-23 09:19:39.349461 7fee3e497780  0 filestore(/ceph/osd.11/) 
mount found snaps <>
2012-11-23 09:19:39.350661 7fee3e497780  0 filestore(/ceph/osd.11/) 
mount: enabling WRITEAHEAD journal mode: btrfs not detected

Greets,
Stefan
