From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: [ceph-users] stalls caused by scrub on jewel
Date: Tue, 6 Dec 2016 17:05:23 +0100
Message-ID: <0a5f96b1-9013-7365-8b79-b9b38938fe6b@digiware.nl>
References: <alpine.DEB.2.11.1611152232260.2650@piezo.us.to>
 <CABZ+qqmyyGrvLRT2zRMn5_RXWPeKyiKaPXfJRZ3qCY5v13-m_Q@mail.gmail.com>
 <alpine.DEB.2.11.1612061415400.4753@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:34270 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751570AbcLFQF2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 6 Dec 2016 11:05:28 -0500
In-Reply-To: <alpine.DEB.2.11.1612061415400.4753@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

On 6-12-2016 15:16, Sage Weil wrote:
> On Tue, 6 Dec 2016, Dan van der Ster wrote:
>> Hi Sage,
>>
>> Could you please clarify: do we need to set nodeep-scrub also, or does
>> this somehow only affect the (shallow) scrub?
>>
>> (Note that deep scrubs will start when the deep_scrub_interval has
>> passed, even with noscrub set).
> 
> Hmm, I thought that 'noscrub' would also stop deep scrubs, but I just 
> looked at the code and I was wrong.  So you should set nodeep-scrub too!

Yup, as I too had to find in the code

And it is even worse... You are very likely to get a stampeding horde of
OSDs going into deepscrub one after the other. This rendering your
cluster unworkable. This because very likely all timers more or less
will have the same expire.

It has hit us too.
On a friday just before I was packing my bag... I was home just a tid
bit late that day. :(

--WjW


> 
> sage
> 
> 
>>
>> Cheers, Dan
>>
>>
>> On Tue, Nov 15, 2016 at 11:35 PM, Sage Weil <sweil@redhat.com> wrote:
>>> Hi everyone,
>>>
>>> There was a regression in jewel that can trigger long OSD stalls during
>>> scrub.  How long the stalls are depends on how many objects are in your
>>> PGs, how fast your storage device is, and what is cached, but in at least
>>> one case they were long enough that the OSD internal heartbeat check
>>> failed and it committed suicide (120 seconds).
>>>
>>> The workaround for now is to simply
>>>
>>>  ceph osd set noscrub
>>>
>>> as the bug is only triggered by scrub.  A fix is being tested and will be
>>> available shortly.
>>>
>>> If you've seen any kind of weird latencies or slow requests on jewel, I
>>> suggest setting noscrub and seeing if they go away!
>>>
>>> The tracker bug is
>>>
>>>  http://tracker.ceph.com/issues/17859
>>>
>>> Big thanks to Yoann Moulin for helping track this down!
>>>
>>> sage
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

