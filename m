From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: Re: metadata spill back onto block.slow before block.db filled up
Date: Tue, 28 Nov 2017 09:37:25 -0600
Message-ID: <ceb00aa7-6229-362e-8234-4f7cbfc23cb2@gmail.com>
References: <CAKEPnAaF60ywk67KeZ4PkEcqKDqu8c_2_EjzSK_DqusDR2Fjog@mail.gmail.com>
 <alpine.DEB.2.11.1711281316180.2819@piezo.novalocal>
 <fc7b7cd0-0b36-7bd7-0310-70cd9dcc1048@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36812 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753212AbdK1Ph3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 10:37:29 -0500
Received: by mail-pg0-f51.google.com with SMTP id k134so86384pga.3
        for <ceph-devel@vger.kernel.org>; Tue, 28 Nov 2017 07:37:29 -0800 (PST)
In-Reply-To: <fc7b7cd0-0b36-7bd7-0310-70cd9dcc1048@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@suse.de>, Sage Weil <sage@newdream.net>, shasha lu <lushasha08@gmail.com>
Cc: ceph-devel@vger.kernel.org

Looks like a bug guys! :)  Mind making a ticket in the tracker?

Mark

On 11/28/2017 07:39 AM, Igor Fedotov wrote:
> Looks like I can easily reproduce that (note slow_used_bytes):
>
>  "bluefs": {
>         "gift_bytes": 105906176,
>         "reclaim_bytes": 0,
>         "db_total_bytes": 4294959104,
>         "db_used_bytes": 76546048,
>         "wal_total_bytes": 1073737728,
>         "wal_used_bytes": 239075328,
>         "slow_total_bytes": 1179648000,
>         "slow_used_bytes": 63963136,
>         "num_files": 13,
>         "log_bytes": 2539520,
>         "log_compactions": 3,
>         "logged_bytes": 255176704,
>         "files_written_wal": 3,
>         "files_written_sst": 10,
>         "bytes_written_wal": 1932165189,
>         "bytes_written_sst": 340957748
>     },
>
>
> On 11/28/2017 4:17 PM, Sage Weil wrote:
>> Hi Shasha,
>>
>> On Tue, 28 Nov 2017, shasha lu wrote:
>>> Hi, Mark
>>> We test bluestore with 12.2.1.
>>> There are two host in our rgw cluster, each host contain 2 osds. The
>>> rgw pool size is 2.  Using a 5GB partition for db.wal, a 50GB SSD
>>> partition for block.db.
>>>
>>> # ceph --admin-daemon ceph-osd.1.asok config get rocksdb_db_paths
>>> {
>>>      "rocksdb_db_paths": "db,51002736640 db.slow,284999998054"
>>> }
>>>
>>> After writing about 400W 4k rgw objects, using ceph-bluestore-tool to
>>> export rocksdb file.
>>>
>>> # ceph-bluestore-tool bluefs-export --path /var/lib/ceph/osd/osd1
>>> --out-dir /tmp/osd1
>>> # cd /tmp/osd1
>>> # ls
>>> db  db.slow  db.wal
>>> # du -sh *
>>> 2.8G    db
>>> 809M    db.slow
>>> 439M    db.wal
>>>
>>> block.db partition have 50GB space, but it only contains ~3GB files.
>>> Then the metadata rolling over onto the db.slow.
>>> It seems that only L0-L2 files located in block.db. (L0 256M; L1 256M;
>>> L2 2.5GB), L3 and higher level file located in db.slow.
>>>
>>> According to ceph docs, the metadata rolling over onto the db.slow
>>> only when block.db filled up. But in our env the block.db partition is
>>> far from filled up.
>>> Did I make any mistakes?  Is there any additional options should be
>>> set to rocksdb?
>> You didn't make any mistakes--this should happen automatically.  It looks
>> like rocksdb isn't behaving as advertised.  I've opened
>> http://tracker.ceph.com/issues/22264 to track this.  We need to start by
>> reproducing the situation.
>>
>> My guess is that rocksdb is deciding that deciding that all of L3 can't
>> fit on db and so it's putting all of L3 on db.slow?
>>
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
