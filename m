From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: contraining crush placement possibilities
Date: Fri, 07 Mar 2014 11:53:51 +0800
Message-ID: <531942CF.2010202@ubuntukylin.com>
References: <alpine.DEB.2.00.1403061227080.17325@cobra.newdream.net> <5319423B.7030402@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:59610 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbaCGD7v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 22:59:51 -0500
In-Reply-To: <5319423B.7030402@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

Provided 3 osds are down simultaneously

On 2014/3/7 11:51, Li Wang wrote:
> Just had a quick look. It seems crush could meet the demand,
> say, if we have 100 osds, replica_num is 3, then we partition the
> 100 osds into 3 trees, 'take' iterates on the 3 trees, for each tree,
> select 1 osd. Then the probability of losing data is at most n*n*n/Cn3,
> can we make it better?
>
>
> On 2014/3/7 4:30, Sage Weil wrote:
>> During the CRUSH CDS session yesterday I talked a bit about the desire to
>> constrain the number of possible disk combinations so that we reduce the
>> probability of a concurrent failure from causing data loss.  Sheldon just
>> pointed out a talk from ATC that discusses the basic problem:
>>
>>     https://www.usenix.org/conference/atc13/technical-sessions/presentation/cidon
>>
>>
>> The situation with CRUSH is slightly better, I think, because the number
>> of peers for a given OSD in a large cluster is bounded (pg_num /
>> num_osds), but I think we may still be able improve things.
>>
>> Last night it occurred to me that this is almost just having pgp_num <
>> pg_num, but I think that's not quite right either.
>>
>> If anyone has some clear intuition here, would love to hear it.  If there
>> is anything we can do to improve things we definitely want to do it!
>>
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
