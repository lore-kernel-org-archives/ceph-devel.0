From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: PRs not being tested by jenkins??
Date: Thu, 27 Apr 2017 17:47:48 +0200
Message-ID: <09d35b66-5e5d-b322-ed12-8ebcefbe391c@digiware.nl>
References: <368674ff-451c-f006-147b-ba7ab17b660a@digiware.nl>
 <585be7e7-3eab-76e8-af6b-788d79d6721e@digiware.nl>
 <855cb287-8fb0-5204-254d-28747cb6cc17@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:43310 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030375AbdD0Pr4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 27 Apr 2017 11:47:56 -0400
In-Reply-To: <855cb287-8fb0-5204-254d-28747cb6cc17@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 27-4-2017 17:32, Casey Bodley wrote:
> 
> On 04/27/2017 11:05 AM, Willem Jan Withagen wrote:
>> On 27-4-2017 16:52, Willem Jan Withagen wrote:
>>> Hi,
>>>
>>> Is there any particulars why I have 4 PRs that are held on trial runs
>>> thru Jenkins?
>> 'mmm,
>>
>> Some/All of them "just" started to be processed.
>> So I guess the queue was rather full.
>>
>> --WjW
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> I've noticed that some tests in 'make check' are taking really long
> time. For example, in
> https://jenkins.ceph.com/job/ceph-pull-requests/23011/console
> 
> 164/169 Test  #98: test-erasure-eio.sh .....................   Passed 
> 345.09 sec
> 165/169 Test #145: osd-markdown.sh .........................   Passed 
> 179.91 sec
> 166/169 Test   #2: erasure-decode-non-regression.sh ........   Passed 
> 716.54 sec
> 167/169 Test #169: unittest_rbd_mirror .....................   Passed 
> 115.21 sec
> 168/169 Test   #5: cephtool-test-mon.sh ....................   Passed 
> 1613.65 sec
> 169/169 Test #148: osd-scrub-repair.sh .....................   Passed 
> 1444.25 sec
> 
> This might be why the queue is full.

Right, that are rather serious testing times.

--WjW


