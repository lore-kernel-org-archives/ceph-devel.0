From: Loic Dachary <loic@dachary.org>
Subject: Re: rgw and the next jewel release v10.2.3
Date: Thu, 25 Aug 2016 22:34:48 +0200
Message-ID: <57BF5668.20707@dachary.org>
References: <57BC10E5.10408@dachary.org>
 <CADRKj5Sb6+9gue7NZJ47+3AmK-PyQZA2BoKvqXD7EbYXSrqv3w@mail.gmail.com>
 <6315ff7a-e766-6d21-539f-cff31cf124bd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:35537 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755868AbcHYUq2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2016 16:46:28 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 7B965535220
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2016 22:35:53 +0200 (CEST)
In-Reply-To: <6315ff7a-e766-6d21-539f-cff31cf124bd@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

Hi Casey,

http://tracker.ceph.com/issues/16696
http://tracker.ceph.com/issues/16702

were merged right now via

https://github.com/ceph/ceph/pull/10845

the remaining two have been tested and await approval

https://github.com/ceph/ceph/pull/10662
https://github.com/ceph/ceph/pull/10660

A dozen other pull requests could also be merged if you'd like since they passed a rgw run.

Cheers

On 24/08/2016 19:32, Casey Bodley wrote:
> 
> On 08/24/2016 12:41 PM, Yehuda Sadeh-Weinraub wrote:
>> Hey Casey,
>>
>> are all the multisite fixes we wanted in?
> 
> There are still a few pending backport, including 3 in particular that fix segfaults:
> 
> http://tracker.ceph.com/issues/16901
> http://tracker.ceph.com/issues/16864
> http://tracker.ceph.com/issues/16696
> 
> It looks like that last one is blocked by conflicts with the tenant support backport in http://tracker.ceph.com/issues/16702. I'll rebase that one and open a PR.
> 
> Casey
> 
>>
>> On Tue, Aug 23, 2016 at 2:01 AM, Loic Dachary <loic@dachary.org> wrote:
>>> Hi Yehuda,
>>>
>>> The next jewel release as found at https://github.com/ceph/ceph/tree/jewel passed the rgw suite (http://tracker.ceph.com/issues/16344#note-27 except for two failures). Do you think the jewel branch is ready for QE to start their own round of testing ?
>>>
>>> Cheers
>>>
>>> -- 
>>> Loïc Dachary, Artisan Logiciel Libre
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
