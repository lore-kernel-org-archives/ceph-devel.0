From: Luis Pabon <lpabon@redhat.com>
Subject: Re: Cache tier READ_FORWARD transition
Date: Wed, 09 Jul 2014 13:46:31 -0400
Message-ID: <53BD7FF7.1090801@redhat.com>
References: <53BACB03.5010603@redhat.com> <alpine.DEB.2.00.1407070934120.23451@cobra.newdream.net> <53BB11C7.4050802@redhat.com> <alpine.DEB.2.00.1407080856060.9196@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35220 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746AbaGIRqd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 Jul 2014 13:46:33 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s69HkWgf003369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <ceph-devel@vger.kernel.org>; Wed, 9 Jul 2014 13:46:33 -0400
In-Reply-To: <alpine.DEB.2.00.1407080856060.9196@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is great information.

Thank Sage.

- Luis


On 07/08/2014 12:01 PM, Sage Weil wrote:
> On Mon, 7 Jul 2014, Luis Pab?n wrote:
>> What about the following usecase (please forgive some of my ceph architecture
>> ignorance):
>>
>> If it was possible to setup OSD caching tier at the host (if the host had a
>> dedicated SSD for accelerating I/O), then caching pools could be created to
>> cache VM rbds, since they are inherently exclusive to a single host.  Using a
>> write through (or a readonly, depending on the workload) policy would have a
>> major increase in VM IOPs.   Using writethrough or readonly policy would also
>> ensure any writes are first written to the back end storage tier.  Enabling
>> hosts to service most of their VM I/O reads would also increases the overall
>> IOPs of the back end storage tier.
> This could be accomplished by doing a rados pool per client host.  The
> rados caching only works in as a writeback cache, though, not
> write-through, so you really need to replicate it for it to be usable in
> practice.  So although it's possible, this isn't a particularly attractive
> approach.
>
> What you're describing is really a client-side write-through cache, either
> for librbd or librados.  We've discussed this in the past (mostly in the
> context of a shared host-wide read-only data, not as write-through), but
> in both cases the caching would plug into the client libraries.  There are
> some CDS notes from emperor:
>
> 	http://wiki.ceph.com/Planning/Sideboard/rbd%3A_shared_read_cache
> 	http://pad.ceph.com/p/rbd-shared-read-cache
> 	http://www.youtube.com/watch?v=SVgBdUv_Lv4&t=70m11s
>
> Note that you can also accomplish this with the kernel rbd driver by
> layering dm-cache or bcache or something similar on top and running it in
> write-through mode.  Most clients are (KVM+)librbd, though, so eventually
> a userspace implementation for librbd (or maybe librados) makes sense.
>
> sage
>
>
>> Does this make sense?
>>
>> - Luis
>>
>> On 07/07/2014 03:29 PM, Sage Weil wrote:
>>> On Mon, 7 Jul 2014, Luis Pabon wrote:
>>>> Hi all,
>>>>       I am working on OSDMonitor.cc:5325 and wanted to confirm the
>>>> following
>>>> read_forward cache tier transition:
>>>>
>>>>       readforward -> forward || writeback || (any && num_objects_dirty ==
>>>> 0)
>>>>       forward -> writeback || readforward || (any && num_objects_dirty ==
>>>> 0)
>>>>       writeback -> readforward || forward
>>>>
>>>> Is this the correct cache tier state transition?
>>> That looks right to me.
>>>
>>> By the way, I had a thought after we spoke that we probably want something
>>> that is somewhere inbetween the current writeback behavior (promote on
>>> first read) and the read_forward behavior (never promote on read).  I
>>> suspect a good all-around policy is something like promote on second read?
>>> This should probably be rolled into the writeback mode as a tunable...
>>>
>>> sage
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

