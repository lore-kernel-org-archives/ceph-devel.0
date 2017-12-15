From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: Re: Bluestore and jemalloc
Date: Fri, 15 Dec 2017 11:03:41 -0600
Message-ID: <d5141320-08d5-d4c7-9cc3-c6271d27bb4f@gmail.com>
References: <42631468-7CF3-4BBC-8984-24756D6F930F@gmail.com>
 <alpine.DEB.2.11.1712151527090.2838@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:40380 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755853AbdLORDo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Dec 2017 12:03:44 -0500
Received: by mail-it0-f41.google.com with SMTP id f190so20423897ita.5
        for <ceph-devel@vger.kernel.org>; Fri, 15 Dec 2017 09:03:43 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1712151527090.2838@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Mike A <mike.almateia@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 12/15/2017 09:29 AM, Sage Weil wrote:
> On Fri, 15 Dec 2017, Mike A wrote:
>> Hello!
>>
>> After fix this issue http://tracker.ceph.com/issues/20557 Ceph is still
>> working with jemalloc? Or it’s not possible right now only after will be
>> fix a issue in rocksdb?
>>
>> I have a work to create a cluster based on nvme disks with jemalloc
>> enabled configuration. Now I'm worried jemalloc support in ceph about.
> 
> I'm not sure about the current status of the bug: I don't know why
> jemalloc and rocksdb were not working together, and I'm not sure whether
> the fix is simple (build option?) or more complex.
> 
> It's also not clear whether jemalloc is going to be helpful or that this
> is important.  jemalloc was much better than tcmalloc with
> SimpleMessenger, but the default is now AsyncMessenger and there wasn't
> much of a delta.

For reference, here's the initial allocator tests from back then:

https://drive.google.com/open?id=0B2gTBZrkrnpZek0zWlE5aVVuRlk

And a comparison of simple vs async for tcmalloc and jemalloc under some 
of the worst case scenarios from that time period:

https://drive.google.com/open?id=0B2gTBZrkrnpZS1Q4VktjZkhrNHc

> 
> Either way, jemalloc is a runtime option, so either it works or it
> doesn't, but the fix is to restart the daemons--there's no risk.
> 
> sage
> 
