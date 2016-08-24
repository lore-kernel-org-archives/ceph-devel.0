From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Odd WAL traffic for BlueStore
Date: Wed, 24 Aug 2016 21:28:54 +0300
Message-ID: <e4a3dd33-f547-df69-9bd4-889d10d15a76@mirantis.com>
References: <6efcdfb2-e25b-bceb-b10c-0669c813d917@mirantis.com>
 <alpine.DEB.2.11.1608221503560.2394@piezo.us.to>
 <f131f407-0a93-50c0-eab0-3cad3a0009bd@mirantis.com>
 <alpine.DEB.2.11.1608221512080.2394@piezo.us.to>
 <1cca0540-16e2-fbc7-b6fe-e373affd59de@mirantis.com>
 <alpine.DEB.2.11.1608221653450.2394@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36146 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754796AbcHXS26 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 14:28:58 -0400
Received: by mail-lf0-f52.google.com with SMTP id g62so18064626lfe.3
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 11:28:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608221653450.2394@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 22.08.2016 19:55, Sage Weil wrote:
>
> 2) Each 4K is generating a ~10K rocksdb write.  I think this is just the
> size of the onode.  So, same thing we've been working on optimizing.
>
> I don't think there is anything else odd going on...
>
Sage, thanks for diagnosis. Indeed rocksdb traffic is huge.

Now let me share some thoughts w.r.t. onode/blob size reduction.
Currently I'm getting 26K per onode for 4Mb object filled with 4K 
sequential writing and 4K min_alloc_size. Csum is off.
Hence subsequent random 4K overwrite test case on such an object 
triggers 4K disk write and 26K RocksDB overwrite.

Changing min_alloc_size for both test cases to 64K gives 1.6K for onode!!!!
And 4K overwrite test case triggers 4K disk write and 4K (WAL) + 1.6K 
RocksDB overwrite.
And I indeed can see performance gain for the second set for both 
sequential and random writes.

Hence I'm worrying if onode/blob diet makes much sense at all. One has 
to сut Onode/Blob size in 4.6 ( = 26 / 5.6 ) times to win against simple 
min_alloc_size increase.

And another point - speaking of onode size cut for large objects - 
wouldn't it be simpler just to split such an object into 4Mb ( or 
whatever value) shards and handle separately as standalone objects. IMHO 
we just need some simple name+offset -> new name mapper on top of 
current code for that.


> sage
>
>
>
>> Thanks,
>> Igor
>>
>> On 22.08.2016 18:12, Sage Weil wrote:
>>> debug bluestore = 20
>>> debug bluefs = 20
>>> debug rocksdb = 5
>>>
>>> Thanks!
>>> sage
>>>
>>>
>>> On Mon, 22 Aug 2016, Igor Fedotov wrote:
>>>
>>>> Will prepare shortly. Any suggestions on desired levels and components?
>>>>
>>>>
>>>> On 22.08.2016 18:08, Sage Weil wrote:
>>>>> On Mon, 22 Aug 2016, Igor Fedotov wrote:
>>>>>> Hi All,
>>>>>>
>>>>>> While testing BlueStore as a standalone storage via FIO plugin I'm
>>>>>> observing
>>>>>> huge traffic to a WAL device.
>>>>>>
>>>>>> Bluestore is configured to use 2 450 Gb Intel's SSD: INTEL
>>>>>> SSDSC2BX480G4L
>>>>>>
>>>>>> The first SSD is split into 2 partitions (200 & 250 Gb) for Block DB
>>>>>> and
>>>>>> Block
>>>>>> WAL.
>>>>>>
>>>>>> The second is split similarly and first 200Gb partition allocated for
>>>>>> Raw
>>>>>> Block data.
>>>>>>
>>>>>> RocksDB settings are set as Somnath suggested in his 'RocksDB tuning'
>>>>>> . No
>>>>>> much difference comparing to default settings though...
>>>>>>
>>>>>> As a result when doing 4k sequential write (8Gb total) to a fresh
>>>>>> storage
>>>>>> I'm
>>>>>> observing (using nmon and other disk mon tools) significant write
>>>>>> traffic
>>>>>> to
>>>>>> WAL device. And it grows eventually from ~10Mbs to ~170Mbs. Raw Block
>>>>>> device
>>>>>> traffic is pretty stable at ~30 Mbs.
>>>>>>
>>>>>> Additionally I inserted an output for BlueFS perf counters on
>>>>>> umount(l_bluefs_bytes_written_wal & l_bluefs_bytes_written_sst).
>>>>>>
>>>>>> The resulting values are very frustrating: ~28Gb and 4Gb for
>>>>>> l_bluefs_bytes_written_wal & l_bluefs_bytes_written_sst respectively.
>>>>> Yeah, this doesn't seem right.  Have you generated a log to see what is
>>>>> actually happening on each write?  I don't have any bright ideas about
>>>>> what is going wrong here.
>>>>>
>>>>> sage
>>>>>
>>>>>> Doing 64K changes the picture dramatically:
>>>>>>
>>>>>> WAL traffic is stable at 10-12 Mbs and RAW Block one is at ~400Mbs
>>>>>> BlueFS counters are ~140Mb and 1K respectively.
>>>>>>
>>>>>> Surely write completes much faster in the second case.
>>>>>>
>>>>>> No WAL is reported in logs at BlueStore level for both cases.
>>>>>>
>>>>>>
>>>>>> High BlueFS WAL traffic is observed when running subsequent random 4K
>>>>>> RW
>>>>>> over
>>>>>> the store propagated this way too.
>>>>>>
>>>>>> I'm wondering why WAL device is involved in the process at all (
>>>>>> writes
>>>>>> happen
>>>>>> in min_alloc_size blocks) operate and why the traffic and written data
>>>>>> volume
>>>>>> is so high?
>>>>>>
>>>>>> Don't we have some fault affecting 4K performance here?
>>>>>>
>>>>>>
>>>>>> Here are my settings and FIO job specification:
>>>>>>
>>>>>> ###########################
>>>>>>
>>>>>> [global]
>>>>>>            debug bluestore = 0/0
>>>>>>            debug bluefs = 1/0
>>>>>>            debug bdev = 0/0
>>>>>>            debug rocksdb = 0/0
>>>>>>
>>>>>>            # spread objects over 8 collections
>>>>>>            osd pool default pg num = 32
>>>>>>            log to stderr = false
>>>>>>
>>>>>> [osd]
>>>>>>            osd objectstore = bluestore
>>>>>>            bluestore_block_create = true
>>>>>>            bluestore_block_db_create = true
>>>>>>            bluestore_block_wal_create = true
>>>>>>            bluestore_min_alloc_size = 4096
>>>>>>            #bluestore_max_alloc_size = #or 4096
>>>>>>            bluestore_fsck_on_mount = false
>>>>>>
>>>>>>            bluestore_block_path=/dev/sdi1
>>>>>>            bluestore_block_db_path=/dev/sde1
>>>>>>            bluestore_block_wal_path=/dev/sde2
>>>>>>
>>>>>>            enable experimental unrecoverable data corrupting features =
>>>>>> bluestore
>>>>>> rocksdb memdb
>>>>>>
>>>>>>            bluestore_rocksdb_options =
>>>>>> "max_write_buffer_number=16,min_write_buffer_number_to_merge=2,recycle_log_file_num=16,compaction_threads=32,flusher_threads=8,max_background_compactions=32,max_background_flushes=8,max_bytes_for_level_base=5368709120,write_buffer_size=83886080,level0_file_num_compaction_trigger=4,level0_slowdown_writes_trigger=400,level0_stop_writes_trigger=800"
>>>>>>
>>>>>>            rocksdb_cache_size = 4294967296
>>>>>>            bluestore_csum = false
>>>>>>            bluestore_csum_type = none
>>>>>>            bluestore_bluefs_buffered_io = false
>>>>>>            bluestore_max_ops = 30000
>>>>>>            bluestore_max_bytes = 629145600
>>>>>>            bluestore_buffer_cache_size = 104857600
>>>>>>            bluestore_block_wal_size = 0
>>>>>>
>>>>>>            # use directory= option from fio job file
>>>>>>            osd data = ${fio_dir}
>>>>>>
>>>>>>            # log inside fio_dir
>>>>>>            log file = ${fio_dir}/log
>>>>>> ####################################
>>>>>>
>>>>>> #FIO jobs
>>>>>> #################
>>>>>> # Runs a 4k random write test against the ceph BlueStore.
>>>>>> [global]
>>>>>> ioengine=/usr/local/lib/libfio_ceph_objectstore.so # must be found in
>>>>>> your
>>>>>> LD_LIBRARY_PATH
>>>>>>
>>>>>> conf=ceph-bluestore-somnath.conf # must point to a valid ceph
>>>>>> configuration
>>>>>> file
>>>>>> directory=./fio-bluestore # directory for osd_data
>>>>>>
>>>>>> rw=write
>>>>>> iodepth=16
>>>>>> size=256m
>>>>>>
>>>>>> [bluestore]
>>>>>> nr_files=63
>>>>>> bs=4k        # or 64k
>>>>>> numjobs=32
>>>>>> #############
>>>>>>
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>>> in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

