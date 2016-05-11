From: Mark Nelson <mnelson@redhat.com>
Subject: Re: [ceph-users] Hammer vs Jewel librbd performance testing and git
 bisection results
Date: Wed, 11 May 2016 09:07:20 -0500
Message-ID: <bcf1b2db-b7c7-7ffe-1970-7469f7ff7cb4@redhat.com>
References: <f9f54455-8348-42b7-153b-e38850eed5e1@redhat.com>
 <CA+aFP1BN=mpR-7xid=+vgz3rpSWkirthrYDPuEy-OkreVp=A-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36464 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932162AbcEKOHY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 May 2016 10:07:24 -0400
In-Reply-To: <CA+aFP1BN=mpR-7xid=+vgz3rpSWkirthrYDPuEy-OkreVp=A-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "cbt@lists.ceph.com" <cbt@lists.ceph.com>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>



On 05/11/2016 08:52 AM, Jason Dillaman wrote:
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

Nope, I had no idea when trying to track this down if this was 100% 
librbd or if there were other issues at play too, so the OSDs and librbd 
are both changing.  Having said that, I wouldn't expect there to be any 
difference in the OSD code between afb896d and 3a7b5e3.

Given the variability in the results starting with 3a7b5e3, it might be 
some kind of secondary effect.  The highest performing samples were 
still in the same ballpark as pre-3a7b5e3.  I guess I would worry less 
about this one right now.

>
>> 2) https://github.com/ceph/ceph/commit/c474ee42
>>
>> This commit had a very large impact, reducing performance by another 20-25%.
>
> Definitely an area we should optimize given the number of
> AioCompletions that are constructed.
>
>> 3) https://github.com/ceph/ceph/commit/66e7464
>>
>> This was a fix that helped regain some of the performance loss due to
>> c474ee42, but didn't totally reclaim it.
>
> Odd -- since that effectively reverted c474ee42 (unique_lock_name)
> within the IO path.

Perhaps 0024677 or 3ad19ae introduced another regression that was being 
masked by c474e4 and when 66e7464 improved the situation, the other 
regression appeared?

>
>> 5) https://github.com/ceph/ceph/commit/8aae868
>>
>> The new AioImageRequestWQ appears to be the cause of the most recent large
>> reduction in 128K sequential read performance.
>
> We will have to investigate this -- AioImageRequestWQ is just a
> wrapper around the same work queue used in the Hammer release.
>
