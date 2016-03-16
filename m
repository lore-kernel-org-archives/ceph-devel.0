From: Huan Zhang <huan.zhang.jn@gmail.com>
Subject: rbd_aio_flush cause guestos sync wirte poor iops?
Date: Wed, 16 Mar 2016 12:52:33 +0800
Message-ID: <CAFU9Co=d-CstfhbiP3ztdpNTFp03SMGy8ciRw8xxBXkxw7TjRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36412 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934559AbcCPEwe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 00:52:34 -0400
Received: by mail-lb0-f171.google.com with SMTP id x1so40283692lbj.3
        for <ceph-devel@vger.kernel.org>; Tue, 15 Mar 2016 21:52:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
   We test sync iops with fio sync=1 for database workloads in VM,
the backend is librbd and ceph (all SSD setup).'
   The result is sad to me. we only get ~400 IOPS sync randwrite with iodepth=1
to iodepth=32.
    But test in physical machine with fio ioengine=rbd sync=1, we can
reache ~35K IOPS.
seems the qemu rbd is the bottleneck.

    qemu version is 2.1.2 with rbd_aio_flush patched.
    rbd cache is off, qemu cache=none.

    IMHO, ceph use sync write for every write to disk, so
rbd_aio_flush can ignore the sync
cache command if rbd cache is off so that we can get higher
iops(similar to direct=1 write)
for sync=1 iops, right?

   Very appreciated to get your reply!
