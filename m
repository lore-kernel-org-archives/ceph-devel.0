From: Loic Dachary <loic@dachary.org>
Subject: Re: Upcoming 10.2.4
Date: Wed, 19 Oct 2016 16:54:58 +0200
Message-ID: <58078942.5080206@dachary.org>
References: <57FB7494.1010309@dachary.org> <58074246.7030904@dachary.org>
 <CA+aFP1CcCw=4qvx1qh+xqdQ8vUZkwWbXmYdbYhMqdeJOArb-+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49270 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943067AbcJSOzI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Oct 2016 10:55:08 -0400
In-Reply-To: <CA+aFP1CcCw=4qvx1qh+xqdQ8vUZkwWbXmYdbYhMqdeJOArb-+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Ok. I created http://tracker.ceph.com/issues/17616 and set it to Urgent so that it's not overlooked.

On 19/10/2016 16:26, Jason Dillaman wrote:
> There is one more backport required [1] once it is merged into the
> master branch (hopefully this week) to fix an assertion failure that
> would otherwise be introduced by 10.2.4.
> 
> Thanks,
> Jason
> 
> [1] https://github.com/ceph/ceph/pull/11520
> 
> On Wed, Oct 19, 2016 at 5:52 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Abhishek,
>>
>> Unless I missed something, all backports that matter are now in the last round of testing[1]. If we're lucky all backports in the testing branch (jewel-backports) will be merged. Even if it's not the case I'll make sure at least all the urgent ones[2] are.
>>
>> If the test infrastructure permits, I should be able to propose you to cut 10.2.4 early next week.
>>
>> Cheers
>>
>> [1] http://tracker.ceph.com/issues/17487#note-16
>> [2] http://tracker.ceph.com/projects/ceph/issues?query_id=96
>>
>> On 10/10/2016 12:59, Loic Dachary wrote:
>>> Hi Abhishek,
>>>
>>> Since you're now release manager, it is my understanding that we'll be asking you if the release should be cut or not. I updated the issue tracking the progress of 10.2.4 accordingly. This is a heads up to let you know we'll most likely ask that question for 10.2.4 some time next week ;-)
>>>
>>> Cheers
>>>
>>> [1] http://tracker.ceph.com/journals/diff/79457?detail_id=76318
>>>
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
