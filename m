From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Critical PRs needed for 12.2.3 Luminous
Date: Fri, 2 Feb 2018 09:21:43 +0100
Message-ID: <ce1135b6-87b6-4d28-dd5a-74821f3da000@corp.ovh.com>
References: <98c4c73b609b9278013e46213a79efdd@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 10.mo301.mail-out.ovh.net ([137.74.110.73]:47542 "EHLO
        10.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeBBIVq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Feb 2018 03:21:46 -0500
In-Reply-To: <98c4c73b609b9278013e46213a79efdd@suse.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek <abhishek@suse.com>, ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, John Spray <jspray@redhat.com>

On 18-01-31 09:05 PM, Abhishek wrote:
> Are there any critical PRs we need for 12.2.3 that isn't already merged 
> (anything with a luminous-batch-1/wip-yuri* labels are already ongoing qe 
> runs), if so can you please reply in this thread so that we can prioritize 
> this for QE and hopefully go for final approvals next week.

There was some confusion related to https://github.com/ceph/ceph/pull/20098. 
My understanding is that the pull request 
https://github.com/ceph/ceph/pull/19965 and discussion 
(https://www.spinics.net/lists/ceph-devel/msg39747.html) somehow went under 
radar for some, raising some valid concerns in the process.
The 20098 was undergoing testing and it's not anymore, so my question is - 
what's the status of that PR? Was there some actual issue with it, or it was 
withdrawn from testing because of reasons mentioned above?
It would be great to have it in Luminous because issue with snap trimmer not 
keeping up is real and can be deadly when not noticed early.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
