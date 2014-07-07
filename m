From: =?ISO-8859-1?Q?Luis_Pab=F3n?= <lpabon@redhat.com>
Subject: Re: Cache tier READ_FORWARD transition
Date: Mon, 07 Jul 2014 17:31:51 -0400
Message-ID: <53BB11C7.4050802@redhat.com>
References: <53BACB03.5010603@redhat.com> <alpine.DEB.2.00.1407070934120.23451@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63729 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877AbaGGVbx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 7 Jul 2014 17:31:53 -0400
In-Reply-To: <alpine.DEB.2.00.1407070934120.23451@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Mark Nelson <mnelson@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

What about the following usecase (please forgive some of my ceph 
architecture ignorance):

If it was possible to setup OSD caching tier at the host (if the host 
had a dedicated SSD for accelerating I/O), then caching pools could be 
created to cache VM rbds, since they are inherently exclusive to a 
single host.  Using a write through (or a readonly, depending on the 
workload) policy would have a major increase in VM IOPs.   Using 
writethrough or readonly policy would also ensure any writes are first 
written to the back end storage tier.  Enabling hosts to service most of 
their VM I/O reads would also increases the overall IOPs of the back end 
storage tier.

Does this make sense?

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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

