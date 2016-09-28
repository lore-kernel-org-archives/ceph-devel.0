From: Haomai Wang <haomai@xsky.com>
Subject: Re: async messenger random read performance on NVMe
Date: Wed, 28 Sep 2016 22:03:16 +0800
Message-ID: <CACJqLybQQw4+h--zq5Jwtm8VEJWLDYDvwdnbU137+i=sYPOYiw@mail.gmail.com>
References: <9a0e4578-6143-378f-20cf-8e7e8b9cf98b@redhat.com>
 <6AA21C22F0A5DA478922644AD2EC308C659B2E9A@SHSMSX101.ccr.corp.intel.com>
 <BY2PR02MB396990CD6986513D8757A42F4CF0@BY2PR02MB396.namprd02.prod.outlook.com>
 <6AA21C22F0A5DA478922644AD2EC308C659B2ED5@SHSMSX101.ccr.corp.intel.com>
 <6AA21C22F0A5DA478922644AD2EC308C659B2F30@SHSMSX101.ccr.corp.intel.com>
 <CACJqLyaPz4jJRSPeq44PbV5BaH+oBb4zz9XWMwCniDGpQP3q2g@mail.gmail.com> <76bb9bdd-90b7-2991-e195-54f04df18c15@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ty1jpn01on0100.outbound.protection.outlook.com ([104.47.93.100]:26016
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932209AbcI1OD0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 28 Sep 2016 10:03:26 -0400
Received: by mail-vk0-f54.google.com with SMTP id y190so13356409vkd.3
        for <ceph-devel@vger.kernel.org>; Wed, 28 Sep 2016 07:03:22 -0700 (PDT)
In-Reply-To: <76bb9bdd-90b7-2991-e195-54f04df18c15@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: "Ma, Jianpeng" <jianpeng.ma@intel.com>, Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 28, 2016 at 8:47 PM, Mark Nelson <mnelson@redhat.com> wrote:
> On 09/28/2016 04:37 AM, Haomai Wang wrote:
>>
>> On Wed, Sep 28, 2016 at 5:27 PM, Ma, Jianpeng <jianpeng.ma@intel.com>
>> wrote:
>>>
>>> Using jemalloc
>>>                         4K RR                     4K RW
>>>     Async       605077                  134241
>>>     Simple      640892                 134583
>>> Using jemalloc, the trend for 4K like Mark, simple is better than async=
.
>>>
>>> Using tcmalloc(version 4.1.2)
>>>                                 4K RW             4KRR
>>>           Async            144450           612716
>>>           Simple          111187           414672
>>>
>>> Why tcmalloc/jemalloc cause so much performance for simple? But not for
>>> async?
>>
>>
>> This is a old topic.. more thread cache will help for pipe's thread.
>> So it will increase lots of memory. In short, give more memory space
>> get more performance.
>
>
> It is an old topic, but I think it's good to get further confirmation tha=
t
> simple is still faster for small random reads when jemalloc is used (and
> presumably would be as well if tcmalloc was used with a high thread cache
> setting).  I'm chasing some performance issues in the new encode/decode
> work, but after that I can hopefully dig in a little more and try to trac=
k
> it down.

yes, actually it's clear to me why async msgr behavior RR not good as
simple, read op make osd side do more in sending instead of receiving.
And sending tcp message is a more hard work in kernel side, so more
cpu time is consumed in kernel stack. But except these inherit things,
RR will will leads to more messages compared to RW, so more fast
dispatch things. and fast dispatch thing occur 1/2 cpu time in async
thread. So the later optimization will more focus on fast dispatch
logic instead of msgr itself

>
> Mark
>
>
>>
>>>
>>> Jianpeng
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Ma, Jianpeng
>>> Sent: Wednesday, September 28, 2016 1:52 PM
>>> To: Somnath Roy <Somnath.Roy@sandisk.com>; Mark Nelson
>>> <mnelson@redhat.com>; ceph-devel <ceph-devel@vger.kernel.org>
>>> Subject: RE: async messenger random read performance on NVMe
>>>
>>> Use the default config for cmake.  For default, cmake use tcmalloc.
>>>
>>> -----Original Message-----
>>> From: Somnath Roy [mailto:Somnath.Roy@sandisk.com]
>>> Sent: Wednesday, September 28, 2016 1:07 PM
>>> To: Ma, Jianpeng <jianpeng.ma@intel.com>; Mark Nelson
>>> <mnelson@redhat.com>; ceph-devel <ceph-devel@vger.kernel.org>
>>> Subject: RE: async messenger random read performance on NVMe
>>>
>>> Did you increase tcmalloc thread cache to bigger value like 256MB or ar=
e
>>> you using jemalloc ?
>>> If not, this result is very much expected.
>>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Ma, Jianpeng
>>> Sent: Tuesday, September 27, 2016 8:34 PM
>>> To: Mark Nelson; ceph-devel
>>> Subject: RE: async messenger random read performance on NVMe
>>>
>>> Hi Mark:
>>>     Base on 1f5d75f31aa1a7b4,
>>> IOPS4K RW             4KRR
>>> Async            144450           612716
>>>             Simple          111187           414672
>>>
>>> Async use the default value.
>>> My cluster: 4 node, 16 osd(ssd + nvme(store rocksdb/wal). For test use
>>> fio+librbd.
>>>
>>> But the results are opposite.
>>>
>>> Thanks!
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
>>> Sent: Thursday, September 22, 2016 2:50 AM
>>> To: ceph-devel <ceph-devel@vger.kernel.org>
>>> Subject: async messenger random read performance on NVMe
>>>
>>> Recently in master we made async messenger default.  After doing a bunc=
h
>>> of bisection, it turns out that this caused a fairly dramatic decrease =
in
>>> bluestore random read performance.  This is on a cluster with fairly fa=
st
>>> NVMe cards, 16 OSDs across 4 OSD hosts.  There are 8 fio client process=
es
>>> with 32 concurrent threads each.
>>>
>>> Ceph master using bluestore
>>>
>>> Parameters tweaked:
>>>
>>> ms_async_send_inline
>>> ms_async_op_threads
>>> ms_async_max_op_threads
>>>
>>> simple: 168K IOPS
>>>
>>> send_inline: true
>>> async 3/5   threads: 111K IOPS
>>> async 4/8   threads: 125K IOPS
>>> async 8/16  threads: 128K IOPS
>>> async 16/32 threads: 128K IOPS
>>> async 24/48 threads: 128K IOPS
>>> async 25/50 threads: segfault
>>> async 26/52 threads: segfault
>>> async 32/64 threads: segfault
>>>
>>> send_inline: false
>>> async 3/5   threads: 153K IOPS
>>> async 4/8   threads: 153K IOPS
>>> async 8/16  threads: 152K IOPS
>>>
>>> So definitely setting send_inline to false helps pretty dramatically,
>>> though we're still a little slower for small random reads than simple
>>> messenger.  Haomai, regarding the segfaults, I took a quick look with g=
db at
>>> the core file but didn't see anything immediately obvious.  It might be
>>> worth seeing if you can reproduce.
>>>
>>> On the performance front, I'll try to see if I can see anything obvious
>>> in perf.
>>>
>>> Mark
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>>> the body of a message to majordomo@vger.kernel.org More majordomo info =
at
>>> http://vger.kernel.org/majordomo-info.html
>>>    =EC=B9=BB  & ~ &    +-  =DD=B6   w  =CB=9B   m    ^  b  ^n r   z    =
h    &    G   h  ( =E9=9A=8E
>>> =DD=A2j"     m     z =DE=96   f   h   ~ m
>>> PLEASE NOTE: The information contained in this electronic mail message =
is
>>> intended only for the use of the designated recipient(s) named above. I=
f the
>>> reader of this message is not the intended recipient, you are hereby
>>> notified that you have received this message in error and that any revi=
ew,
>>> dissemination, distribution, or copying of this message is strictly
>>> prohibited. If you have received this communication in error, please no=
tify
>>> the sender by telephone or e-mail (as shown above) immediately and dest=
roy
>>> any and all copies of this message in your possession (whether hard cop=
ies
>>> or electronically stored copies).
>>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay  =CA=87=DA=99 ,j =
  f   h   z   w
>>> j:+v   w j m         zZ+     =DD=A2j"  ! i
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
