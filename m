From: Ning Yao <zay11022@gmail.com>
Subject: Re: Questions for NVRAM+SATA SSDs with Bluestore
Date: Sun, 3 Jul 2016 04:18:54 +0800
Message-ID: <CALZt5jyD_pbs4ZTiSvcDS1i1ubvvu=mkF4iQ5F+1fXRtJb7RPA@mail.gmail.com>
References: <CAFNt83a4mnNhO722drHTB_FavwzFfHJpRfCbUg8En2WpRHZWdw@mail.gmail.com>
 <alpine.DEB.2.11.1606271229510.2844@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35080 "EHLO
	mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbcGBUZW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Jul 2016 16:25:22 -0400
Received: by mail-qt0-f170.google.com with SMTP id f89so72710294qtd.2
        for <ceph-devel@vger.kernel.org>; Sat, 02 Jul 2016 13:25:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606271229510.2844@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: myoungwon oh <ohmyoungwon@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi, Sage
I have tried with bluestore_min_alloc_size =3D 4096 so that the updated
writes can always reallocate inito new extents. It avoids double write
theoretically, but with high speed device like nvme=EF=BC=8Cit still ha=
s
performance issue with metadata updating and the bottleneck is
apparently in rocksdb. I think the compaction and data organization in
rocksdb may affect a lots.  It may have lots of works to do with
rocksdb and bluefs such as using different compaction strategies and
use less number of levels in rocksdb?=E3=80=80So any guides about those=
 and
what  is the future directions on current bluestore performance issue?
Regards
Ning Yao


2016-06-27 20:31 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Mon, 27 Jun 2016, myoungwon oh wrote:
>> Hi, I have questions for bluestore (4K random write case).
>>
>> So far, we have used NVRAM(PCIe) as journal and SSD (SATA) as data
>> disk (filestore).
>> Therefore, we got performance gain from NVRAM journal.
>> However, current Bluestore design seems that data (4K aligned) is
>> written to data disk first, then metadata is written to WAL rocksdb.
>> This design can remove =E2=80=9Cdouble write=E2=80=9D in objectstore=
, but in our case,
>> NVRAM can not be utilized fully.
>>
>>  So, my questions are that
>>
>> 1. Can bluestore write WAL first as filestore?
>
> You can do it indirectly with bluestore_min_alloc_size=3D65536, which=
 will
> send anything smaller than this value through the wal path.  Please l=
et
> us know what effect this has on our latency/performance!
>
>> 2. If not, using bcache or flashcache for NVRAM on top of SSDs is ri=
ght
>> answer?
>
> This is also possible, but I expect we'd like to make this work out o=
f the
> box if we can!
>
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
