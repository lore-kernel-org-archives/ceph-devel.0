From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Questions for NVRAM+SATA SSDs with Bluestore
Date: Sat, 2 Jul 2016 22:28:14 -0500
Message-ID: <71d5d4b4-8515-4ec1-def1-7e713bdb0288@redhat.com>
References: <CAFNt83a4mnNhO722drHTB_FavwzFfHJpRfCbUg8En2WpRHZWdw@mail.gmail.com>
 <alpine.DEB.2.11.1606271229510.2844@piezo.us.to>
 <CALZt5jyD_pbs4ZTiSvcDS1i1ubvvu=mkF4iQ5F+1fXRtJb7RPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54394 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480AbcGCD2S (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 2 Jul 2016 23:28:18 -0400
In-Reply-To: <CALZt5jyD_pbs4ZTiSvcDS1i1ubvvu=mkF4iQ5F+1fXRtJb7RPA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>, Sage Weil <sage@newdream.net>
Cc: myoungwon oh <ohmyoungwon@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Ning,

The metadata issues are well known, see the recent threads and PRs=20
regarding reducing the onode size.  I think this issue is two-pronged.=20
We need to do everything we can to reduce the size of the onode (and th=
e=20
recent PRs should help significantly).  Beyond that, rocksdb itself=20
tends to have high write (and read) amp.  We can probably improve thing=
s=20
to a certain extent with tuning, but an alternate option is to use=20
Sandisk's zetascale kvstore.  They are planning on submitting a PR for=20
their kvstore code soonish.  Zetascale itself is already available and=20
is open source:

https://github.com/SanDisk-Open-Source/zetascale

Ramesh has also recently submitted a PR for an in-memory store that we=20
can test against to see how rocksdb and zetascale are doing.  Perhaps=20
some day we could do something similar for nvdimm storage.

Mark

On 07/02/2016 03:18 PM, Ning Yao wrote:
> Hi, Sage
> I have tried with bluestore_min_alloc_size =3D 4096 so that the updat=
ed
> writes can always reallocate inito new extents. It avoids double writ=
e
> theoretically, but with high speed device like nvme=EF=BC=8Cit still =
has
> performance issue with metadata updating and the bottleneck is
> apparently in rocksdb. I think the compaction and data organization i=
n
> rocksdb may affect a lots.  It may have lots of works to do with
> rocksdb and bluefs such as using different compaction strategies and
> use less number of levels in rocksdb?=E3=80=80So any guides about tho=
se and
> what  is the future directions on current bluestore performance issue=
?
> Regards
> Ning Yao
>
>
> 2016-06-27 20:31 GMT+08:00 Sage Weil <sage@newdream.net>:
>> On Mon, 27 Jun 2016, myoungwon oh wrote:
>>> Hi, I have questions for bluestore (4K random write case).
>>>
>>> So far, we have used NVRAM(PCIe) as journal and SSD (SATA) as data
>>> disk (filestore).
>>> Therefore, we got performance gain from NVRAM journal.
>>> However, current Bluestore design seems that data (4K aligned) is
>>> written to data disk first, then metadata is written to WAL rocksdb=
=2E
>>> This design can remove =E2=80=9Cdouble write=E2=80=9D in objectstor=
e, but in our case,
>>> NVRAM can not be utilized fully.
>>>
>>>  So, my questions are that
>>>
>>> 1. Can bluestore write WAL first as filestore?
>>
>> You can do it indirectly with bluestore_min_alloc_size=3D65536, whic=
h will
>> send anything smaller than this value through the wal path.  Please =
let
>> us know what effect this has on our latency/performance!
>>
>>> 2. If not, using bcache or flashcache for NVRAM on top of SSDs is r=
ight
>>> answer?
>>
>> This is also possible, but I expect we'd like to make this work out =
of the
>> box if we can!
>>
>> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
