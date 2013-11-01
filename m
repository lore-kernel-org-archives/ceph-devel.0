From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: coverity scan - a plea for help!
Date: Fri, 01 Nov 2013 08:38:52 +0800
Message-ID: <5272F81C.80805@ubuntukylin.com>
References: <alpine.DEB.2.00.1305090922300.4023@cobra.newdream.net> <alpine.DEB.2.00.1310311627020.5407@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:49341 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab3KAAi5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Oct 2013 20:38:57 -0400
In-Reply-To: <alpine.DEB.2.00.1310311627020.5407@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
   If you trust, I think we can try this job.

Cheers,
Li Wang

On 11/01/2013 07:30 AM, Sage Weil wrote:
> Hi everyone,
>
> When I send this out several months ago, Danny Al-Gaaf stepped up and
> submitted an amazing number of patches cleaning up the most concerning
> issues that Coverity had picked up.  His attention has been directed
> elsewhere more recently, but there are still a number of outstanding
> issues in Coverity's tracker that are reasonably quick and easy to resolve
> and will make our ability to identify newly introduced defects much
> simpler.
>
> Coverity Scan makes it really easy to participate: just create an account
> and I can grant you access to the Ceph project.  If you're interested in
> contributing here (and it's an easy way to quickly start working with the
> Ceph code), let me know!
>
> Thanks-
> sage
>
>
> On Thu, 9 May 2013, Sage Weil wrote:
>
>> We were added to coverity's awesome scan program a while back, which gives
>> free access to their static analysis tool to open source projects.
>>
>> Currently it identifies 421 issues.  We've already taken care of the ones
>> that are highest impact, but the usefulness of periodic scans is limited
>> until we can eliminate the noise from the remaining issues and easily see
>> when new problems come up.
>>
>> If anybody is interested in helping out in the cleanup effort, let me know
>> and I'll share the login info.  This would provide significant value to
>> our overall quality efforts and is a pretty easy way to make a meaningful
>> contribution to the project without a huge investment in understanding the
>> code and architecture!
>>
>> sage
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
