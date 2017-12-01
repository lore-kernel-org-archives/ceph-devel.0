From: Igor Fedotov <ifedotov@suse.de>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_osd:_fine-grained_statistics_for_?=
 =?UTF-8?Q?object_space_usage?=
Date: Fri, 1 Dec 2017 17:23:52 +0300
Message-ID: <d277e426-90a4-593b-fdbd-8ba19919de43@suse.de>
References: <201711300849388246138@zte.com.cn>
 <alpine.DEB.2.11.1711300304240.8333@piezo.novalocal>
 <CAJ4mKGb8uFJ738YU9BKT3S3h7ePhVFbLkz+KyEQn+e2S8BbArQ@mail.gmail.com>
 <alpine.DEB.2.11.1711302125440.12766@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753225AbdLAOX5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 1 Dec 2017 09:23:57 -0500
In-Reply-To: <alpine.DEB.2.11.1711302125440.12766@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Xie Xingguo <xie.xingguo@zte.com.cn>

On 12/1/2017 12:27 AM, Sage Weil wrote:
> On Thu, 30 Nov 2017, Gregory Farnum wrote:
>> On Wed, Nov 29, 2017 at 7:06 PM Sage Weil <sweil@redhat.com> wrote:
>>> On Thu, 30 Nov 2017, xie.xingguo@zte.com.cn wrote:
>>>> （My network connection seems to be problematic, resending :( ）
>>>>
>>>>    Anyway, I am + 1 for doing this in a more effective way (e.g., as Igor
>>>> suggested).
>>>>
>>>>    The potential big challenge might be making the scrub-process happy,
>>>> though!
>>> Would this be something like:
>>>
>>> 1- an object_info_t field like uint32_t allocated_size, which has been
>>> incorporated into the pg summation, and
>>>
>>> 2- an ObjectStore method that returns the allocated size for an object?
>>>
>>> The challenge I see is that the new value (or delta) needs to be sorted
>>> out at the transaction prepare time because the stat update is part of the
>>> transaction, but we won't really know what the result is until bluestore
>>> (or any other impl) does it's write preparation work.  :/
>>
>> It would take some doing but this might be a good time to start adding
>> delayed work. We could get the stat updates as part of the objectstore
>> callback and incorporate them into future disk ops, and part of the
>> startup/replay process could be querying for stat updates to objects
>> we haven’t committed yet.
>>
>> ...except we don’t really have an OSD-level or pg replay phase any
>> more, do we. Hrmm. And doing it in the transaction would require some
>> sort of set-up/query phase to the transaction, then finalization and
>> submission, which isn’t great since it impacts checksumming and other
>> stuff (although *hopefully* not actual allocation).
> Hmm, and there is a larger problem here: we can't really make this
> ObjectStore implementation specific because it may vary across OSDs (some
> may be BlueStore, some may be FileStore).
IMO first of all we should determine what parameter(s) would we track. 
Object logical space usage (as we do now) or physical allocations or both.
For logical space tracking it's probably not an issue to have uniform 
results among different stores - FileStore replicates what we have at 
OSD, BlueStore do the same on its own data structures.
or physical allocation tracking we must handle different results from 
different store types as they are really not the same. I.e. object 
physical size (with 3 replications) should be  calculated as
   size = size_rep1 + size_rep2 + size_rep3
not
   size = size_primary * 3

Also wondering if mixed object store environments have any non-academic 
value?
> Even if we didn't have that issue, it constrains the ordering somewhat:
> you would need to prepare and submit the local transaction (to get
> the stat delta) before sending the replica writes.
>
> I think this sort of layer boundary crossing would make our lives very
> difficult down the line.  :/
>
> sage

