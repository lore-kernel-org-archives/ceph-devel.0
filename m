From: Igor Fedotov <ifedotov@suse.de>
Subject: Re: metadata spill back onto block.slow before block.db filled up
Date: Thu, 30 Nov 2017 16:14:52 +0300
Message-ID: <f81eee3a-942a-baf1-26f1-3dcb08721220@suse.de>
References: <CAKEPnAaF60ywk67KeZ4PkEcqKDqu8c_2_EjzSK_DqusDR2Fjog@mail.gmail.com>
 <alpine.DEB.2.11.1711281316180.2819@piezo.novalocal>
 <fc7b7cd0-0b36-7bd7-0310-70cd9dcc1048@suse.de>
 <ceb00aa7-6229-362e-8234-4f7cbfc23cb2@gmail.com>
 <da7260ee-d0cd-1873-9faa-36f747745ef7@suse.de>
 <adca6bbb-ffb0-78d0-1cc2-36dc286bf15c@suse.de>
 <alpine.DEB.2.11.1711291306231.19791@piezo.novalocal>
 <CAKEPnAY6QFE_YDsFsDRafgc93rys=qNY57hrH6dr0UQjXd27PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38961 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751929AbdK3NO4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Nov 2017 08:14:56 -0500
In-Reply-To: <CAKEPnAY6QFE_YDsFsDRafgc93rys=qNY57hrH6dr0UQjXd27PQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: shasha lu <lushasha08@gmail.com>, Sage Weil <sage@newdream.net>
Cc: Mark Nelson <mark.a.nelson@gmail.com>, ceph-devel@vger.kernel.org

Submitted PR https://github.com/ceph/ceph/pull/19257


On 11/30/2017 12:40 PM, shasha lu wrote:
> After cherry-picking that commit, the problem doesn't reproduce in our env.
> All L0-L3 files located in db now.  (L0 256M; L1 256M; L2 2.5G;  L3 25G)
> L4 250G, all of L4 can't fit on db, so it will put all of L4 on db.slow.
>
> ceph daemon osd.4 perf dump | grep bluefs -A 17
>      "bluefs": {
>          "gift_bytes": 0,
>          "reclaim_bytes": 0,
>          "db_total_bytes": 53687083008,
>          "db_used_bytes": 5341446144,
>          "wal_total_bytes": 5368705024,
>          "wal_used_bytes": 524288000,
>          "slow_total_bytes": 12000952320,
>          "slow_used_bytes": 0,
>          "num_files": 94,
>          "log_bytes": 3330048,
>          "log_compactions": 2,
>          "logged_bytes": 556756992,
>          "files_written_wal": 2,
>          "files_written_sst": 620,
>          "bytes_written_wal": 32516096174,
>          "bytes_written_sst": 38724761218
>      },
>
> The rocksdb of ceph master already cherry-picking that. But v12.2.1
> still have this problem.
>
> So the size of db should be well planed.  The size of db is 30GB or
> 100GB make no difference. It will put all of L4 on db.slow.
>
> Shasha
>
> 2017-11-29 21:07 GMT+08:00 Sage Weil <sage@newdream.net>:
>> On Wed, 29 Nov 2017, Igor Fedotov wrote:
>>> I've just updated the bug notes.
>>>
>>> Most probably the issue is caused by an already fixed bug in RocksDB,
>>>
>>> see
>>> https://github.com/facebook/rocksdb/commit/65a9cd616876c7a1204e1a50990400e4e1f61d7e
>>>
>>> Hence the question is if we plan to backport the fix and how to arrange that.
>> If you cna confirm the problem doesn't reproduce after cherry-picking that
>> commit, we can just do that for the luminous branch.
>>
>> For master, let's fast forward rocksdb past it?
>>
>> sage
>>
>>
>>> Thanks,
>>> Igor
>>>
>>> On 11/28/2017 6:44 PM, Igor Fedotov wrote:
>>>> here it is
>>>>
>>>> http://tracker.ceph.com/issues/22264
>>>>
>>>>
>>>> On 11/28/2017 6:37 PM, Mark Nelson wrote:
>>>>> Looks like a bug guys! :)  Mind making a ticket in the tracker?
>>>>>
>>>>> Mark
>>>>>
>>>>> On 11/28/2017 07:39 AM, Igor Fedotov wrote:
>>>>>> Looks like I can easily reproduce that (note slow_used_bytes):
>>>>>>
>>>>>>   "bluefs": {
>>>>>>          "gift_bytes": 105906176,
>>>>>>          "reclaim_bytes": 0,
>>>>>>          "db_total_bytes": 4294959104,
>>>>>>          "db_used_bytes": 76546048,
>>>>>>          "wal_total_bytes": 1073737728,
>>>>>>          "wal_used_bytes": 239075328,
>>>>>>          "slow_total_bytes": 1179648000,
>>>>>>          "slow_used_bytes": 63963136,
>>>>>>          "num_files": 13,
>>>>>>          "log_bytes": 2539520,
>>>>>>          "log_compactions": 3,
>>>>>>          "logged_bytes": 255176704,
>>>>>>          "files_written_wal": 3,
>>>>>>          "files_written_sst": 10,
>>>>>>          "bytes_written_wal": 1932165189,
>>>>>>          "bytes_written_sst": 340957748
>>>>>>      },
>>>>>>
>>>>>>
>>>>>> On 11/28/2017 4:17 PM, Sage Weil wrote:
>>>>>>> Hi Shasha,
>>>>>>>
>>>>>>> On Tue, 28 Nov 2017, shasha lu wrote:
>>>>>>>> Hi, Mark
>>>>>>>> We test bluestore with 12.2.1.
>>>>>>>> There are two host in our rgw cluster, each host contain 2 osds. The
>>>>>>>> rgw pool size is 2.  Using a 5GB partition for db.wal, a 50GB SSD
>>>>>>>> partition for block.db.
>>>>>>>>
>>>>>>>> # ceph --admin-daemon ceph-osd.1.asok config get rocksdb_db_paths
>>>>>>>> {
>>>>>>>>       "rocksdb_db_paths": "db,51002736640 db.slow,284999998054"
>>>>>>>> }
>>>>>>>>
>>>>>>>> After writing about 400W 4k rgw objects, using ceph-bluestore-tool
>>>>>>>> to
>>>>>>>> export rocksdb file.
>>>>>>>>
>>>>>>>> # ceph-bluestore-tool bluefs-export --path /var/lib/ceph/osd/osd1
>>>>>>>> --out-dir /tmp/osd1
>>>>>>>> # cd /tmp/osd1
>>>>>>>> # ls
>>>>>>>> db  db.slow  db.wal
>>>>>>>> # du -sh *
>>>>>>>> 2.8G    db
>>>>>>>> 809M    db.slow
>>>>>>>> 439M    db.wal
>>>>>>>>
>>>>>>>> block.db partition have 50GB space, but it only contains ~3GB files.
>>>>>>>> Then the metadata rolling over onto the db.slow.
>>>>>>>> It seems that only L0-L2 files located in block.db. (L0 256M; L1
>>>>>>>> 256M;
>>>>>>>> L2 2.5GB), L3 and higher level file located in db.slow.
>>>>>>>>
>>>>>>>> According to ceph docs, the metadata rolling over onto the db.slow
>>>>>>>> only when block.db filled up. But in our env the block.db partition
>>>>>>>> is
>>>>>>>> far from filled up.
>>>>>>>> Did I make any mistakes?  Is there any additional options should be
>>>>>>>> set to rocksdb?
>>>>>>> You didn't make any mistakes--this should happen automatically.  It
>>>>>>> looks
>>>>>>> like rocksdb isn't behaving as advertised.  I've opened
>>>>>>> http://tracker.ceph.com/issues/22264 to track this.  We need to start
>>>>>>> by
>>>>>>> reproducing the situation.
>>>>>>>
>>>>>>> My guess is that rocksdb is deciding that deciding that all of L3
>>>>>>> can't
>>>>>>> fit on db and so it's putting all of L3 on db.slow?
>>>>>>>
>>>>>>> sage
>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>>>> in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>

