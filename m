From: Sage Weil <sage@newdream.net>
Subject: Re: metadata spill back onto block.slow before block.db filled up
Date: Tue, 28 Nov 2017 13:17:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711281316180.2819@piezo.novalocal>
References: <CAKEPnAaF60ywk67KeZ4PkEcqKDqu8c_2_EjzSK_DqusDR2Fjog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:51126 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbdK1NSC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 08:18:02 -0500
In-Reply-To: <CAKEPnAaF60ywk67KeZ4PkEcqKDqu8c_2_EjzSK_DqusDR2Fjog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: shasha lu <lushasha08@gmail.com>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.a.nelson@gmail.com>

Hi Shasha,

On Tue, 28 Nov 2017, shasha lu wrote:
> Hi, Mark
> We test bluestore with 12.2.1.
> There are two host in our rgw cluster, each host contain 2 osds. The
> rgw pool size is 2.  Using a 5GB partition for db.wal, a 50GB SSD
> partition for block.db.
> 
> # ceph --admin-daemon ceph-osd.1.asok config get rocksdb_db_paths
> {
>     "rocksdb_db_paths": "db,51002736640 db.slow,284999998054"
> }
> 
> After writing about 400W 4k rgw objects, using ceph-bluestore-tool to
> export rocksdb file.
> 
> # ceph-bluestore-tool bluefs-export --path /var/lib/ceph/osd/osd1
> --out-dir /tmp/osd1
> # cd /tmp/osd1
> # ls
> db  db.slow  db.wal
> # du -sh *
> 2.8G    db
> 809M    db.slow
> 439M    db.wal
> 
> block.db partition have 50GB space, but it only contains ~3GB files.
> Then the metadata rolling over onto the db.slow.
> It seems that only L0-L2 files located in block.db. (L0 256M; L1 256M;
> L2 2.5GB), L3 and higher level file located in db.slow.
> 
> According to ceph docs, the metadata rolling over onto the db.slow
> only when block.db filled up. But in our env the block.db partition is
> far from filled up.
> Did I make any mistakes?  Is there any additional options should be
> set to rocksdb?

You didn't make any mistakes--this should happen automatically.  It looks 
like rocksdb isn't behaving as advertised.  I've opened 
http://tracker.ceph.com/issues/22264 to track this.  We need to start by 
reproducing the situation.

My guess is that rocksdb is deciding that deciding that all of L3 can't 
fit on db and so it's putting all of L3 on db.slow?

sage

