From: myoungwon oh <ohmyoungwon@gmail.com>
Subject: Re: Questions for NVRAM+SATA SSDs with Bluestore
Date: Fri, 1 Jul 2016 13:57:31 +0900
Message-ID: <CAFNt83avwEZL8BVowfyW2v5HxzjSqTebEoK4bOi-bifcuwjnAg@mail.gmail.com>
References: <CAFNt83a4mnNhO722drHTB_FavwzFfHJpRfCbUg8En2WpRHZWdw@mail.gmail.com>
 <alpine.DEB.2.11.1606271229510.2844@piezo.us.to> <CAFNt83aFFy62vBGsd5-C1pyh09-Thwnz-pX7NNn9_45hs2qSVA@mail.gmail.com>
 <BL2PR02MB21158006A401C93BB672F4F6F4240@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33095 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbcGAE63 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jul 2016 00:58:29 -0400
Received: by mail-vk0-f43.google.com with SMTP id k68so52414299vkb.0
        for <ceph-devel@vger.kernel.org>; Thu, 30 Jun 2016 21:57:32 -0700 (PDT)
In-Reply-To: <BL2PR02MB21158006A401C93BB672F4F6F4240@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Please see below link
(http://www.slideshare.net/Inktank_Ceph/af-ceph-ceph-performance-analys=
is-and-improvement-on-flash/7)

The number of OSD node is 4. We used PMC 8GB NVRAM product as journalin=
g disk.
Each OSD node used one NVRAM and the number of OSD daemons per node
was 4 so each OSD daemon used 2GB for the journal usage.
We used FIO tool (3 minutes running with 12 jobs, 12 queue depth) on
each client for performance evaluation and
set replication factor as 2.

Thanks.

2016-07-01 1:15 GMT+09:00 Somnath Roy <Somnath.Roy@sandisk.com>:
> Could you please explain in detail about your test configuration  (li=
ke how many osds/ replication/ NVRAM used on where ) ? Also, how long y=
ou ran the test ?
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of myoungwon oh
> Sent: Thursday, June 30, 2016 1:40 AM
> To: Sage Weil
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Questions for NVRAM+SATA SSDs with Bluestore
>
> Hi.
>
>
> As you mentioned, bluesotre_min_alloc_size can send data to the wal p=
ath.
>
> Performance is improved than wrtting directly SSDs. (more than 10KIOP=
S)
>
> However, performance of bluestore is lower than filestore (see below)=
=2E
>
> I thinks that there are many performance options for bluestore.
>
> Therefore, i need to understand it in order to see real performance.
>
> (If you have recommended options, please let me know)
>
>
>
> Anyway, other observations are that
>
> 1. More than 70KIOPS is observed at first 20~30 second during perform=
ance test. after 20~30 second, performance is drop significantly.
>
>     (one expected reason is that meta data size (blob map, extent map=
) is increasing)
>
> 2. high latency (note that this is nvram)
>
>
>
> Thanks.
>
>
>
> Bluestore (master branch, 6/29, No configurations are changed)
>
> ################################### BW result IO_Size  randwrite
>
> 4KB      234.42
>
> ################################### IOPS result IO_Size  randwrite
>
> 4KB      60006
>
> ################################### Latency result IO_Size  randwrite=
 (ms)
>
> 4KB      9.595
>
> ################################### CPU utilization IO_Size  randwrit=
e
>
> 4KB      52.53
>
>
>
> Filestore (jewel, 10.2.1, No configurations are changed)
>
>
> ################################### BW result IO_Size  randwrite
>
> 4KB      260.33
>
> ################################### IOPS result IO_Size  randwrite
>
> 4KB      66640
>
> ################################### Latency result IO_Size  randwrite=
 (ms)
>
> 4KB      8.642
>
> ################################### CPU utilization IO_Size  randwrit=
e
>
> 4KB      56.42
>
>
> 2016-06-27 21:31 GMT+09:00 Sage Weil <sage@newdream.net>:
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
e, but in our
>>> case, NVRAM can not be utilized fully.
>>>
>>>  So, my questions are that
>>>
>>> 1. Can bluestore write WAL first as filestore?
>>
>> You can do it indirectly with bluestore_min_alloc_size=3D65536, whic=
h
>> will send anything smaller than this value through the wal path.
>> Please let us know what effect this has on our latency/performance!
>>
>>> 2. If not, using bcache or flashcache for NVRAM on top of SSDs is
>>> right answer?
>>
>> This is also possible, but I expect we'd like to make this work out =
of
>> the box if we can!
>>
>> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at  http://vger.kernel.org/majordomo-info.html
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
