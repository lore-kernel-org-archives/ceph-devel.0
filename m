From: xiaoyan li <wisher2003@gmail.com>
Subject: Bluestore IO latency is little in OSD latency
Date: Thu, 24 Aug 2017 08:53:27 +0800
Message-ID: <CAERxPZLccbqKe+E_WVQUU1xhoM7wiy-_g_gE=+DdV8JaLb+8Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33997 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdHXAx2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Aug 2017 20:53:28 -0400
Received: by mail-oi0-f51.google.com with SMTP id j144so17108505oib.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Aug 2017 17:53:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

Currently I did some tests and analyzed the time span in OSD IO
latency using perfcounter. I have some concerns please help.

My hardwrare:
CPU: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
RAM: 128G
SSD: P3700 400G

Software:
Master branch
commit 021177b7902f8337686bb8b655d87600b07d921c
Merge: 1b21476 75b4256
Author: David Zafman <dzafman@redhat.com>
Date:   Thu Aug 17 20:05:40 2017 -0700

Steps:
1. I created a cluster with one osd, and then create 10 2GB rbd images.
2. Use fio+librbd to do random 4k write IOs.
3. I got perfcounter every 3 mins and reset.

The charts is here: bluestore_latency is from bluestore/commit_lat,
and osd_latency is from osd/op_latency.
https://drive.google.com/drive/folders/0B6jqFc7e2yxVQk16VUotQVBUZ3c?usp=sharing

My concern is that bluestore latency is very very little compared to
osd latency. Please see the chart osd_time_span.png in above google
drive.
Any one know why? What should I do to improve the performance?

Ceph config file and fio config is following.

Config:

[global]
    fsid = 18677778-8289-11e7-b44b-a4bf0118d2ff
    pid_path = /var/run/ceph
    osd pool default size = 1
    auth_service_required = none
    auth_cluster_required = none
    auth_client_required = none
    enable experimental unrecoverable data corrupting features = *
    osd_objectstore = bluestore
    mon allow pool delete = true
    debug bluestore = 1/1
        debug bluefs = 0/0
        debug bdev = 0/0
        debug rocksdb = 0/0
        osd pool default pg num = 2
        osd op num shards = 8
[mon]
    mon_data = /var/lib/ceph/mon.$id
[osd]
    osd_data = /var/lib/ceph/mnt/osd-device-$id-data
    osd_mkfs_type = xfs
    osd_mount_options_xfs = rw,noatime,inode64,logbsize=256k
[client]
    rbd_cache = false
[mon.sceph9]
    host = sceph9
    mon addr = 172.18.0.1
[osd.0]
    host = sceph9
    public addr = 172.18.0.1
    cluster addr = 172.18.0.1
    devs = /dev/nvme0n1
    bluestore_block_path = /dev/nvme0n1p1
    bluestore_block_db_path = /dev/nvme0n1p2
    bluestore_block_wal_path = /dev/nvme0n1p3
    log file = /opt/fio_test/osd/osd.log


fio.conf

[global]

ioengine=rbd
clientname=admin
rw=randwrite
bs=4k
time_based=1
runtime=3600s
iodepth=64

[rbd0]
pool=rbd
rbdname=rbd0

[rbd1]
pool=rbd
rbdname=rbd1

[rbd2]
pool=rbd
rbdname=rbd2

[rbd3]
pool=rbd
rbdname=rbd3

[rbd4]
pool=rbd
rbdname=rbd4

[rbd10]
pool=rbd1
rbdname=rbd0

[rbd11]
pool=rbd1
rbdname=rbd1

...

-- 
Best wishes
Lisa
