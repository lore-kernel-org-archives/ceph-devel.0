From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: BlueStore in-memory Onode footprint
Date: Fri, 16 Dec 2016 18:58:45 +0300
Message-ID: <444ee224-ae2d-422b-9071-4ae62885b57c@mirantis.com>
References: <34ee2613-8db3-646e-4470-b3e8fa8855e0@mirantis.com>
 <alpine.DEB.2.11.1612161518570.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f174.google.com ([209.85.213.174]:35750 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762050AbcLPP6s (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2016 10:58:48 -0500
Received: by mail-yb0-f174.google.com with SMTP id d128so40073225ybh.2
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2016 07:58:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612161518570.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage,


here is the PR that contains the test case for Onode size measurement:

https://github.com/ceph/ceph/pull/12532



On 16.12.2016 18:20, Sage Weil wrote:
> On Fri, 16 Dec 2016, Igor Fedotov wrote:
>> Hey All!
>>
>> Recently I realized that I'm unable to fit all my onodes ( 32768 objects/4Mb
>> each/4K alloc unit/no csum) in 15G RAM cache.
>>
>> Hence decided to estimate Onode in-memory size.
>>
>> At first I filled 4Mb object with a single 4M write - mempools indicate ~5K
>> mem usage for total onode metadata. Good enough.
>>
>> Secondly I refill that object with 4K writes. Resulting memusage = 574K!!!
>> Onode itself 704 bytes in 1 object.  And 4120 other metadata items occupies
>> all other space.
>>
>> Then I removed SharedBlob from mempools. Resulting mem usage = 355K. The same
>> Onode size. And 3096 other metadata objects. Hence we had 1024 SharedBlob
>> instances thata took ~ 220K.
>>
>>
>> And finally I removed Blob instances from measurements. Resulting mem usage =
>> 99K. And 2072 other objects. Hence Blob instances take another ~250K
> Yikes!
>
> BTW you can get a full breakdown by type with 'mempool debug = true' in
> ceph.conf (-o 'mempool debug = true' on vstart.sh command line) without
> having to recompile.  Do you mind repeating the test and including the
> full breakdown?
>   
>> Yeah, that's the worst case( actually csum enable will give even more mem use)
>> but shouldn't we revisit some Onode internals due to such numbers?
> Yep!
>
> sage

