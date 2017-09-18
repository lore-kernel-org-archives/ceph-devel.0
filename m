From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: Bluestore aio_nr?
Date: Tue, 19 Sep 2017 00:53:07 +0800
Message-ID: <CAEYCsVKhqz+Zz_MyAv4qrd9Miv7mhFN9TuTdqTkcjAtXor=-iA@mail.gmail.com>
References: <CAEYCsVJNnY7yV=VjfdP7B3jtVMz5v=8a9MmVPqS0kyhdKf0Tvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:45999 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932904AbdIRQxJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Sep 2017 12:53:09 -0400
Received: by mail-it0-f46.google.com with SMTP id v19so1387214ite.0
        for <ceph-devel@vger.kernel.org>; Mon, 18 Sep 2017 09:53:09 -0700 (PDT)
In-Reply-To: <CAEYCsVJNnY7yV=VjfdP7B3jtVMz5v=8a9MmVPqS0kyhdKf0Tvg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Some logs below,  seems we only have 3 bdev, , 2 for bluefs and 1 for block.

2017-09-18 09:27:54.540626 7f1069803d00  0 set uid:gid to 64045:64045
(ceph:ceph)
2017-09-18 09:27:54.540646 7f1069803d00  0 ceph version 12.2.0
(32ce2a3ae5239ee33d6150705cdb24d43bab910c) luminous (rc), process
(unknown), pid 997367
2017-09-18 09:27:54.546966 7f1069803d00  0 pidfile_write: ignore empty
--pid-file
2017-09-18 09:27:54.552735 7f1069803d00  0 load: jerasure load: lrc load: isa
2017-09-18 09:27:54.552793 7f1069803d00  1 bdev create path
/var/lib/ceph/osd/pre-prod-420/block type kernel
2017-09-18 09:27:54.552801 7f1069803d00  1 bdev(0x7f1074609a00
/var/lib/ceph/osd/pre-prod-420/block) open path
/var/lib/ceph/osd/pre-prod-420/block
2017-09-18 09:27:54.553054 7f1069803d00  1 bdev(0x7f1074609a00
/var/lib/ceph/osd/pre-prod-420/block) open size 5996731674624
(0x574390fb000, 5584 GB) block_size 4096 (4096 B) rotational
2017-09-18 09:27:54.553207 7f1069803d00  1
bluestore(/var/lib/ceph/osd/pre-prod-420) _set_cache_sizes max 0.5 <
ratio 0.99
2017-09-18 09:27:54.553234 7f1069803d00  1
bluestore(/var/lib/ceph/osd/pre-prod-420) _set_cache_sizes cache_size
1073741824 meta 0.5 kv 0.5 data 0
2017-09-18 09:27:54.553239 7f1069803d00  1 bdev(0x7f1074609a00
/var/lib/ceph/osd/pre-prod-420/block) close
2017-09-18 09:27:54.803895 7f1069803d00  1
bluestore(/var/lib/ceph/osd/pre-prod-420) _mount path
/var/lib/ceph/osd/pre-prod-420
2017-09-18 09:27:54.803987 7f1069803d00  1 bdev create path
/var/lib/ceph/osd/pre-prod-420/block type kernel
2017-09-18 09:27:54.804003 7f1069803d00  1 bdev(0x7f1074609800
/var/lib/ceph/osd/pre-prod-420/block) open path
/var/lib/ceph/osd/pre-prod-420/block
2017-09-18 09:27:54.804356 7f1069803d00  1 bdev(0x7f1074609800
/var/lib/ceph/osd/pre-prod-420/block) open size 5996731674624
(0x574390fb000, 5584 GB) block_size 4096 (4096 B) rotational
2017-09-18 09:27:54.804536 7f1069803d00  1
bluestore(/var/lib/ceph/osd/pre-prod-420) _set_cache_sizes max 0.5 <
ratio 0.99
2017-09-18 09:27:54.804546 7f1069803d00  1
bluestore(/var/lib/ceph/osd/pre-prod-420) _set_cache_sizes cache_size
1073741824 meta 0.5 kv 0.5 data 0
2017-09-18 09:27:54.804593 7f1069803d00  1 bdev create path
/var/lib/ceph/osd/pre-prod-420/block.db type kernel
2017-09-18 09:27:54.804619 7f1069803d00  1 bdev(0x7f1074a45000
/var/lib/ceph/osd/pre-prod-420/block.db) open path
/var/lib/ceph/osd/pre-prod-420/block.db
2017-09-18 09:27:54.804825 7f1069803d00  1 bdev(0x7f1074a45000
/var/lib/ceph/osd/pre-prod-420/block.db) open size 96019152896
(0x165b300000, 91571 MB) block_size 4096 (4096 B) non-rotational
2017-09-18 09:27:54.804832 7f1069803d00  1 bluefs add_block_device
bdev 1 path /var/lib/ceph/osd/pre-prod-420/block.db size 91571 MB
2017-09-18 09:27:54.805053 7f1069803d00  1 bdev create path
/var/lib/ceph/osd/pre-prod-420/block type kernel
2017-09-18 09:27:54.805060 7f1069803d00  1 bdev(0x7f1074a44e00
/var/lib/ceph/osd/pre-prod-420/block) open path
/var/lib/ceph/osd/pre-prod-420/block
2017-09-18 09:27:54.805205 7f1069803d00  1 bdev(0x7f1074a44e00
/var/lib/ceph/osd/pre-prod-420/block) open size 5996731674624
(0x574390fb000, 5584 GB) block_size 4096 (4096 B) rotational
2017-09-18 09:27:54.805212 7f1069803d00  1 bluefs add_block_device
bdev 2 path /var/lib/ceph/osd/pre-prod-420/block size 5584 GB
2017-09-18 09:27:54.805245 7f1069803d00  1 bluefs mount

2017-09-19 0:44 GMT+08:00 Xiaoxi Chen <superdebuger@gmail.com>:
> Hi,
>      I just hit an OSD cannot start due to insufficient aio_nr.  Each
> OSD is with a separate SSD partition as db.block
>      Further checking showing 6144 AIO contexts were required per OSD,
>  could anyone explain a little bit on where the 6144 aio contexts goes
> to?
>
>      It looks to me like the bdev_aio_max_queue_depth is default to
> 1024, but  how can we have 6 bdev to get 6144?
>
> Xiaoxi
