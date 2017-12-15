From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: [ceph-users] Snap trim queue length issues
Date: Fri, 15 Dec 2017 10:00:56 +0100
Message-ID: <81eabcfe-59b1-70c9-4f4f-2abbc86b9456@corp.ovh.com>
References: <82009aab-6b20-ef21-9bbd-76fddf84e0a3@corp.ovh.com>
 <CAN-Gep+JEdr1V8B42YTy0rZzFM8B0TwHRqTs8WjrjcQm8tFgHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 11.mo302.mail-out.ovh.net ([37.187.190.78]:51203 "EHLO
        11.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbdLOJA7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Dec 2017 04:00:59 -0500
In-Reply-To: <CAN-Gep+JEdr1V8B42YTy0rZzFM8B0TwHRqTs8WjrjcQm8tFgHA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Turner <drakonstein@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On 17-12-14 05:31 PM, David Turner wrote:
> I've tracked this in a much more manual way.  I would grab a random subset 
> [..]
> 
> This was all on a Hammer cluster.  The changes to the snap trimming queues 
> going into the main osd thread made it so that our use case was not viable 
> on Jewel until changes to Jewel that happened after I left.  It's exciting 
> that this will actually be a reportable value from the cluster.
> 
> Sorry that this story doesn't really answer your question, except to say 
> that people aware of this problem likely have a work around for it.  However 
> I'm certain that a lot more clusters are impacted by this than are aware of 
> it and being able to quickly see that would be beneficial to troubleshooting 
> problems.  Backporting would be nice.  I run a few Jewel clusters that have 
> some VM's and it would be nice to see how well the cluster handle snap 
> trimming.  But they are much less critical on how much snapshots they do.

Thanks for your response, it pretty much confirms what I though:
- users aware of issue have their own hacks that don't need to be efficient 
or convenient.
- users unaware of issue are, well, unaware and at risk of serious service 
disruption once disk space is all used up.

Hopefully it'll be convincing enough for devs. ;)

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
