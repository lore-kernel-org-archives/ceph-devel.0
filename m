From: =?UTF-8?B?5pSA5YiY?= <liupan1111@gmail.com>
Subject: Re: latency compare between 2t NVME SSD P3500 and bluestore
Date: Fri, 14 Jul 2017 20:54:32 +0800
Message-ID: <CAMwhyqU5uWVYaEQ_81x-4w945PKfd8F4fmc-3dcO9rP5qQ7brA@mail.gmail.com>
References: <CAMwhyqVYiWuAVg_+HJ7xjsNs=BNkH-g5BtHGTDDP4j-5sSGXLw@mail.gmail.com>
 <alpine.DEB.2.11.1707121158300.3424@piezo.novalocal> <CAMwhyqX=ZNTpfK7t3+ajqJZ6D-YrcdkCeVCCy=oX5iDLMxjC-w@mail.gmail.com>
 <alpine.DEB.2.11.1707121351490.3424@piezo.novalocal> <CAMwhyqUP4uUNoPMBYkvgOcjiRu5C_za=xY6E1qOpxrx1MO2M0g@mail.gmail.com>
 <CAEYCsVJ0GnFN9RXEkgMyh5jPwkWHr1v=4ZuAWNfiy5GP5i-5Mw@mail.gmail.com>
 <CAERxPZJWFfUJ7zksBgpB7oStA5+GQDDJMDY3Ua8VNLwOWP8MxA@mail.gmail.com>
 <a3e297af-5944-b695-6e58-231eb98f6662@redhat.com> <CAERxPZKHdK78bbMCS7g4y0wQZ4PKSrsK-mn5FC7+VXrO22A3HQ@mail.gmail.com>
 <CAEYCsV+p9ORF8UfxjcUnmPtpgfnHWbniOQnkAp-uzYdMXBM4Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:36817 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754031AbdGNMye (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jul 2017 08:54:34 -0400
Received: by mail-ua0-f182.google.com with SMTP id 35so4280557uax.3
        for <ceph-devel@vger.kernel.org>; Fri, 14 Jul 2017 05:54:34 -0700 (PDT)
In-Reply-To: <CAEYCsV+p9ORF8UfxjcUnmPtpgfnHWbniOQnkAp-uzYdMXBM4Lw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: xiaoyan li <wisher2003@gmail.com>, Mark Nelson <mnelson@redhat.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>, p.zhou@alibaba-inc.com, 20702390@qq.com

Hi Sage and Mark,

I did experiment locally for fio+libfio_ceph_bluestore.fio,
iodepth =3D 32, numjobs=3D64
and got the result below:

1) Without using gdbprof

   PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND
 75526 root      20   0 12.193g 7.056g 271672 R 99.0  5.6   4:20.98
bstore_kv_sync
 75527 root      20   0 12.193g 7.056g 271672 S 61.6  5.6   2:57.03
bstore_kv_final
 75504 root      20   0 12.193g 7.056g 271672 S 35.4  5.6   1:46.34 bstore_=
aio
 75524 root      20   0 12.193g 7.056g 271672 S 34.1  5.6   1:34.27 finishe=
r
 75567 root      20   0 12.193g 7.056g 271672 S 10.6  5.6   0:26.32 fio

We could find the thread of store_kv_sync nearly occupied a core
completely(99%).

  write: IOPS=3D80.1k, BW=3D1251MiB/s (1312MB/s)(319GiB/260926msec)
    clat (usec): min=3D1792, max=3D52694, avg=3D25505.15, stdev=3D1731.77
     lat (usec): min=3D1852, max=3D52780, avg=3D25568.08, stdev=3D1732.09

From fio output, the avg flat is nearly 25.5ms.

From the perfcounter in the link:
http://paste.openstack.org/show/615380/

We could find :
kv_commit_lat: 12.1 ms
kv_lat:               12.1 ms
state_kv_queued_lat :  9.98 X 2 =3D 19.9 ms
state_kv_commiting_lat: 4.67 ms

So we should try to improve state_kv_queued_lat, right?

2) using gdbprof:
http://paste.openstack.org/show/615386/
I pasted the stack of thread KVFinalizeThread and KVSyncThread.

I will continue investigate, please let me know if you have any opinion.

Thanks
Pan

2017-07-14 17:31 GMT+08:00 Xiaoxi Chen <superdebuger@gmail.com>:
> in state_kv_commit stage, db-> submit_transcation will be called and
> all rocksdb insert-key logical is done here, as shown in gdbprof, key
> comparison and lookup is happening here, but as db->submit_transcation
> will set sync=3Dfalse, which will leave the change to RocksDB WAL
> (potential) is only in memory, not persistent to disk
>
> The *submit* you refer to, is just submit an empty transaction with
> sync=3Dtrue, to flush all previous WAL persistently into disk.
>
> Clearly the kv_commit is CPU intensive and kv_submit is (sequential)
> IO intensive. So depending on the CPU/Disk speed ratio, one may see
> different profiling result.  My previous test on HDD show opposite
> result that kv_lat is pretty long.
>
> 2017-07-14 16:29 GMT+08:00 xiaoyan li <wisher2003@gmail.com>:
>> Here is the output of gdbprof: @Mark please have a look.
>> I copied _kv_sync_thread and _kv_finalize_thread here.
>> http://paste.openstack.org/show/615362/
>>
>> Lisa
>>
>> On Fri, Jul 14, 2017 at 9:54 AM, Mark Nelson <mnelson@redhat.com> wrote:
>>> Hi Li,
>>>
>>> You may want to try my wallclock profiler to see where time is being sp=
ent
>>> during your test.  It is located here:
>>>
>>> https://github.com/markhpc/gdbprof
>>>
>>> You can run it like:
>>>
>>> sudo gdb -ex 'set pagination off' -ex 'attach <pid>' -ex 'source
>>> /home/ubuntu/src/markhpc/gdbprof/gdbprof.py' -ex 'profile begin' -ex 'q=
uit'
>>>
>>> Mark
>>>
>>>
>>> On 07/13/2017 08:47 PM, xiaoyan li wrote:
>>>>
>>>> Hi,
>>>> I am concerned about the rocksdb impact on bluestore whole IO path. I
>>>> did some test with bluestore fio plugin.
>>>> For example, I got following data from the log when I did bluestore
>>>> fio test with numjobs=3D64 and iopath=3D32. It seems that for every tx=
c,
>>>> most of the time spends on queued and commiting states.
>>>> state time span(us)
>>>> state_prepare_lat 386
>>>> state_aio_wait_lat 430
>>>> state_io_done_lat 0
>>>> state_kv_queued_lat 7926
>>>> state_kv_commiting_lat 30653
>>>> state_kv_done_lat 4
>>>>
>>>>         "state_kv_queued_lat": {
>>>>             "avgcount": 349076566,
>>>>             "sum": 1214245.959889817,
>>>>             "avgtime": 0.003478451
>>>>         },
>>>>         "state_kv_commiting_lat": {
>>>>             "avgcount": 174538283,
>>>>             "sum": 5612849.022306266,
>>>>             "avgtime": 0.032158268
>>>>         },
>>>>
>>>>
>>>> And same time, to submit (174538283/3509556 =3D 49) txcs every time on=
ly
>>>> takes 1024us, which is much less than commiting_lat 30653us.
>>>>         "kv_lat": {
>>>>             "avgcount": 3509556,
>>>>             "sum": 3594.365142193,
>>>>             "avgtime": 0.001024165
>>>>         },
>>>>
>>>> The time between state_kv_queued_lat and state_kv_commiting_lat:
>>>>
>>>> https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueStore.cc=
#L8349
>>>>
>>>> https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueStore.cc=
#L8366
>>>>
>>>> https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueStore.cc=
#L7741
>>>>
>>>> I am still investigating why it spends so long time on
>>>> kv_commiting_lat, but from above data I doubt it is the problem of
>>>> rocksdb.
>>>> Please correct me if I misunderstood anything.
>>>>
>>>> Lisa
>>>>
>>>>
>>>> On Thu, Jul 13, 2017 at 12:34 AM, Xiaoxi Chen <superdebuger@gmail.com>
>>>> wrote:
>>>>>
>>>>> FWIW, one thing that KVDB can provide is transaction support, which i=
s
>>>>> important as we need to update several metadata(Onode, allocator map,
>>>>> and WAL for small write) transactionally.
>>>>>
>>>>>
>>>>>
>>>>> 2017-07-13 0:25 GMT+08:00 =E6=94=80=E5=88=98 <liupan1111@gmail.com>:
>>>>>>
>>>>>> Hi Sage,
>>>>>>
>>>>>> Indeed, I have an idea which hold a long time.
>>>>>>
>>>>>> Do we really need a heavy k/v database to store metadata? Especially
>>>>>> for fast disks.... Introduce a third-party database also make
>>>>>> difficulty for maintenance (maybe because of my limited database
>>>>>> knowledge) ...
>>>>>>
>>>>>> Let's suppose:
>>>>>> 1) The max pg number in one osd is limited(in my experience, 100~200
>>>>>> pgs per osd is best performance)
>>>>>> 2) The max number of objects in one pg is limited, because of disk
>>>>>> space.
>>>>>>
>>>>>> Then, how about this: pre-allocate metadata locations in metadata
>>>>>> partition=E3=80=82
>>>>>>
>>>>>> Part a SSD into two or three partitions(same as bluestore), instead =
of
>>>>>> using kv database, just store metadata directly in one disk
>>>>>> partition(we call it metadata partition). Inside this metadata
>>>>>> partition, we store several data structures:
>>>>>> 1) One hash table of PGs, key is PG id, value is another hash
>>>>>> table(key is object index of this pg, value is object metadata, and
>>>>>> object location in data partition).
>>>>>> 2) A free object location list.
>>>>>>
>>>>>> And other extra things...
>>>>>>
>>>>>> The max pgs belongs to one OSD can be limited by options, so I belie=
ve
>>>>>> the metadata partition should not be big. We could load all metadata
>>>>>> into RAM if RAM is really big, or part of them and controlled by LRU=
,
>>>>>> or just read, modify, and write back to disk when needed.
>>>>>>
>>>>>> Do you think this idea reasonable? At least, I believe this kind of
>>>>>> new storage engine will be much faster.
>>>>>>
>>>>>> Thanks
>>>>>> Pan
>>>>>>
>>>>>> 2017-07-12 21:55 GMT+08:00 Sage Weil <sage@newdream.net>:
>>>>>>>
>>>>>>> On Wed, 12 Jul 2017, =E6=94=80=E5=88=98 wrote:
>>>>>>>>
>>>>>>>> Hi Sage,
>>>>>>>>
>>>>>>>> Yes, I totally understand bluestore did much more things than a ra=
w
>>>>>>>> disk, but the current overhead is a little too big to our usage. I
>>>>>>>> will compare bluestore with XFS(also has metadata tracking,
>>>>>>>> allocation, and so on), and to see if XFS also has such impact.
>>>>>>>>
>>>>>>>> I would like to give a flamegraph later, but from the perfcounter,=
 we
>>>>>>>> could find most of time were spent in "kv_lat".
>>>>>>>
>>>>>>>
>>>>>>> That's rocksdb.  And yeah, I think it's pretty clear that either
>>>>>>> rocksdb
>>>>>>> needs some serious work to really keep up with nvme (or optane) or
>>>>>>> (more
>>>>>>> likely) we need an alternate kv backend that is targetting high spe=
ed
>>>>>>> flash.  I suspect the latter makes the most sense, and I believe th=
ere
>>>>>>> are
>>>>>>> various efforts at Intel looking at alternatives but no winner just
>>>>>>> yet.
>>>>>>>
>>>>>>> Looking a bit further out, I think a new kv library that natively
>>>>>>> targets
>>>>>>> peristent memory (e.g., something built on pmem.io) will be the rig=
ht
>>>>>>> solution.  Although at that point, it's probbaly a question of whet=
her
>>>>>>> we
>>>>>>> have pmem for metadata and 3D NAND for data or pure pmem; in the la=
tter
>>>>>>> case a complete replacement for bluestore would make more sense.
>>>>>>>
>>>>>>>> For FTL, yes, it is a good idea, after we get the flame graph, we
>>>>>>>> could discuss which part could be improved by FTL, firmware, even =
open
>>>>>>>> channel.
>>>>>>>
>>>>>>>
>>>>>>> Yep!
>>>>>>> sage
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> 2017-07-12 20:02 GMT+08:00 Sage Weil <sage@newdream.net>:
>>>>>>>>>
>>>>>>>>> On Wed, 12 Jul 2017, =E6=94=80=E5=88=98 wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Cephers,
>>>>>>>>>>
>>>>>>>>>> I did some experiment today to compare the latency between one
>>>>>>>>>> P3500(2T nvme SSD) and bluestore(fio + libfio_objectstore.so):
>>>>>>>>>>
>>>>>>>>>> For iodepth =3D 1, the random write latency of bluestore is 276.=
91us,
>>>>>>>>>> compare with 14.71 of SSD, big overhead.
>>>>>>>>>>
>>>>>>>>>> I also test iodepth =3D 16, Still, there is a big overhead.(143 =
us ->
>>>>>>>>>> 642 us)
>>>>>>>>>>
>>>>>>>>>> What is your opinion?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> There is a lot of work that bluestore is doing over the raw devic=
e as
>>>>>>>>> it
>>>>>>>>> is implementing all of the metadata tracking, checksumming,
>>>>>>>>> allocation,
>>>>>>>>> and so on.  There's definitely lots of room for improvement, but =
I'm
>>>>>>>>> not sure you can expect to see latencies in the 10s of us.  That
>>>>>>>>> said, it
>>>>>>>>> would be interesting to see an updated flamegraph to see where th=
e
>>>>>>>>> time is
>>>>>>>>> being spent and where we can slim this down.  On a new nvme it's
>>>>>>>>> possible
>>>>>>>>> we can do away with some of the complexity of, say, the allocator=
,
>>>>>>>>> since
>>>>>>>>> the FTL is performing a lot of the same work anyway.
>>>>>>>>>
>>>>>>>>> sage
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>>
>>>>
>>>
>>
>>
>>
>> --
>> Best wishes
>> Lisa
