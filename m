From: Haomai Wang <haomai@xsky.com>
Subject: Re: [ceph-users] Hammer vs Jewel librbd performance testing and git
 bisection results
Date: Wed, 11 May 2016 22:19:45 +0800
Message-ID: <CACJqLyZdMGdDV+nzTeQLAWYc3QiXLxFMkgVz7GRtNLt-=ghngg@mail.gmail.com>
References: <f9f54455-8348-42b7-153b-e38850eed5e1@redhat.com>
	<CA+aFP1BN=mpR-7xid=+vgz3rpSWkirthrYDPuEy-OkreVp=A-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0128.outbound.protection.outlook.com ([104.47.125.128]:63721
	"EHLO APC01-SG2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932442AbcEKOUL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 May 2016 10:20:11 -0400
Received: by mail-vk0-f47.google.com with SMTP id m188so58760008vka.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2016 07:19:57 -0700 (PDT)
In-Reply-To: <CA+aFP1BN=mpR-7xid=+vgz3rpSWkirthrYDPuEy-OkreVp=A-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "cbt@lists.ceph.com" <cbt@lists.ceph.com>

On Wed, May 11, 2016 at 9:52 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> Awesome work Mark!  Comments / questions inline below:
>
> On Wed, May 11, 2016 at 9:21 AM, Mark Nelson <mnelson@redhat.com> wrote:
>> There are several commits of interest that have a noticeable effect on 128K
>> sequential read performance:
>>
>>
>> 1) https://github.com/ceph/ceph/commit/3a7b5e3
>>
>> This commit was the first that introduced anywhere from a 0-10% performance
>> decrease in the 128K sequential read tests.  Primarily it made performance
>> lower on average and more variable.
>
> This one is surprising to me since this change is also in Hammer
> (cf6e1f50ea7b5c2fd6298be77c06ed4765d66611).  When you are performing
> the bisect, are you keeping the OSDs at the same version and only
> swapping out librbd?
>
>> 2) https://github.com/ceph/ceph/commit/c474ee42
>>
>> This commit had a very large impact, reducing performance by another 20-25%.
>
> Definitely an area we should optimize given the number of
> AioCompletions that are constructed.

Previously I talked to josh about the cpu time caused by
librbd::AioCompletion. The mutex construct and deconstruct hurt a lot.

A idea is create a object pool to cache this or add a api to allow
user to reset AioCompletion to make it reuse

>
>> 3) https://github.com/ceph/ceph/commit/66e7464
>>
>> This was a fix that helped regain some of the performance loss due to
>> c474ee42, but didn't totally reclaim it.
>
> Odd -- since that effectively reverted c474ee42 (unique_lock_name)
> within the IO path.
>
>> 5) https://github.com/ceph/ceph/commit/8aae868
>>
>> The new AioImageRequestWQ appears to be the cause of the most recent large
>> reduction in 128K sequential read performance.
>
> We will have to investigate this -- AioImageRequestWQ is just a
> wrapper around the same work queue used in the Hammer release.
>
> --
> Jason
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
