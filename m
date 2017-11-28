From: shasha lu <lushasha08@gmail.com>
Subject: metadata spill back onto block.slow before block.db filled up
Date: Tue, 28 Nov 2017 13:50:00 +0800
Message-ID: <CAKEPnAaF60ywk67KeZ4PkEcqKDqu8c_2_EjzSK_DqusDR2Fjog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36598 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbdK1FuB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 00:50:01 -0500
Received: by mail-yw0-f193.google.com with SMTP id g193so2593308ywe.3
        for <ceph-devel@vger.kernel.org>; Mon, 27 Nov 2017 21:50:01 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Mark Nelson <mark.a.nelson@gmail.com>

Hi, Mark
We test bluestore with 12.2.1.
There are two host in our rgw cluster, each host contain 2 osds. The
rgw pool size is 2.  Using a 5GB partition for db.wal, a 50GB SSD
partition for block.db.

# ceph --admin-daemon ceph-osd.1.asok config get rocksdb_db_paths
{
    "rocksdb_db_paths": "db,51002736640 db.slow,284999998054"
}

After writing about 400W 4k rgw objects, using ceph-bluestore-tool to
export rocksdb file.

# ceph-bluestore-tool bluefs-export --path /var/lib/ceph/osd/osd1
--out-dir /tmp/osd1
# cd /tmp/osd1
# ls
db  db.slow  db.wal
# du -sh *
2.8G    db
809M    db.slow
439M    db.wal

block.db partition have 50GB space, but it only contains ~3GB files.
Then the metadata rolling over onto the db.slow.
It seems that only L0-L2 files located in block.db. (L0 256M; L1 256M;
L2 2.5GB), L3 and higher level file located in db.slow.

According to ceph docs, the metadata rolling over onto the db.slow
only when block.db filled up. But in our env the block.db partition is
far from filled up.
Did I make any mistakes?  Is there any additional options should be
set to rocksdb?


Thanks,
Shasha Lu
