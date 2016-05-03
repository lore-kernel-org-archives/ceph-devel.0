From: Mark Nelson <mnelson@redhat.com>
Subject: Re: mon switch from leveldb to rocksdb
Date: Tue, 3 May 2016 12:32:02 -0500
Message-ID: <bbcaee37-30ff-a26f-c76c-7fa6b6d75fa4@redhat.com>
References: <alpine.DEB.2.11.1605021444320.26967@cpach.fuggernut.com>
 <5727A3DC.7070102@symas.com>
 <bee8107b-0d3e-3ebc-d029-ed27e0165137@redhat.com>
 <CAJ4mKGbsJBk_8N8tkmqhYOipXXQC-LdiV=XOZ8S22HCCXh8_OA@mail.gmail.com>
 <ffb1914f-0321-c5d7-bab6-4c5fb0f67441@redhat.com>
 <alpine.DEB.2.11.1605031314160.26967@cpach.fuggernut.com>
 <CAJ4mKGahdrWPpz+DuC2993oerkdvwu1VD3y4sKWN2aQ_+f+8Eg@mail.gmail.com>
 <alpine.DEB.2.11.1605031322480.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49199 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934134AbcECRcL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 May 2016 13:32:11 -0400
In-Reply-To: <alpine.DEB.2.11.1605031322480.26967@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: Howard Chu <hyc@symas.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 05/03/2016 12:23 PM, Sage Weil wrote:
> On Tue, 3 May 2016, Gregory Farnum wrote:
>>>> In those leveldb tests we only saw writes and write trims hit by those
>>>> periodic 10-60 second high-latency spikes, but if I recall the mon has (or at
>>>> least had?) a global lock where write stalls would basically make the whole
>>>> monitor stall.  I think Joao might have improved that after we did this
>>>> testing but I don't remember the details at this point.
>>>
>>> I don't think any of this locking has changed...
>>
>> The paxos state machine is no longer blocked for reads while an
>> unrelated write is happening. Nor are older-version reads on the
>> writing subsystem. That fix is post-firefly, right?
>
> Oh yeah, it was new in hammer, I think.  I forgot those tests were that
> old!

Time goes by fast when you are having fun?  Indeed those tests are 
nearly 2 years old at this point.

I guess my question is given the state machine improvements do we expect 
those leveldb write/wtrim latency spikes to still cause major mon 
stalls?  On the other hand, is the osdmap read cache enough to help 
offset the lower read performance in (this configuration of) rocksdb?

I'm still worried about those big leveldb write latency spikes, but 
maybe it's less of an issue now and the average read performance is a 
bigger issue.

>
> sage
>
