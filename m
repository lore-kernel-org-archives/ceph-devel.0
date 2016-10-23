From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Possible corruption with MSSQL on RBD
Date: Sun, 23 Oct 2016 12:22:52 +0200
Message-ID: <d533798c-b1cf-42c4-9484-3edfc4b5eeaf@suse.cz>
References: <262972897.5995.1476280634060@ox.pcextreme.nl>
 <CAJ4mKGZx+PgcqAPVB0LSFxp1z=aZiKWt-H1hjnKJU5_hxAoxWg@mail.gmail.com>
 <439702971.6004.1476287822395@ox.pcextreme.nl>
 <2126451990.6086.1476439471715@ox.pcextreme.nl>
 <CABZ+qqkw4JrLko0bjjVWXF_o3nibDzVCRitnf8GUK+pZy+4pNA@mail.gmail.com>
 <1370594328.6476.1477150447423@ox.pcextreme.nl>
 <CABZ+qqkTyhvFvbAEi96oj0jYJZZFXqfHwrweaU8KFq9H21V=dg@mail.gmail.com>
 <alpine.DEB.2.11.1610221804510.3288@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933019AbcJWKXA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 23 Oct 2016 06:23:00 -0400
In-Reply-To: <alpine.DEB.2.11.1610221804510.3288@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Dan van der Ster <dan@vanderster.com>
Cc: Wido den Hollander <wido@42on.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>>> I've understood that you don't see the problem any more with jewel,
>>>> but I didn't see any confirmation that 9ec6e7 is indeed the fix. Did
>>>> you run any more testing of hammer + 9ec6e7?
>>>>
>>>
>>> Oh, I updated the issues and not the ML. Yes, with hammer + that fix we no longer see the issue.
>>>
>>> The fix is now pending for 0.94.10
>>
>> Excellent.
>>
>> So, I don't really understand how this corruption is triggered. Is it
>> something unique about the MSSQL workload that triggers it or is this
>> a general problem that's probably going on undetected by other RBD
>> use-cases?
>
> It could affect other workloads as well.  You'll definitely want to
> upgrade once 0.94.10 is out.

JFYI, hammer backport now staged:

https://github.com/ceph/ceph/pull/11612

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
