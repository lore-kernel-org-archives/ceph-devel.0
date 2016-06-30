From: myoungwon oh <ohmyoungwon@gmail.com>
Subject: Re: Questions for NVRAM+SATA SSDs with Bluestore
Date: Thu, 30 Jun 2016 17:39:43 +0900
Message-ID: <CAFNt83aFFy62vBGsd5-C1pyh09-Thwnz-pX7NNn9_45hs2qSVA@mail.gmail.com>
References: <CAFNt83a4mnNhO722drHTB_FavwzFfHJpRfCbUg8En2WpRHZWdw@mail.gmail.com>
 <alpine.DEB.2.11.1606271229510.2844@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33947 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbcF3Ik6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2016 04:40:58 -0400
Received: by mail-vk0-f43.google.com with SMTP id c2so100371758vkg.1
        for <ceph-devel@vger.kernel.org>; Thu, 30 Jun 2016 01:39:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606271229510.2844@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi.


As you mentioned, bluesotre_min_alloc_size can send data to the wal pat=
h.

Performance is improved than wrtting directly SSDs. (more than 10KIOPS)

However, performance of bluestore is lower than filestore (see below).

I thinks that there are many performance options for bluestore.

Therefore, i need to understand it in order to see real performance.

(If you have recommended options, please let me know)



Anyway, other observations are that

1. More than 70KIOPS is observed at first 20~30 second during
performance test. after 20~30 second, performance is drop
significantly.

    (one expected reason is that meta data size (blob map, extent map)
is increasing)

2. high latency (note that this is nvram)



Thanks.



Bluestore (master branch, 6/29, No configurations are changed)

################################### BW result IO_Size  randwrite

4KB      234.42

################################### IOPS result IO_Size  randwrite

4KB      60006

################################### Latency result IO_Size  randwrite (=
ms)

4KB      9.595

################################### CPU utilization IO_Size  randwrite

4KB      52.53



=46ilestore (jewel, 10.2.1, No configurations are changed)


################################### BW result IO_Size  randwrite

4KB      260.33

################################### IOPS result IO_Size  randwrite

4KB      66640

################################### Latency result IO_Size  randwrite (=
ms)

4KB      8.642

################################### CPU utilization IO_Size  randwrite

4KB      56.42


2016-06-27 21:31 GMT+09:00 Sage Weil <sage@newdream.net>:
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
