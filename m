From: Yi Huaijie <yihuaijiereal@gmail.com>
Subject: [GSoC]Implement cache layer on top of userspace nvme driver. Inbox x
Date: Mon, 7 Mar 2016 13:56:43 +0800
Message-ID: <CA+Da5Jb-=jeNa+9J9_ftZgwB4FvEfbOXdiOLcY_JP9rTPh5oTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35158 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbcCGF4o convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2016 00:56:44 -0500
Received: by mail-vk0-f46.google.com with SMTP id e6so106701539vkh.2
        for <ceph-devel@vger.kernel.org>; Sun, 06 Mar 2016 21:56:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>, ceph-devel@vger.kernel.org

Hello,
I am a first-year student for my Master Degree at Nanjing University,
China. My research area focuses on distributed storage. Our team has
been worked with a project on Ceph for a half year. I am very
interested in your idea that implement cache layer on top of userspace
nvme driver. Here is my understand of your idea.

Ceph=E2=80=99s OSDS used to lay on filestore which uses the local POSIX=
 file
system such XFS/BtrFS/EXT4. But it works poor for Ceph, so bluestore
was designed to replace it.One major difference from filestore is that
bluestore use rocksDB for managing metadata. RocksDB has ideal
key/value interface, it support transactions, uses ordered
enumeration, and can fast commits to log/journal. RocksDB also has
common interface, we can always swap in another KB DB if we want. In
bluestore rocksDB is used to save object metadata, write-ahead log,
ceph key/value omap data and allocator metadata.

At the bottom of the bluestore architecture is disk which can be HDD
or SSD. On top of the disks is the driver layer which include kernel
driver and userspace driver SPDK. With these drivers, the host
provides a block device layer which was bluestore built on.

SPDK is used to accelerate the speed of NVME SSD. NVME SSDs have very
high speed, its IOPS can reaches millions times per second. If we use
kernel driver, the system must switch between kernel and user mod
frequently, and the CPU cost of interrupt can be very high. The result
is that the kernel driver slow down the disk IOPS. SPDK runs in
userspace and uses polling instead of interrupt

Metadata cache is very critical for a better file system throughput,
because metadata operations occupy more than half of the I/O.
Currently bluestore has implemented kernel driver cache uses pagecache
to accelerate metadata, userspace NVME driver lacks any sort of memory
cache to help performance. So I apply this project to implement the
userspace NVME cache.

The implementation will uses the knowledge of SPDK=EF=BC=8CrocksDB and
pagecache. The goal is to cache metadata saved in rocksDB using API
provided by SPDK. Because rocksDB is a key-value storage that much
like database, so we could use the cache strategy implemented by
database such as SQLite. Fellow aspects are the most important we must
consider:

1=EF=BC=89Consistency, which is related to the correctness of the data.=
 We
could use a dirty list to mark the pages in cache that have been
modified, and make some operations to obtain the consistency.
2=EF=BC=89hit rate, which is critical to the efficiency, high hit rate =
gives
high efficiency, hit rate is related to the policy of page
replacement.
3=EF=BC=89valid rate, which is concerned with the memory space use. It =
is
somehow related to policy of page replacement too.
4=EF=BC=89What to cache. I think the memTable of rocksDB could server a=
s the
cache for a write operation. So the cache should focus on the metadata
querry operation.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
