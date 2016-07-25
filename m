From: Yoann Moulin <yoann.moulin@epfl.ch>
Subject: Jewel + kernel 4.4 Massive performance regression (-50%)
Date: Mon, 25 Jul 2016 17:45:25 +0200
Message-ID: <14aea50c-f708-1d99-8d61-c79bec2029e0@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:51328 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108AbcGYPpc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 Jul 2016 11:45:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hello,

(this is a repost, my previous message seems to be slipping under the radar)

Does anyone get a similar behaviour to the one described below ?

I found a big performance drop between kernel 3.13.0-88 (default kernel on
Ubuntu Trusty 14.04) or kernel 4.2.0 and kernel 4.4.0.24.14 (default kernel on
Ubuntu Xenial 16.04)

- ceph version is Jewel (10.2.2).
- All tests have been done under Ubuntu 14.04 on
- Each cluster has 5 nodes strictly identical.
- Each node has 10 OSDs.
- Journals are on the disk.

Kernel 4.4 has a drop of more than 50% compared to 4.2
Kernel 4.4 has a drop of 40% compared to 3.13

details below :

With the 3 kernel I have the same performance on disks :

Raw benchmark:
dd if=/dev/zero of=/dev/sdX bs=1M count=1024 oflag=direct    => average ~230MB/s
dd if=/dev/zero of=/dev/sdX bs=1G count=1 oflag=direct       => average ~220MB/s

Filesystem mounted benchmark:
dd if=/dev/zero of=/sdX1/test.img bs=1G count=1              => average ~205MB/s
dd if=/dev/zero of=/sdX1/test.img bs=1G count=1 oflag=direct => average ~214MB/s
dd if=/dev/zero of=/sdX1/test.img bs=1G count=1 oflag=sync   => average ~190MB/s

Ceph osd Benchmark:
Kernel 3.13.0-88-generic : ceph tell osd.ID bench => average  ~81MB/s
Kernel 4.2.0-38-generic  : ceph tell osd.ID bench => average ~109MB/s
Kernel 4.4.0-24-generic  : ceph tell osd.ID bench => average  ~50MB/s

I did new benchmarks then on 3 new fresh clusters.

- Each cluster has 3 nodes strictly identical.
- Each node has 10 OSDs.
- Journals are on the disk.

bench5 : Ubuntu 14.04 / Ceph Infernalis
bench6 : Ubuntu 14.04 / Ceph Jewel
bench7 : Ubuntu 16.04 / Ceph jewel

this is the average of 2 runs of "ceph tell osd.* bench" on each cluster (2 x 30
OSDs)

bench5 / 14.04 / Infernalis / kernel 3.13 :  54.35 MB/s
bench6 / 14.04 / Jewel      / kernel 3.13 :  86.47 MB/s

bench5 / 14.04 / Infernalis / kernel 4.2  :  63.38 MB/s
bench6 / 14.04 / Jewel      / kernel 4.2  : 107.75 MB/s
bench7 / 16.04 / Jewel      / kernel 4.2  : 101.54 MB/s

bench5 / 14.04 / Infernalis / kernel 4.4  :  53.61 MB/s
bench6 / 14.04 / Jewel      / kernel 4.4  :  65.82 MB/s
bench7 / 16.04 / Jewel      / kernel 4.4  :  61.57 MB/s

If needed, I have the raw output of "ceph tell osd.* bench"

Best regards

-- 
Yoann Moulin
EPFL IC-IT
