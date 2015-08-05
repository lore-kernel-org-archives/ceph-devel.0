From: Ding Dinghua <dingdinghua85@gmail.com>
Subject: Re: More ondisk_finisher thread?
Date: Wed, 5 Aug 2015 10:52:22 +0800
Message-ID: <CANf+_kLHWKdc+7wq=SvnLeZzibDpMOiHi4d+aW58=DnSHVZJVw@mail.gmail.com>
References: <CANf+_kKpR6prfna20CtRfq=6QF+vpvCJu2NaO73RwuF=X+HMwA@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CDF8A9C@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34859 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbbHECwX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 22:52:23 -0400
Received: by ykcq64 with SMTP id q64so20007784ykc.2
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2015 19:52:22 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDF8A9C@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Please see the comment below:

2015-08-05 0:13 GMT+08:00 Somnath Roy <Somnath.Roy@sandisk.com>:
> Yes, it has to re-acquire pg_lock today..
> But, between journal write and initiating the ondisk ack, there is one context switche in the code path. So, I guess the pg_lock is not the only one that is causing this 1 ms delay...
> Not sure increasing the finisher threads will help in the pg_lock case as it will be more or less serialized by this pg_lock..
My concern is, if pg lock of pg A has been grabbed, not only ondisk
callback of pg A is delayed, since ondisk_finisher has only one
thread,  ondisk callback of other pgs will be delayed too.
> But, increasing finisher threads for the other context switches I was talking about (see queue_completion_thru) may help...
We also count that latency, and It doesn't took much time in our case.

2015-08-05 0:13 GMT+08:00 Somnath Roy <Somnath.Roy@sandisk.com>:
> Yes, it has to re-acquire pg_lock today..
> But, between journal write and initiating the ondisk ack, there is one context switche in the code path. So, I guess the pg_lock is not the only one that is causing this 1 ms delay...
> Not sure increasing the finisher threads will help in the pg_lock case as it will be more or less serialized by this pg_lock..
> But, increasing finisher threads for the other context switches I was talking about (see queue_completion_thru) may help...
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Ding Dinghua
> Sent: Tuesday, August 04, 2015 3:00 AM
> To: ceph-devel@vger.kernel.org
> Subject: More ondisk_finisher thread?
>
> Hi:
>    Now we are doing some ceph performance tuning work, our setup has ten ceph nodes, and SSD as journal, HDD for filestore, and ceph version is 0.80.9.
>    We run fio in virtual maching with random 4KB write workload, we find that It took about 1ms in average for ondisk_finisher, while journal write only took 0.4ms, so I think it's unreasonable.
>     Since ondisk callback will be called with pg lock held, If pg lock has been grabbed by another thread(for example, osd->op_wq), all ondisk callback will be delayed, then all write op will be delayed.
>      I found that op_commit must be called with pg lock, so what about increase the ondisk_finisher thread number, so ondisk callback can be less likely to be delayed.
>
> --
> Ding Dinghua
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>



-- 
Ding Dinghua
