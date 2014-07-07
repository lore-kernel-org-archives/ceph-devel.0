From: =?ISO-8859-1?Q?Luis_Pab=F3n?= <lpabon@redhat.com>
Subject: Re: Cache tier READ_FORWARD transition
Date: Mon, 07 Jul 2014 17:03:37 -0400
Message-ID: <53BB0B29.6080807@redhat.com>
References: <53BACB03.5010603@redhat.com> <alpine.DEB.2.00.1407070934120.23451@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36870 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbaGGVDk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Jul 2014 17:03:40 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s67L3d1X001266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <ceph-devel@vger.kernel.org>; Mon, 7 Jul 2014 17:03:39 -0400
In-Reply-To: <alpine.DEB.2.00.1407070934120.23451@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think so, but I am not sure what kind of workload would benefit from 
that tune.  Do you have any in mind?  Is the reason for this tuneable 
value to have a more storage efficient caching tier?

- Luis

On 07/07/2014 03:29 PM, Sage Weil wrote:
> On Mon, 7 Jul 2014, Luis Pabon wrote:
>> Hi all,
>>      I am working on OSDMonitor.cc:5325 and wanted to confirm the following
>> read_forward cache tier transition:
>>
>>      readforward -> forward || writeback || (any && num_objects_dirty == 0)
>>      forward -> writeback || readforward || (any && num_objects_dirty == 0)
>>      writeback -> readforward || forward
>>
>> Is this the correct cache tier state transition?
> That looks right to me.
>
> By the way, I had a thought after we spoke that we probably want something
> that is somewhere inbetween the current writeback behavior (promote on
> first read) and the read_forward behavior (never promote on read).  I
> suspect a good all-around policy is something like promote on second read?
> This should probably be rolled into the writeback mode as a tunable...
>
> sage
>
>

