From: Mark Nelson <mnelson@redhat.com>
Subject: Re: async messenger random read performance on NVMe
Date: Wed, 21 Sep 2016 14:10:32 -0500
Message-ID: <61672ba0-fadc-2f25-dcf2-090129bd1c53@redhat.com>
References: <9a0e4578-6143-378f-20cf-8e7e8b9cf98b@redhat.com>
 <CY1PR02MB21236DC2DEDA1C4577FED95BF4F60@CY1PR02MB2123.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935188AbcIUTKk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Sep 2016 15:10:40 -0400
In-Reply-To: <CY1PR02MB21236DC2DEDA1C4577FED95BF4F60@CY1PR02MB2123.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Yes to multiple physical clients (2 fio processes per client using 
librbd with io depth = 32 each).  No to increased OSD shards, this is 
just default.  Can you explain a bit more why Simple should go faster 
with a similar config?  Did you mean async?  I'm going to try to dig in 
with perf and see how they compare.  I wish I had a better way to 
profile lock contention rather than poorman's profiling via gdb.  I 
suppose lttng is the answer.

Mark

On 09/21/2016 02:02 PM, Somnath Roy wrote:
> Mark,
> Are you trying with multiple physical clients and with increased OSD shards?
> Simple should go way more with the similar config for 4K RR based on the result we were getting earlier unless your cpu is getting saturated at the OSD nodes.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Wednesday, September 21, 2016 11:50 AM
> To: ceph-devel
> Subject: async messenger random read performance on NVMe
>
> Recently in master we made async messenger default.  After doing a bunch of bisection, it turns out that this caused a fairly dramatic decrease in bluestore random read performance.  This is on a cluster with fairly fast NVMe cards, 16 OSDs across 4 OSD hosts.  There are 8 fio client processes with 32 concurrent threads each.
>
> Ceph master using bluestore
>
> Parameters tweaked:
>
> ms_async_send_inline
> ms_async_op_threads
> ms_async_max_op_threads
>
> simple: 168K IOPS
>
> send_inline: true
> async 3/5   threads: 111K IOPS
> async 4/8   threads: 125K IOPS
> async 8/16  threads: 128K IOPS
> async 16/32 threads: 128K IOPS
> async 24/48 threads: 128K IOPS
> async 25/50 threads: segfault
> async 26/52 threads: segfault
> async 32/64 threads: segfault
>
> send_inline: false
> async 3/5   threads: 153K IOPS
> async 4/8   threads: 153K IOPS
> async 8/16  threads: 152K IOPS
>
> So definitely setting send_inline to false helps pretty dramatically, though we're still a little slower for small random reads than simple messenger.  Haomai, regarding the segfaults, I took a quick look with gdb at the core file but didn't see anything immediately obvious.  It might be worth seeing if you can reproduce.
>
> On the performance front, I'll try to see if I can see anything obvious in perf.
>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
