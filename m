From: Andrey Korolyov <andrey@xdel.ru>
Subject: Mysteriously poor write performance
Date: Sat, 17 Mar 2012 14:35:49 +0300
Message-ID: <CABYiri-C1ftxsM3dWqtcRzXBYoddRbHug=TA6j+0EY-cuMt3Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52892 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756267Ab2CQLgL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Mar 2012 07:36:11 -0400
Received: by wibhq7 with SMTP id hq7so1956908wib.1
        for <ceph-devel@vger.kernel.org>; Sat, 17 Mar 2012 04:36:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I`ve did some performance tests at the following configuration:

mon0, osd0 and mon1, osd1 - two twelve-core r410 with 32G ram, mon2 -
dom0 with three dedicated cores and 1.5G, mostly idle. First three
disks on each r410 arranged into raid0 and holds osd data when fourth
holds os and osd` journal partition, all ceph-related stuff mounted on
the ext4 without barriers.

Firstly, I`ve noticed about a difference of benchmark performance and
write speed through rbd from small kvm instance running on one of
first two machines - when bench gave me about 110Mb/s, writing zeros
to raw block device inside vm with dd was at top speed about 45 mb/s,
for vm`fs (ext4 with default options) performance drops to ~23Mb/s.
Things get worse, when I`ve started second vm at second host and tried
to continue same dd tests simultaneously - performance fairly divided
by half for each instance :). Enabling jumbo frames, playing with cpu
affinity for ceph and vm instances and trying different TCP congestion
protocols gave no effect at all - with DCTCP I have slightly smoother
network load graph and that`s all.

Can ml please suggest anything to try to improve performance?

ceph-0.43, libvirt-0.9.8, qemu-1.0.0, kernel 3.2
