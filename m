From: Haomai Wang <haomai@xsky.com>
Subject: Re: Odd WAL traffic for BlueStore
Date: Mon, 22 Aug 2016 23:17:58 +0800
Message-ID: <CACJqLyZ26tD_FzJEXk1TcFqRKL150--CgQvbR5e9O92QjNWOXQ@mail.gmail.com>
References: <6efcdfb2-e25b-bceb-b10c-0669c813d917@mirantis.com>
 <alpine.DEB.2.11.1608221503560.2394@piezo.us.to> <f131f407-0a93-50c0-eab0-3cad3a0009bd@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ty1jpn01on0117.outbound.protection.outlook.com ([104.47.93.117]:19675
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932442AbcHVPSS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 Aug 2016 11:18:18 -0400
Received: by mail-ua0-f171.google.com with SMTP id n59so194314831uan.2
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2016 08:18:08 -0700 (PDT)
In-Reply-To: <f131f407-0a93-50c0-eab0-3cad3a0009bd@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 22, 2016 at 11:10 PM, Igor Fedotov <ifedotov@mirantis.com> wrot=
e:
>
> Will prepare shortly. Any suggestions on desired levels and components?


hmm, I also met this problem for last WAL perf between filejournal and
rocksdb. For normal case, we will reuse recycle log while writing
enough data as sage mentioned. But I found it's strange while stress
writing doesn't discard bluefs inode metadata update. The rocksdb wal
log file continues to grow while writing hundreds of logs, I can see
bluefs wal log file's inode size exceed 500MB.....

I stopped at looking at DBImpl::SwitchMemtable. maybe you can see
whether your case is recycle log isn't switch?

>
>
>
>
> On 22.08.2016 18:08, Sage Weil wrote:
>>
>> On Mon, 22 Aug 2016, Igor Fedotov wrote:
>>>
>>> Hi All,
>>>
>>> While testing BlueStore as a standalone storage via FIO plugin I'm obse=
rving
>>> huge traffic to a WAL device.
>>>
>>> Bluestore is configured to use 2 450 Gb Intel's SSD: INTEL SSDSC2BX480G=
4L
>>>
>>> The first SSD is split into 2 partitions (200 & 250 Gb) for Block DB an=
d Block
>>> WAL.
>>>
>>> The second is split similarly and first 200Gb partition allocated for R=
aw
>>> Block data.
>>>
>>> RocksDB settings are set as Somnath suggested in his 'RocksDB tuning' .=
 No
>>> much difference comparing to default settings though...
>>>
>>> As a result when doing 4k sequential write (8Gb total) to a fresh stora=
ge I'm
>>> observing (using nmon and other disk mon tools) significant write traff=
ic to
>>> WAL device. And it grows eventually from ~10Mbs to ~170Mbs. Raw Block d=
evice
>>> traffic is pretty stable at ~30 Mbs.
>>>
>>> Additionally I inserted an output for BlueFS perf counters on
>>> umount(l_bluefs_bytes_written_wal & l_bluefs_bytes_written_sst).
>>>
>>> The resulting values are very frustrating: ~28Gb and 4Gb for
>>> l_bluefs_bytes_written_wal & l_bluefs_bytes_written_sst respectively.
>>
>> Yeah, this doesn't seem right.  Have you generated a log to see what is
>> actually happening on each write?  I don't have any bright ideas about
>> what is going wrong here.
>>
>> sage
>>
>>> Doing 64K changes the picture dramatically:
>>>
>>> WAL traffic is stable at 10-12 Mbs and RAW Block one is at ~400Mbs
>>> BlueFS counters are ~140Mb and 1K respectively.
>>>
>>> Surely write completes much faster in the second case.
>>>
>>> No WAL is reported in logs at BlueStore level for both cases.
>>>
>>>
>>> High BlueFS WAL traffic is observed when running subsequent random 4K R=
W over
>>> the store propagated this way too.
>>>
>>> I'm wondering why WAL device is involved in the process at all ( writes=
 happen
>>> in min_alloc_size blocks) operate and why the traffic and written data =
volume
>>> is so high?
>>>
>>> Don't we have some fault affecting 4K performance here?
>>>
>>>
>>> Here are my settings and FIO job specification:
>>>
>>> ###########################
>>>
>>> [global]
>>>          debug bluestore =3D 0/0
>>>          debug bluefs =3D 1/0
>>>          debug bdev =3D 0/0
>>>          debug rocksdb =3D 0/0
>>>
>>>          # spread objects over 8 collections
>>>          osd pool default pg num =3D 32
>>>          log to stderr =3D false
>>>
>>> [osd]
>>>          osd objectstore =3D bluestore
>>>          bluestore_block_create =3D true
>>>          bluestore_block_db_create =3D true
>>>          bluestore_block_wal_create =3D true
>>>          bluestore_min_alloc_size =3D 4096
>>>          #bluestore_max_alloc_size =3D #or 4096
>>>          bluestore_fsck_on_mount =3D false
>>>
>>>          bluestore_block_path=3D/dev/sdi1
>>>          bluestore_block_db_path=3D/dev/sde1
>>>          bluestore_block_wal_path=3D/dev/sde2
>>>
>>>          enable experimental unrecoverable data corrupting features =3D=
 bluestore
>>> rocksdb memdb
>>>
>>>          bluestore_rocksdb_options =3D
>>> "max_write_buffer_number=3D16,min_write_buffer_number_to_merge=3D2,recy=
cle_log_file_num=3D16,compaction_threads=3D32,flusher_threads=3D8,max_backg=
round_compactions=3D32,max_background_flushes=3D8,max_bytes_for_level_base=
=3D5368709120,write_buffer_size=3D83886080,level0_file_num_compaction_trigg=
er=3D4,level0_slowdown_writes_trigger=3D400,level0_stop_writes_trigger=3D80=
0"
>>>
>>>          rocksdb_cache_size =3D 4294967296
>>>          bluestore_csum =3D false
>>>          bluestore_csum_type =3D none
>>>          bluestore_bluefs_buffered_io =3D false
>>>          bluestore_max_ops =3D 30000
>>>          bluestore_max_bytes =3D 629145600
>>>          bluestore_buffer_cache_size =3D 104857600
>>>          bluestore_block_wal_size =3D 0
>>>
>>>          # use directory=3D option from fio job file
>>>          osd data =3D ${fio_dir}
>>>
>>>          # log inside fio_dir
>>>          log file =3D ${fio_dir}/log
>>> ####################################
>>>
>>> #FIO jobs
>>> #################
>>> # Runs a 4k random write test against the ceph BlueStore.
>>> [global]
>>> ioengine=3D/usr/local/lib/libfio_ceph_objectstore.so # must be found in=
 your
>>> LD_LIBRARY_PATH
>>>
>>> conf=3Dceph-bluestore-somnath.conf # must point to a valid ceph configu=
ration
>>> file
>>> directory=3D./fio-bluestore # directory for osd_data
>>>
>>> rw=3Dwrite
>>> iodepth=3D16
>>> size=3D256m
>>>
>>> [bluestore]
>>> nr_files=3D63
>>> bs=3D4k        # or 64k
>>> numjobs=3D32
>>> #############
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
