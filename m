From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: [ceph-users] Does crushtool --test --simulate do what cluster
 should do?
Date: Tue, 24 Mar 2015 13:34:39 -0600
Message-ID: <CAANLjFqo6Qtoeqe-hLsG+vkEHzRTbvVBwLnFsKHSPYN8HMAFUw@mail.gmail.com>
References: <CAANLjFosqAv5a24H0mM9V5b_okXbcb7-1aNskNh14Rf6qLAVUQ@mail.gmail.com>
	<CAANLjFpytozjZiYv8AYszRUEn=au62UN7GJf71LAxw5meeRU6w@mail.gmail.com>
	<CAC6JEv80NbTsyfiG4NbzqsYG0wP78+Gy6YyD4km1if2K+PfBNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35082 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbbCXTek (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Mar 2015 15:34:40 -0400
Received: by wibdy8 with SMTP id dy8so83862977wib.0
        for <ceph-devel@vger.kernel.org>; Tue, 24 Mar 2015 12:34:39 -0700 (PDT)
In-Reply-To: <CAC6JEv80NbTsyfiG4NbzqsYG0wP78+Gy6YyD4km1if2K+PfBNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph-User <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

http://tracker.ceph.com/issues/11224

On Tue, Mar 24, 2015 at 12:11 PM, Gregory Farnum <greg@gregs42.com> wrote:
> On Tue, Mar 24, 2015 at 10:48 AM, Robert LeBlanc <robert@leblancnet.us> wrote:
>> I'm not sure why crushtool --test --simulate doesn't match what the
>> cluster actually does, but the cluster seems to be executing the rules
>> even though crushtool doesn't. Just kind of stinks that you have to
>> test the rules on actual data.
>>
>> Should I create a ticket for this?
>
> Yes please! I'm not too familiar with the crushtool internals but the
> simulator code hasn't had too many eyeballs so it's hopefully not too
> hard a bug to fix.
>
>>
>> On Mon, Mar 23, 2015 at 6:08 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
>>> I'm trying to create a CRUSH ruleset and I'm using crushtool to test
>>> the rules, but it doesn't seem to mapping things correctly. I have two
>>> roots, on for spindles and another for SSD. I have two rules, one for
>>> each root. The output of crushtool on rule 0 shows objects being
>>> mapped to SSD OSDs when it should only be choosing spindles.
>>>
>>> I'm pretty sure I'm doing something wrong. I've tested the map on .93 and .80.8.
>>>
>>> The map is at http://pastebin.com/BjmuASX0
>>>
>>> when running
>>>
>>> crushtool -i map.crush --test --num-rep 3 --rule 0 --simulate --show-mappings
>>>
>>> I'm getting mapping to OSDs > 39 which are SSDs. The same happens when
>>> I run the SSD rule, I get OSDs from both roots. It is as if crushtool
>>> is not selecting the correct root. In fact both rules result in the
>>> same mapping:
>>>
>>> RNG rule 0 x 0 [0,38,23]
>>> RNG rule 0 x 1 [10,25,1]
>>> RNG rule 0 x 2 [11,40,0]
>>> RNG rule 0 x 3 [5,30,26]
>>> RNG rule 0 x 4 [44,30,10]
>>> RNG rule 0 x 5 [8,26,16]
>>> RNG rule 0 x 6 [24,5,36]
>>> RNG rule 0 x 7 [38,10,9]
>>> RNG rule 0 x 8 [39,9,23]
>>> RNG rule 0 x 9 [12,3,24]
>>> RNG rule 0 x 10 [18,6,41]
>>> ...
>>>
>>> RNG rule 1 x 0 [0,38,23]
>>> RNG rule 1 x 1 [10,25,1]
>>> RNG rule 1 x 2 [11,40,0]
>>> RNG rule 1 x 3 [5,30,26]
>>> RNG rule 1 x 4 [44,30,10]
>>> RNG rule 1 x 5 [8,26,16]
>>> RNG rule 1 x 6 [24,5,36]
>>> RNG rule 1 x 7 [38,10,9]
>>> RNG rule 1 x 8 [39,9,23]
>>> RNG rule 1 x 9 [12,3,24]
>>> RNG rule 1 x 10 [18,6,41]
>>> ...
>>>
>>>
>>> Thanks,
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
