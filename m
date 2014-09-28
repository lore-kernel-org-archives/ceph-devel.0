From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: Latency Improvement Report for ShardedOpWQ
Date: Sun, 28 Sep 2014 15:19:29 +0800
Message-ID: <CAMm-wc+4uto+VShkX8+Rbm+v49RUD4PO1RzKm0THhpyAGkKwYQ@mail.gmail.com>
References: <CAMm-wcKSiQHJW5y_mg5S3t17sY902TnG2G=b5Xen6W9Raa-1aQ@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2784C85E@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:43788 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaI1HTa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 28 Sep 2014 03:19:30 -0400
Received: by mail-we0-f179.google.com with SMTP id u56so3587408wes.10
        for <ceph-devel@vger.kernel.org>; Sun, 28 Sep 2014 00:19:29 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2784C85E@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Somnath,

I totally agree with you.

I read the code about  sharded TP and the new OSD OpWQ. In the new
implementation, there is not  single lock for all PGs, but each lock
for a subset of PGs(Am I right?).   It is very useful to reduce lock
contention and so increase parallelism. It is an awesome work!

While I am working on the latency of single IO (mainly 4K random
write), I notice the OpWQ spent about 100+us to transfer an IO from
msg dispatcher to OpWQ worker thread, Do you have any idea to reduce
the time span?

Thanks for your help.
Dong.

On 28 September 2014 13:46, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Hi Dong,
> I don't think in case of single client scenario there is much benefit. Single client has a limitation. The benefit with sharded TP is, a single OSD is scaling much more with the increase of clients since it is increasing parallelism (by reducing lock contention) in the filestore level. A quick check could be like this.
>
> 1. Create a single node, single OSD cluster and try putting load with increasing number of clients like 1,3, 5, 8,10. Small workload serving from memory should be ideal.
> 2. Compare the code with sharded TP against say firefly. You should be seeing firefly is not scaling with increasing number of clients.
> 3. try top -H on two different case and you should be seeing more threads in case of sharded tp were working in parallel than firefly.
>
> Also, I am sure this latency result will not hold true in high workload , there you should be seeing more contention and as a result more latency.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Dong Yuan
> Sent: Saturday, September 27, 2014 8:45 PM
> To: ceph-devel
> Subject: Latency Improvement Report for ShardedOpWQ
>
> ===== Test Purpose =====
>
> Measure whether and how much Sharded OpWQ is better than Traditional OpWQ for random write scene.
>
> ===== Test Case =====
>
> 4K Object WriteFull for 1w times.
>
> ===== Test Method =====
>
> Put the following static probes into codes when running tests to get the time span between enqeueue and dequeue of OpWQ.
>
> Start: PG::enqueue_op before osd->op_wq.equeue call
> End: OSD::dequeue_op.entry
>
> ===== Test Result =====
>
> Traditional OpWQ: 109us(AVG), 40us(MIN)
> ShardedOpWQ: 97us(AVG), 32us(MIN)
>
> ===== Test Conclusion =====
>
> No Remarkably Improvement for Latency
>
>
> --
> Dong Yuan
> Email:yuandong1222@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>



-- 
Dong Yuan
Email:yuandong1222@gmail.com
