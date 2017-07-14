From: xiaoyan li <wisher2003@gmail.com>
Subject: Re: latency compare between 2t NVME SSD P3500 and bluestore
Date: Fri, 14 Jul 2017 16:22:00 +0800
Message-ID: <CAERxPZ+1ifFd9Xaksrb4M1g1xZObEVBwR0tjkOpC-atf4TGT=w@mail.gmail.com>
References: <CAMwhyqVYiWuAVg_+HJ7xjsNs=BNkH-g5BtHGTDDP4j-5sSGXLw@mail.gmail.com>
 <alpine.DEB.2.11.1707121158300.3424@piezo.novalocal> <CAMwhyqX=ZNTpfK7t3+ajqJZ6D-YrcdkCeVCCy=oX5iDLMxjC-w@mail.gmail.com>
 <alpine.DEB.2.11.1707121351490.3424@piezo.novalocal> <CAMwhyqUP4uUNoPMBYkvgOcjiRu5C_za=xY6E1qOpxrx1MO2M0g@mail.gmail.com>
 <CAEYCsVJ0GnFN9RXEkgMyh5jPwkWHr1v=4ZuAWNfiy5GP5i-5Mw@mail.gmail.com>
 <CAERxPZJWFfUJ7zksBgpB7oStA5+GQDDJMDY3Ua8VNLwOWP8MxA@mail.gmail.com> <6AA21C22F0A5DA478922644AD2EC308C6856E737@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37267 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbdGNIWC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jul 2017 04:22:02 -0400
Received: by mail-wm0-f50.google.com with SMTP id i127so15123808wma.0
        for <ceph-devel@vger.kernel.org>; Fri, 14 Jul 2017 01:22:01 -0700 (PDT)
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C6856E737@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: Xiaoxi Chen <superdebuger@gmail.com>, ?? <liupan1111@gmail.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>, "p.zhou@alibaba-inc.com" <p.zhou@alibaba-inc.com>, "20702390@qq.com" <20702390@qq.com>

On Fri, Jul 14, 2017 at 10:49 AM, Ma, Jianpeng <jianpeng.ma@intel.com> wrot=
e:
> "state_kv_commiting_lat -  kv_lat" mean the latency for thread " _kv_fina=
lize_thread".
> If is this correctly?
Not exactly true. state_kv_commiting_lat is per txc, kv_lat is per
_kv_sync_thread call, which handle kv update of txcs in the
kv_queue_unsubmitted.

>
> Jianpeng
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kern=
el.org] On Behalf Of xiaoyan li
> Sent: Friday, July 14, 2017 9:47 AM
> To: Xiaoxi Chen <superdebuger@gmail.com>
> Cc: =E6=94=80=E5=88=98 <liupan1111@gmail.com>; Sage Weil <sage@newdream.n=
et>; Ceph Development <ceph-devel@vger.kernel.org>; p.zhou@alibaba-inc.com;=
 20702390@qq.com
> Subject: Re: latency compare between 2t NVME SSD P3500 and bluestore
>
> Hi,
> I am concerned about the rocksdb impact on bluestore whole IO path. I did=
 some test with bluestore fio plugin.
> For example, I got following data from the log when I did bluestore fio t=
est with numjobs=3D64 and iopath=3D32. It seems that for every txc, most of=
 the time spends on queued and commiting states.
> state time span(us)
> state_prepare_lat 386
> state_aio_wait_lat 430
> state_io_done_lat 0
> state_kv_queued_lat 7926
> state_kv_commiting_lat 30653
> state_kv_done_lat 4
>
>         "state_kv_queued_lat": {
>             "avgcount": 349076566,
>             "sum": 1214245.959889817,
>             "avgtime": 0.003478451
>         },
>         "state_kv_commiting_lat": {
>             "avgcount": 174538283,
>             "sum": 5612849.022306266,
>             "avgtime": 0.032158268
>         },
>
>
> And same time, to submit (174538283/3509556 =3D 49) txcs every time only =
takes 1024us, which is much less than commiting_lat 30653us.
>         "kv_lat": {
>             "avgcount": 3509556,
>             "sum": 3594.365142193,
>             "avgtime": 0.001024165
>         },
>
> The time between state_kv_queued_lat and state_kv_commiting_lat:
> https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueStore.cc#L8=
349
> https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueStore.cc#L8=
366
> https://github.com/ceph/ceph/blob/master/src/os/bluestore/BlueStore.cc#L7=
741
>
> I am still investigating why it spends so long time on kv_commiting_lat, =
but from above data I doubt it is the problem of rocksdb.
> Please correct me if I misunderstood anything.
>
> Lisa
>
>
> On Thu, Jul 13, 2017 at 12:34 AM, Xiaoxi Chen <superdebuger@gmail.com> wr=
ote:
>> FWIW, one thing that KVDB can provide is transaction support, which is
>> important as we need to update several metadata(Onode, allocator map,
>> and WAL for small write) transactionally.
>>
>>
>>
>> 2017-07-13 0:25 GMT+08:00 =E6=94=80=E5=88=98 <liupan1111@gmail.com>:
>>> Hi Sage,
>>>
>>> Indeed, I have an idea which hold a long time.
>>>
>>> Do we really need a heavy k/v database to store metadata? Especially
>>> for fast disks.... Introduce a third-party database also make
>>> difficulty for maintenance (maybe because of my limited database
>>> knowledge) ...
>>>
>>> Let's suppose:
>>> 1) The max pg number in one osd is limited(in my experience, 100~200
>>> pgs per osd is best performance)
>>> 2) The max number of objects in one pg is limited, because of disk spac=
e.
>>>
>>> Then, how about this: pre-allocate metadata locations in metadata
>>> partition=E3=80=82
>>>
>>> Part a SSD into two or three partitions(same as bluestore), instead
>>> of using kv database, just store metadata directly in one disk
>>> partition(we call it metadata partition). Inside this metadata
>>> partition, we store several data structures:
>>> 1) One hash table of PGs, key is PG id, value is another hash
>>> table(key is object index of this pg, value is object metadata, and
>>> object location in data partition).
>>> 2) A free object location list.
>>>
>>> And other extra things...
>>>
>>> The max pgs belongs to one OSD can be limited by options, so I
>>> believe the metadata partition should not be big. We could load all
>>> metadata into RAM if RAM is really big, or part of them and
>>> controlled by LRU, or just read, modify, and write back to disk when ne=
eded.
>>>
>>> Do you think this idea reasonable? At least, I believe this kind of
>>> new storage engine will be much faster.
>>>
>>> Thanks
>>> Pan
>>>
>>> 2017-07-12 21:55 GMT+08:00 Sage Weil <sage@newdream.net>:
>>>> On Wed, 12 Jul 2017, =E6=94=80=E5=88=98 wrote:
>>>>> Hi Sage,
>>>>>
>>>>> Yes, I totally understand bluestore did much more things than a raw
>>>>> disk, but the current overhead is a little too big to our usage. I
>>>>> will compare bluestore with XFS(also has metadata tracking,
>>>>> allocation, and so on), and to see if XFS also has such impact.
>>>>>
>>>>> I would like to give a flamegraph later, but from the perfcounter,
>>>>> we could find most of time were spent in "kv_lat".
>>>>
>>>> That's rocksdb.  And yeah, I think it's pretty clear that either
>>>> rocksdb needs some serious work to really keep up with nvme (or
>>>> optane) or (more
>>>> likely) we need an alternate kv backend that is targetting high
>>>> speed flash.  I suspect the latter makes the most sense, and I
>>>> believe there are various efforts at Intel looking at alternatives but=
 no winner just yet.
>>>>
>>>> Looking a bit further out, I think a new kv library that natively
>>>> targets peristent memory (e.g., something built on pmem.io) will be
>>>> the right solution.  Although at that point, it's probbaly a
>>>> question of whether we have pmem for metadata and 3D NAND for data
>>>> or pure pmem; in the latter case a complete replacement for bluestore =
would make more sense.
>>>>
>>>>> For FTL, yes, it is a good idea, after we get the flame graph, we
>>>>> could discuss which part could be improved by FTL, firmware, even
>>>>> open channel.
>>>>
>>>> Yep!
>>>> sage
>>>>
>>>>
>>>>
>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> 2017-07-12 20:02 GMT+08:00 Sage Weil <sage@newdream.net>:
>>>>> > On Wed, 12 Jul 2017, =E6=94=80=E5=88=98 wrote:
>>>>> >> Hi Cephers,
>>>>> >>
>>>>> >> I did some experiment today to compare the latency between one
>>>>> >> P3500(2T nvme SSD) and bluestore(fio + libfio_objectstore.so):
>>>>> >>
>>>>> >> For iodepth =3D 1, the random write latency of bluestore is
>>>>> >> 276.91us, compare with 14.71 of SSD, big overhead.
>>>>> >>
>>>>> >> I also test iodepth =3D 16, Still, there is a big overhead.(143 us
>>>>> >> -> 642 us)
>>>>> >>
>>>>> >> What is your opinion?
>>>>> >
>>>>> > There is a lot of work that bluestore is doing over the raw
>>>>> > device as it is implementing all of the metadata tracking,
>>>>> > checksumming, allocation, and so on.  There's definitely lots of
>>>>> > room for improvement, but I'm not sure you can expect to see
>>>>> > latencies in the 10s of us.  That said, it would be interesting
>>>>> > to see an updated flamegraph to see where the time is being spent
>>>>> > and where we can slim this down.  On a new nvme it's possible we
>>>>> > can do away with some of the complexity of, say, the allocator, sin=
ce the FTL is performing a lot of the same work anyway.
>>>>> >
>>>>> > sage
>>>>>
>>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Best wishes
> Lisa
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in =
the body of a message to majordomo@vger.kernel.org More majordomo info at  =
http://vger.kernel.org/majordomo-info.html



--=20
Best wishes
Lisa
