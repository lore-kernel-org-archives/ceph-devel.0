From: Loic Dachary <loic@dachary.org>
Subject: Re: Beta testing crush optimization
Date: Wed, 31 May 2017 10:01:17 +0300
Message-ID: <2f58ce5a-761c-2fad-5fa0-efd4c778745c@dachary.org>
References: <07dda37f-b8c9-f977-c767-6c1c4bc78fd6@dachary.org>
 <c4186786-d7ff-097d-ac71-1dbb12d58540@profihost.ag>
 <624fbbf9-a0cd-5ffa-2db2-6137713c5c2e@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39246 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdEaHBW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 31 May 2017 03:01:22 -0400
In-Reply-To: <624fbbf9-a0cd-5ffa-2db2-6137713c5c2e@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

(as a conclusion to this thread)

Thanks for testing (and your patience while I was fixing a few bugs). 

I'm glad your cluster is now almost even (+/- 1.5% over/under filled for the OSDs and 0.5% for the hosts). It is better than it was before (+/- 25% over/under filled for the OSDs and 6% for the hosts).

Worst case scenario if a host fails was (before optimization):

        ~over filled %~
~type~                 
device            30.15
host              10.53

After optimization it is down to:

        ~over filled %~
~type~                 
device             7.94
host               4.55

Since you have a full SSD cluster you chose to optimize all at once. It means the incremental approach (--step) was not used.

Cheers

On 05/24/2017 05:01 PM, Loic Dachary wrote:
> 
> 
> On 05/24/2017 04:50 PM, Stefan Priebe - Profihost AG wrote:
>> Hello,
>>
>> great! What means pool 3? Is it just the pool nr from the poll dump / ls
>> command?
> 
> Yes. In the report you sent me, this is the number of the only pool in the cluster.
> 
>>
>> Stefan
>>
>> Am 24.05.2017 um 15:48 schrieb Loic Dachary:
>>> Hi Stefan,
>>>
>>> Thanks for volunteering to beta test the crush optimization on a live cluster :-)
>>>
>>> The "crush optimize" command was published today[1] and you should be able to improve your cluster distribution with the following:
>>>
>>> ceph report > report.json
>>> crush optimize --no-forecast --step 64 --crushmap report.json --pool 3 --out-path optimized.crush
>>> ceph osd setcrushmap -i optimized.crush
>>>
>>> Note that it will only perform a first optimization step (moving around 64 PGs). You will need to repeat this command a dozen time to fully optimize the cluster. I assume that's what you will want to control the workload. If you want a minimal change at each step, you can try --step 1 but it will require more than a hundred steps.
>>>
>>> If you're not worried about the load of the cluster, you can optimize it in one go with:
>>>
>>> ceph report > report.json
>>> crush optimize --crushmap report.json --pool 3 --out-path optimized.crush
>>> ceph osd setcrushmap -i optimized.crush
>>>
>>> Cheers
>>>
>>> [1] http://crush.readthedocs.io/en/latest/ceph/optimize.html
>>>
>>
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
