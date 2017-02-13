From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: rbd performance drop a lot with objectmap
Date: Mon, 13 Feb 2017 18:47:01 -0500
Message-ID: <CA+aFP1Dqjx7ipGZWTuqy=+y=U_bV7xZAQWRanf7Y7ktVTFo04g@mail.gmail.com>
References: <B30C48EF-D72E-471C-808F-02E666347EAB@alibaba-inc.com>
 <CA+aFP1DpPYm1t2+wzgEOzciYAmkemTkuzabsArZCZF6OXzhO2g@mail.gmail.com>
 <A4A0B62C-3155-4625-8954-3CCB482F95D2@alibaba-inc.com> <5E3E05AED7F0F044904275810D0CB46505E715@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <D1FAA42E-CA98-4DFA-81CE-7608652FCBA4@alibaba-inc.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:32915 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdBMXrE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 18:47:04 -0500
Received: by mail-lf0-f48.google.com with SMTP id x1so58597523lff.0
        for <ceph-devel@vger.kernel.org>; Mon, 13 Feb 2017 15:47:03 -0800 (PST)
In-Reply-To: <D1FAA42E-CA98-4DFA-81CE-7608652FCBA4@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

You have an application that is directly interfacing with librbd to write
to an image? Or do you have the same image mapped under multiple VMs? In
either case, you should just disable the exclusive lock when creating the
image (via the --image-shared CLI option) since, as the name "exclusive"
implies, the image shouldn't be used concurrently by multiple clients at
the same time.

On Mon, Feb 13, 2017 at 6:27 PM, LIU, Fei <james.liu@alibaba-inc.com> wrote:
> Hi Somnath,
>    Thanks,  Very good point. However, one of cloud applications  in our data center will have multiple threads(Java code) to flush their data to one image at same time. There are two lock involved in the process , one is image exclusive_lock , another one is object_map lock.    I am afraid there is a lot performance hurt by these two locks with multiple threads application.
>
>   Regards,
>   James
>
>
> 本邮件及其附件含有阿里巴巴集团的商业秘密信息，仅限于发送给上面地址中列出的个人和群组，禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制和散发）本邮件及其附件中的信息，如果您错收本邮件，请您立即电话或邮件通知发件人并删除本邮件。
> This email and its attachments contain confidential information from Alibaba Group.which is intended only for the person or entity whose address is listed above.Any use of information contained herein in any way(including,but not limited to,total or partial disclosure,reproduction or dissemination)by persons other than the intended recipient(s) is prohibited.If you receive this email in error,please notify the sender by phone or email immediately and delete it.
>
> On 2/13/17, 3:00 PM, "Somnath Roy" <Somnath.Roy@sandisk.com> wrote:
>
>     James,
>     It was discussed earlier in the ceph-devel that with exclusive lock enabled , multi thread (job) performance will be hurting. You should increase QD to increase parallelism but not the threads.
>     I brought that up sometimes back but couldn't provide an use case where multiple client will be accessing an image in parallel , it will be great if you have one. Exporting rbd for the data base use case could be the one (?).
>
>     Thanks & Regards
>     Somnath
>
>     -----Original Message-----
>     From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of LIU, Fei
>     Sent: Monday, February 13, 2017 2:37 PM
>     To: dillaman@redhat.com
>     Cc: Ceph Development
>     Subject: Re: rbd performance drop a lot with objectmap
>
>     Hi Jason,
>        It makes sense .By the way, we do a random write with qd=1 initially .The performance drops almost 3 times.
>       We also tested 10  times fio write test in one image using below fio configuration with each fio write taking 30 seconds.
>     [global]
>     ioengine=rbd
>     clientname=admin
>     pool=test-pool
>     rbdname= image-with-objmap
>     rw=write
>     bs=16k
>     direct=1
>     runtime=1200
>     ramp_time=30
>     group_reporting
>     time_based
>     [with_objectmap_rbd_iodepth1_numjobs1]
>     iodepth=128
>     numjobs=1
>
>       IOPS increases from 180 to 1200 in the end after 10 times fio rbd write. Once objectmap is warming up , it lowers the latency a lot  and increase IOPS accordingly.
>
>     However, we also tested the rand write with rbd-bench ,we found the performance almost drop 10 times with more contention involved:
>
>     1.  rbd create test-pool/no-map-image --size 100G --object-size 16K --image-format 2 --image-feature layering
>     2.  rbd create test-pool/with-map-image --size 100G --object-size 16K --image-format 2 --image-feature layering --image-feature exclusive-lock --image-feature object-map
>
>             Using rbd bench to write 1G data randomly：
>              rbd bench-write -p test-pool --image no-map-image --io-size 16K --io-threads 16 --io-total 1G --io-pattern rand
>
>      We found the performance drop almost 10 times in terms of IOPS. It shows the performance is getting worse with more jobs. It make us wondering whether the lock is killing factor. Any thoughts?
>
>
>        Regards,
>        James
>
>     本邮件及其附件含有阿里巴巴集团的商业秘密信息，仅限于发送给上面地址中列出的个人和群组，禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制和散发）本邮件及其附件中的信息，如果您错收本邮件，请您立即电话或邮件通知发件人并删除本邮件。
>     This email and its attachments contain confidential information from Alibaba Group.which is intended only for the person or entity whose address is listed above.Any use of information contained herein in any way(including,but not limited to,total or partial disclosure,reproduction or dissemination)by persons other than the intended recipient(s) is prohibited.If you receive this email in error,please notify the sender by phone or email immediately and delete it.
>
>     On 2/12/17, 9:59 AM, "Jason Dillaman" <jdillama@redhat.com> wrote:
>
>         On Fri, Feb 10, 2017 at 9:50 AM, LIU, Fei <james.liu@alibaba-inc.com> wrote:
>         > With FIO single job queue depth 1(W/ vs W/O)  , IOPS drop 3 times and
>         > latency increased 3 times. As with more jobs, the IOPS drops more and
>         > latency increase higher and higher.
>
>         Assuming you have a random write workload, within a QD=1, it is
>         entirely expected for the first write to the object to incur a
>         performance penalty since it requires an additional round-trip
>         operation to the backing OSDs. Since you only hit this penalty for the
>         very first write to the object, its cost is amortized over future
>         writes. This is similar to cloned images and the amortized cost of
>         copying up the backing parent object to the clone on the first write.
>
>         > The objectmap_locker in pre and post and objectmap update per IO really hurt
>         > performance. Lockless queue and new way to caching objectmap? Any thoughts?
>
>         By definition, with a QD=1, there is zero contention on that lock. The
>         lock is really only held for a minuscule amount of time and is dropped
>         while the OSD operation is in-progress. Do you actually have any
>         performance metrics to back up this claim? Note that the post state is
>         only hit when you issue a remove / trim / discard operation.
>
>         --
>         Jason
>
>
>
>     --
>     To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>     Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:
>
>     This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
>
>
>



-- 
Jason
