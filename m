From: =?UTF-8?B?5pSA5YiY?= <liupan1111@gmail.com>
Subject: Re: latency compare between 2t NVME SSD P3500 and bluestore
Date: Thu, 13 Jul 2017 00:25:44 +0800
Message-ID: <CAMwhyqUP4uUNoPMBYkvgOcjiRu5C_za=xY6E1qOpxrx1MO2M0g@mail.gmail.com>
References: <CAMwhyqVYiWuAVg_+HJ7xjsNs=BNkH-g5BtHGTDDP4j-5sSGXLw@mail.gmail.com>
 <alpine.DEB.2.11.1707121158300.3424@piezo.novalocal> <CAMwhyqX=ZNTpfK7t3+ajqJZ6D-YrcdkCeVCCy=oX5iDLMxjC-w@mail.gmail.com>
 <alpine.DEB.2.11.1707121351490.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35701 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbdGLQZp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jul 2017 12:25:45 -0400
Received: by mail-ua0-f169.google.com with SMTP id j53so17685792uaa.2
        for <ceph-devel@vger.kernel.org>; Wed, 12 Jul 2017 09:25:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1707121351490.3424@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, p.zhou@alibaba-inc.com, 20702390@qq.com

Hi Sage,

Indeed, I have an idea which hold a long time.

Do we really need a heavy k/v database to store metadata? Especially
for fast disks.... Introduce a third-party database also make
difficulty for maintenance (maybe because of my limited database
knowledge) ...

Let's suppose:
1) The max pg number in one osd is limited(in my experience, 100~200
pgs per osd is best performance)
2) The max number of objects in one pg is limited, because of disk space.

Then, how about this: pre-allocate metadata locations in metadata partition=
=E3=80=82

Part a SSD into two or three partitions(same as bluestore), instead of
using kv database, just store metadata directly in one disk
partition(we call it metadata partition). Inside this metadata
partition, we store several data structures:
1) One hash table of PGs, key is PG id, value is another hash
table(key is object index of this pg, value is object metadata, and
object location in data partition).
2) A free object location list.

And other extra things...

The max pgs belongs to one OSD can be limited by options, so I believe
the metadata partition should not be big. We could load all metadata
into RAM if RAM is really big, or part of them and controlled by LRU,
or just read, modify, and write back to disk when needed.

Do you think this idea reasonable? At least, I believe this kind of
new storage engine will be much faster.

Thanks
Pan

2017-07-12 21:55 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Wed, 12 Jul 2017, =E6=94=80=E5=88=98 wrote:
>> Hi Sage,
>>
>> Yes, I totally understand bluestore did much more things than a raw
>> disk, but the current overhead is a little too big to our usage. I
>> will compare bluestore with XFS(also has metadata tracking,
>> allocation, and so on), and to see if XFS also has such impact.
>>
>> I would like to give a flamegraph later, but from the perfcounter, we
>> could find most of time were spent in "kv_lat".
>
> That's rocksdb.  And yeah, I think it's pretty clear that either rocksdb
> needs some serious work to really keep up with nvme (or optane) or (more
> likely) we need an alternate kv backend that is targetting high speed
> flash.  I suspect the latter makes the most sense, and I believe there ar=
e
> various efforts at Intel looking at alternatives but no winner just yet.
>
> Looking a bit further out, I think a new kv library that natively targets
> peristent memory (e.g., something built on pmem.io) will be the right
> solution.  Although at that point, it's probbaly a question of whether we
> have pmem for metadata and 3D NAND for data or pure pmem; in the latter
> case a complete replacement for bluestore would make more sense.
>
>> For FTL, yes, it is a good idea, after we get the flame graph, we
>> could discuss which part could be improved by FTL, firmware, even open
>> channel.
>
> Yep!
> sage
>
>
>
>
>>
>>
>>
>>
>>
>> 2017-07-12 20:02 GMT+08:00 Sage Weil <sage@newdream.net>:
>> > On Wed, 12 Jul 2017, =E6=94=80=E5=88=98 wrote:
>> >> Hi Cephers,
>> >>
>> >> I did some experiment today to compare the latency between one
>> >> P3500(2T nvme SSD) and bluestore(fio + libfio_objectstore.so):
>> >>
>> >> For iodepth =3D 1, the random write latency of bluestore is 276.91us,
>> >> compare with 14.71 of SSD, big overhead.
>> >>
>> >> I also test iodepth =3D 16, Still, there is a big overhead.(143 us ->=
 642 us)
>> >>
>> >> What is your opinion?
>> >
>> > There is a lot of work that bluestore is doing over the raw device as =
it
>> > is implementing all of the metadata tracking, checksumming, allocation=
,
>> > and so on.  There's definitely lots of room for improvement, but I'm
>> > not sure you can expect to see latencies in the 10s of us.  That said,=
 it
>> > would be interesting to see an updated flamegraph to see where the tim=
e is
>> > being spent and where we can slim this down.  On a new nvme it's possi=
ble
>> > we can do away with some of the complexity of, say, the allocator, sin=
ce
>> > the FTL is performing a lot of the same work anyway.
>> >
>> > sage
>>
>>
