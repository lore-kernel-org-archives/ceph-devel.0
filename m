From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: severe librbd performance degradation in Giant
Date: Wed, 17 Sep 2014 16:34:29 -0500
Message-ID: <5419FE65.2070509@redhat.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F27845984@SACMBXIP02.sdcorp.global.sandisk.com> <5419FB1B.4020202@inktank.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F278459F8@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:51352 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552AbaIQVeZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 17:34:25 -0400
Received: by mail-ie0-f180.google.com with SMTP id rd18so2585508iec.25
        for <ceph-devel@vger.kernel.org>; Wed, 17 Sep 2014 14:34:24 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F278459F8@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Josh Durgin <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Any chance read ahead could be causing issues?

On 09/17/2014 04:29 PM, Somnath Roy wrote:
> I set the following in the client side /etc/ceph/ceph.conf where I am running fio rbd.
>
> rbd_cache_writethrough_until_flush = false
>
> But, no difference. BTW, I am doing Random read, not write. Still this setting applies ?
>
> Next, I tried to tweak the rbd_cache setting to false and I *got back* the old performance. Now, it is similar to firefly throughput !
>
> So, loks like rbd_cache=true was the culprit.
>
> Thanks Josh !
>
> Regards
> Somnath
>
> -----Original Message-----
> From: Josh Durgin [mailto:josh.durgin@inktank.com]
> Sent: Wednesday, September 17, 2014 2:20 PM
> To: Somnath Roy; ceph-devel@vger.kernel.org
> Subject: Re: severe librbd performance degradation in Giant
>
> On 09/17/2014 01:55 PM, Somnath Roy wrote:
>> Hi Sage,
>> We are experiencing severe librbd performance degradation in Giant over firefly release. Here is the experiment we did to isolate it as a librbd problem.
>>
>> 1. Single OSD is running latest Giant and client is running fio rbd on top of firefly based librbd/librados. For one client it is giving ~11-12K  iops (4K RR).
>> 2. Single OSD is running Giant and client is running fio rbd on top of Giant based librbd/librados. For one client it is giving ~1.9K  iops (4K RR).
>> 3. Single OSD is running latest Giant and client is running Giant based ceph_smaiobench on top of giant librados. For one client it is giving ~11-12K  iops (4K RR).
>> 4. Giant RGW on top of Giant OSD is also scaling.
>>
>>
>> So, it is obvious from the above that recent librbd has issues. I will raise a tracker to track this.
>
> For giant the default cache settings changed to:
>
> rbd cache = true
> rbd cache writethrough until flush = true
>
> If fio isn't sending flushes as the test is running, the cache will stay in writethrough mode. Does the difference remain if you set rbd cache writethrough until flush = false ?
>
> Josh
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

