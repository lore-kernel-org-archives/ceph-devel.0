From: Loic Dachary <loic@dachary.org>
Subject: Re: Beta testing crush optimization
Date: Wed, 24 May 2017 17:01:16 +0300
Message-ID: <624fbbf9-a0cd-5ffa-2db2-6137713c5c2e@dachary.org>
References: <07dda37f-b8c9-f977-c767-6c1c4bc78fd6@dachary.org>
 <c4186786-d7ff-097d-ac71-1dbb12d58540@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33897 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965567AbdEXOBX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 10:01:23 -0400
In-Reply-To: <c4186786-d7ff-097d-ac71-1dbb12d58540@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 05/24/2017 04:50 PM, Stefan Priebe - Profihost AG wrote:
> Hello,
> 
> great! What means pool 3? Is it just the pool nr from the poll dump / ls
> command?

Yes. In the report you sent me, this is the number of the only pool in the cluster.

> 
> Stefan
> 
> Am 24.05.2017 um 15:48 schrieb Loic Dachary:
>> Hi Stefan,
>>
>> Thanks for volunteering to beta test the crush optimization on a live cluster :-)
>>
>> The "crush optimize" command was published today[1] and you should be able to improve your cluster distribution with the following:
>>
>> ceph report > report.json
>> crush optimize --no-forecast --step 64 --crushmap report.json --pool 3 --out-path optimized.crush
>> ceph osd setcrushmap -i optimized.crush
>>
>> Note that it will only perform a first optimization step (moving around 64 PGs). You will need to repeat this command a dozen time to fully optimize the cluster. I assume that's what you will want to control the workload. If you want a minimal change at each step, you can try --step 1 but it will require more than a hundred steps.
>>
>> If you're not worried about the load of the cluster, you can optimize it in one go with:
>>
>> ceph report > report.json
>> crush optimize --crushmap report.json --pool 3 --out-path optimized.crush
>> ceph osd setcrushmap -i optimized.crush
>>
>> Cheers
>>
>> [1] http://crush.readthedocs.io/en/latest/ceph/optimize.html
>>
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
