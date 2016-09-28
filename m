From: Mark Nelson <mnelson@redhat.com>
Subject: Re: async messenger random read performance on NVMe
Date: Wed, 28 Sep 2016 07:47:43 -0500
Message-ID: <76bb9bdd-90b7-2991-e195-54f04df18c15@redhat.com>
References: <9a0e4578-6143-378f-20cf-8e7e8b9cf98b@redhat.com>
 <6AA21C22F0A5DA478922644AD2EC308C659B2E9A@SHSMSX101.ccr.corp.intel.com>
 <BY2PR02MB396990CD6986513D8757A42F4CF0@BY2PR02MB396.namprd02.prod.outlook.com>
 <6AA21C22F0A5DA478922644AD2EC308C659B2ED5@SHSMSX101.ccr.corp.intel.com>
 <6AA21C22F0A5DA478922644AD2EC308C659B2F30@SHSMSX101.ccr.corp.intel.com>
 <CACJqLyaPz4jJRSPeq44PbV5BaH+oBb4zz9XWMwCniDGpQP3q2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752397AbcI1Mrr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 28 Sep 2016 08:47:47 -0400
In-Reply-To: <CACJqLyaPz4jJRSPeq44PbV5BaH+oBb4zz9XWMwCniDGpQP3q2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>, "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 09/28/2016 04:37 AM, Haomai Wang wrote:
> On Wed, Sep 28, 2016 at 5:27 PM, Ma, Jianpeng <jianpeng.ma@intel.com> wrote:
>> Using jemalloc
>>                         4K RR                     4K RW
>>     Async       605077                  134241
>>     Simple      640892                 134583
>> Using jemalloc, the trend for 4K like Mark, simple is better than async.
>>
>> Using tcmalloc(version 4.1.2)
>>                                 4K RW             4KRR
>>           Async            144450           612716
>>           Simple          111187           414672
>>
>> Why tcmalloc/jemalloc cause so much performance for simple? But not for async?
>
> This is a old topic.. more thread cache will help for pipe's thread.
> So it will increase lots of memory. In short, give more memory space
> get more performance.

It is an old topic, but I think it's good to get further confirmation 
that simple is still faster for small random reads when jemalloc is used 
(and presumably would be as well if tcmalloc was used with a high thread 
cache setting).  I'm chasing some performance issues in the new 
encode/decode work, but after that I can hopefully dig in a little more 
and try to track it down.

Mark

>
>>
>> Jianpeng
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Ma, Jianpeng
>> Sent: Wednesday, September 28, 2016 1:52 PM
>> To: Somnath Roy <Somnath.Roy@sandisk.com>; Mark Nelson <mnelson@redhat.com>; ceph-devel <ceph-devel@vger.kernel.org>
>> Subject: RE: async messenger random read performance on NVMe
>>
>> Use the default config for cmake.  For default, cmake use tcmalloc.
>>
>> -----Original Message-----
>> From: Somnath Roy [mailto:Somnath.Roy@sandisk.com]
>> Sent: Wednesday, September 28, 2016 1:07 PM
>> To: Ma, Jianpeng <jianpeng.ma@intel.com>; Mark Nelson <mnelson@redhat.com>; ceph-devel <ceph-devel@vger.kernel.org>
>> Subject: RE: async messenger random read performance on NVMe
>>
>> Did you increase tcmalloc thread cache to bigger value like 256MB or are you using jemalloc ?
>> If not, this result is very much expected.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Ma, Jianpeng
>> Sent: Tuesday, September 27, 2016 8:34 PM
>> To: Mark Nelson; ceph-devel
>> Subject: RE: async messenger random read performance on NVMe
>>
>> Hi Mark:
>>     Base on 1f5d75f31aa1a7b4,
>> IOPS4K RW             4KRR
>> Async            144450           612716
>>             Simple          111187           414672
>>
>> Async use the default value.
>> My cluster: 4 node, 16 osd(ssd + nvme(store rocksdb/wal). For test use fio+librbd.
>>
>> But the results are opposite.
>>
>> Thanks!
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
>> Sent: Thursday, September 22, 2016 2:50 AM
>> To: ceph-devel <ceph-devel@vger.kernel.org>
>> Subject: async messenger random read performance on NVMe
>>
>> Recently in master we made async messenger default.  After doing a bunch of bisection, it turns out that this caused a fairly dramatic decrease in bluestore random read performance.  This is on a cluster with fairly fast NVMe cards, 16 OSDs across 4 OSD hosts.  There are 8 fio client processes with 32 concurrent threads each.
>>
>> Ceph master using bluestore
>>
>> Parameters tweaked:
>>
>> ms_async_send_inline
>> ms_async_op_threads
>> ms_async_max_op_threads
>>
>> simple: 168K IOPS
>>
>> send_inline: true
>> async 3/5   threads: 111K IOPS
>> async 4/8   threads: 125K IOPS
>> async 8/16  threads: 128K IOPS
>> async 16/32 threads: 128K IOPS
>> async 24/48 threads: 128K IOPS
>> async 25/50 threads: segfault
>> async 26/52 threads: segfault
>> async 32/64 threads: segfault
>>
>> send_inline: false
>> async 3/5   threads: 153K IOPS
>> async 4/8   threads: 153K IOPS
>> async 8/16  threads: 152K IOPS
>>
>> So definitely setting send_inline to false helps pretty dramatically, though we're still a little slower for small random reads than simple messenger.  Haomai, regarding the segfaults, I took a quick look with gdb at the core file but didn't see anything immediately obvious.  It might be worth seeing if you can reproduce.
>>
>> On the performance front, I'll try to see if I can see anything obvious in perf.
>>
>> Mark
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>    칻  & ~ &    +-  ݶ   w  ˛   m    ^  b  ^n r   z    h    &    G   h  ( 階 ݢj"     m     z ޖ   f   h   ~ m
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>> N     r  y   b X  ǧv ^ )޺{.n +   z ]z   {ay  ʇڙ ,j   f   h   z   w       j:+v   w j m         zZ+     ݢj"  ! i
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
