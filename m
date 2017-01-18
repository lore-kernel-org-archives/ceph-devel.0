From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Quota issues of pool
Date: Tue, 17 Jan 2017 22:33:19 -0500
Message-ID: <CA+aFP1CtXLWMu1nkBNCjdEvbka+DDzY0X1-b4FN50=dJ0p=5JA@mail.gmail.com>
References: <2955E729-D7CF-481A-81AC-E1B72616CC30@alibaba-inc.com>
 <2a30710a-2045-48a3-a77f-267240850230.james.liu@alibaba-inc.com> <B12B09C8-32CE-4CB9-8A3A-C94CDAED8B49@alibaba-inc.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35991 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdARD5t (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jan 2017 22:57:49 -0500
Received: by mail-lf0-f46.google.com with SMTP id z134so816291lff.3
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2017 19:57:44 -0800 (PST)
In-Reply-To: <B12B09C8-32CE-4CB9-8A3A-C94CDAED8B49@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "LIU, Fei" <james.liu@alibaba-inc.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>

For what it's worth, there is work in-progress right now to add the
necessary hooks to librbd to support removing an image from a full
cluster [1].

[1] https://github.com/ceph/ceph/pull/12627

On Tue, Jan 17, 2017 at 9:30 PM, LIU, Fei <james.liu@alibaba-inc.com> wrote:
> Hi Sage,
>   Thanks for your promptly response. It is clear to us of the root cause that cause  the delay which in the end make quota enforcement somehow not accurate . However, when we tried to remove the image which is exceeding the quota ,the image can not be removed and remove process hang over there.
>
> sudo rbd unmap /dev/rbd0
> rbd rm quota/100
>
> We got FULL,paused modify error.
>
> Is that normal? Thanks for your advise in advance.
>
> Regards,
> James
>
> 本邮件及其附件含有阿里巴巴集团的商业秘密信息，仅限于发送给上面地址中列出的个人和群组，禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制和散发）本邮件及其附件中的信息，如果您错收本邮件，请您立即电话或邮件通知发件人并删除本邮件。
> This email and its attachments contain confidential information from Alibaba Group.which is intended only for the person or entity whose address is listed above.Any use of information contained herein in any way(including,but not limited to,total or partial disclosure,reproduction or dissemination)by persons other than the intended recipient(s) is prohibited.If you receive this email in error,please notify the sender by phone or email immediately and delete it.
>
> ------------------Original Mail ------------------
> From:Sage Weil <sweil@redhat.com>
> Date:2017-01-18 08:23:28
> Recipient:LIU, Fei <james.liu@alibaba-inc.com>
> CC:ceph-devel <ceph-devel@vger.kernel.org>, Mark Nelson <mnelson@redhat.com>
> Subject:Re: Quota issues of pool
> On Wed, 18 Jan 2017, LIU, Fei wrote:
>> Hi ,
>>
>> We have tested the quota features of pool, We found we can set up the quota of pool less than existing image size. We can also create a image with quota more than the pool size. Sometime ,we even set up a quota for a image, but we found we can write the data more than the quota we setup for a image. For example, we set up a poor with quota 100M and create a image inside of pool with 200M. but we found we can write more than 100M to the image which is way over 100M.
>>
>> ceph osd pool set-quota quota max_bytes 100M
>> rbd create –s 200M quota/100
>> sudo rbd map quota/100
>> sudo dd if= /dev/zero of=/dev/rbd0 bs=16k
>>
>> we in the end wrote 163M into the image.
>>
>> We are wondering the quota function of the pool did not work from our
>> observation. Appreciate for any input?
>
> Unlike a single storage server in which all IO passes through a single
> server, Ceph is distributed and can't easily do perfect
> quota enforcement. It's a feedback loop, but there is always some
> delay:
>
> - osds report pg stats to mon
> - mon sees pool usage exceed quota, sets full flag on pool
> - new osdmap propagates to osds
> - osds block new writes
>
> This is usually not a problem when limits are large, as we generally
> expect them to be. (1 PB vs 1.00001 PB written doesn't really matter.)
> It doesn't work well on very small pools (e.g., 100 MB), but you generally
> don't want such small pools anyway or else you'll need to have millions of
> them in a single cluster, and that isn't supported.
>
> sage
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
