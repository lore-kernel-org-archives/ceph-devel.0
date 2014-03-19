From: Gregory Farnum <greg@inktank.com>
Subject: Re: rbd client map error
Date: Wed, 19 Mar 2014 15:48:29 -0700
Message-ID: <CAPYLRzixKJbsFXsBR_JNjjn3Da=-1YxMnUBOLeq2spuF-tKm-A@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F1B619B1D@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPYLRzg_V6W9Eqzp=D27EfDZW_vcNSTALBYTJx52LgoRjA91mA@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F1B619B34@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:51536 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbaCSWsa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Mar 2014 18:48:30 -0400
Received: by mail-qc0-f180.google.com with SMTP id w7so21655qcr.25
        for <ceph-devel@vger.kernel.org>; Wed, 19 Mar 2014 15:48:29 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F1B619B34@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Sage Weil (sage@inktank.com)" <sage@inktank.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeah, I think there was a bug. What upstream commit did you branch off from?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Wed, Mar 19, 2014 at 3:44 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> I have tried with the following commands in this order and tried to map rbd
> image everytime.
>
>
>
> ceph osd crush tunables bobtail
>
> ceph osd crush tunables argonaut
>
> ceph osd crush tunables legacy
>
>
>
> The cluster status after that..
>
>
>
> ceph -s
>
>
>
>     cluster d67fecd4-dd19-44cd-b69e-5b16a7b303e0
>
>      health HEALTH_WARN 1776 pgs degraded; 1776 pgs stuck unclean; recovery
> 6553604/9830406 objects degraded (66.667%); crush map has non-optimal
> tunables
>
>      monmap e1: 1 mons at {a=10.196.123.24:6789/0}, election epoch 1, quorum
> 0 a
>
>      osdmap e27: 1 osds: 1 up, 1 in
>
>       pgmap v2238: 1776 pgs, 6 pools, 200 GB data, 3200 kobjects
>
>             360 GB used, 1129 GB / 1489 GB avail
>
>             6553604/9830406 objects degraded (66.667%)
>
>                 1776 active+degraded
>
>
>
>
>
> Thanks & Regards
>
> Somnath
>
> -----Original Message-----
> From: Gregory Farnum [mailto:greg@inktank.com]
> Sent: Wednesday, March 19, 2014 3:38 PM
> To: Somnath Roy
> Cc: Sage Weil (sage@inktank.com); Samuel Just (sam.just@inktank.com)
> Subject: Re: rbd client map error
>
>
>
> Looking at http://tracker.ceph.com/issues/7208#change-33340, either you need
> to set older CRUSH tunables (what settings have you tried?), or maybe
> there's a bug at the point you branched from. It's not entirely clear to me
> from that update; Sage?
>
> -Greg
>
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
>
>
>
>
> On Wed, Mar 19, 2014 at 3:30 PM, Somnath Roy <Somnath.Roy@sandisk.com>
> wrote:
>
>> Hi Greg/Sage/Sam,
>
>>
>
>> I am getting the following error in the sys log while I was trying to
>
>> map the rbd image to the ceph cluster running our optimized code base
>
>> rebased with latest ceph main. I am using kernel rbd client.
>
>>
>
>>
>
>>
>
>> Mar 19 14:54:18 emsserver1 kernel: [3766212.323266] libceph: mon0
>
>> 10.196.123.24:6789 feature set mismatch, my 4a042a42 < server's
>
>> 104a042a42, missing 1000000000
>
>>
>
>> Mar 19 14:54:18 emsserver1 kernel: [3766212.323280] libceph: mon0
>
>> 10.196.123.24:6789 socket error on read
>
>>
>
>>
>
>>
>
>> Here is the kernel version...
>
>>
>
>>
>
>>
>
>> root@emsserver1:/home/ceph-wip-queueing-somnath-back/src# uname -a
>
>>
>
>> Linux emsserver1 3.11.0-tcp0copy1 #2 SMP Mon Feb 3 07:29:07 PST 2014
>
>> x86_64
>
>> x86_64 x86_64 GNU/Linux
>
>>
>
>>
>
>>
>
>>
>
>>
>
>> I saw there are some CRUSH tunable stuff you mentioned but trying
>
>> those also I was getting the error. So,  given the client version I am
>
>> using which crush tunable value should I use ?
>
>>
>
>>
>
>>
>
>> ceph osd crush tunables
>
>>
>
>>
>
>> ________________________________
>
>>
>
>> PLEASE NOTE: The information contained in this electronic mail message
>
>> is intended only for the use of the designated recipient(s) named
>
>> above. If the reader of this message is not the intended recipient,
>
>> you are hereby notified that you have received this message in error
>
>> and that any review, dissemination, distribution, or copying of this
>
>> message is strictly prohibited. If you have received this
>
>> communication in error, please notify the sender by telephone or
>
>> e-mail (as shown above) immediately and destroy any and all copies of
>
>> this message in your possession (whether hard copies or electronically
>> stored copies).
>
>>
>
>>
>
>
>
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is
> intended only for the use of the designated recipient(s) named above. If the
> reader of this message is not the intended recipient, you are hereby
> notified that you have received this message in error and that any review,
> dissemination, distribution, or copying of this message is strictly
> prohibited. If you have received this communication in error, please notify
> the sender by telephone or e-mail (as shown above) immediately and destroy
> any and all copies of this message in your possession (whether hard copies
> or electronically stored copies).
>
>
