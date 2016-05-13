From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: ceph osd on shared storage
Date: Fri, 13 May 2016 11:34:28 -0700
Message-ID: <CAJ4mKGbcyzAra8T9+YFxFwjJM94WZUCsj_5bC2A4YSXi1xfJ2g@mail.gmail.com>
References: <CY1PR02MB21239C991F3F277CC542DA47F4740@CY1PR02MB2123.namprd02.prod.outlook.com>
	<47dc190c.9Ro.9Gf.dg.1onb2kibe1@mailjet.com>
	<BL2PR02MB2115CF808611949471806B80F4740@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:32779 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbcEMSe3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2016 14:34:29 -0400
Received: by mail-vk0-f42.google.com with SMTP id o133so147802279vka.0
        for <ceph-devel@vger.kernel.org>; Fri, 13 May 2016 11:34:29 -0700 (PDT)
In-Reply-To: <BL2PR02MB2115CF808611949471806B80F4740@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "nick@fisk.me.uk" <nick@fisk.me.uk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, May 13, 2016 at 7:23 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Yeah probably..
> The whole reason I am forced to think this way because people (not familiar with ceph) are asking if you have fully shared storage why a node failure will trigger recovery since storage is fine, which I believe is make sense.. :-)

This does make some sense, but Ceph is really designed for
shared-nothing hardware. So anybody selling a shared-disk system with
Ceph probably wants to implement this stuff, but none of the upstream
management is designed to be friendly for it (except for the
portability of OSDs!).

I imagine you'd designate CRUSH maps in terms of backing drives
instead of OSD hosts, so that moving the drives doesn't change the
mappings at all. And then do as suggested with the process management.
-Greg

>
> -----Original Message-----
> From: Nick Fisk [mailto:nick@fisk.me.uk]
> Sent: Friday, May 13, 2016 1:43 AM
> To: Somnath Roy; ceph-devel@vger.kernel.org
> Subject: RE: ceph osd on shared storage
>
>
>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Somnath Roy
>> Sent: 13 May 2016 03:36
>> To: ceph-devel@vger.kernel.org
>> Subject: ceph osd on shared storage
>>
>> Hi,
>> I have a storage array that is shared between say 4 hosts. Each host
>> can see all the drives and that's why trying to mount OSDs configured to the drives.
>> End result is not good.
>> I want a specific OSD to come up on a specific host even if a host is
>> seeing all the drives on a chassis. Is there any way in the ceph
>> deployment script so that I can address this ?
>> This will be very helpful in case of shared storage model in the following way.
>>
>> 1. Today if we do a zone (HW or SW) and attach some set of OSDs to a
>> particular host , that host down OSDs will be inaccessible and
>> recovery will kick off even if storage is just fine.
>>
>> 2. But, in the shared model we can have an external agent that can
>> detect host failure and can make the same OSD pop up on the other available host.
>>
>> 3. Once the faulty host is replaced, same OSD can go back to old host.
>>
>> 4. This will save a lot of time cluster will be spending on recovery otherwise.
>>
>> I know there are some dev effort required , but, is this sound sane
>> and worth an effort ?
>> Any feedback is much appreciated.
>
> To me it sounds like you would stop using udev to auto mount the disks and rely on something like pacemaker to mount the FS and start the OSD's. Without pacemaker controlling the fencing, there are probably too many things that can go wrong.
>
>>
>> Thanks & Regards
>> Somnath
>> PLEASE NOTE: The information contained in this electronic mail message
>> is intended only for the use of the designated recipient(s) named
>> above. If the reader of this message is not the intended recipient,
>> you are hereby notified that you have received this message in error
>> and that any review, dissemination, distribution, or copying of this
>> message is strictly prohibited. If you have received this
>> communication in error, please notify the sender by telephone or
>> e-mail (as shown above) immediately and destroy any and all copies of
>> this message in your possession (whether hard copies or electronically stored copies).
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at http://vger.kernel.org/majordomo-info.html
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
