From: Loic Dachary <loic@dachary.org>
Subject: Re: jewel 10.2.4 freeze
Date: Tue, 25 Oct 2016 12:36:34 +0200
Message-ID: <580F35B2.9050609@dachary.org>
References: <580E1C53.6060503@dachary.org> <87funlerf5.fsf@suse.com>
 <CA+aFP1C4DSn+skaQ_UL3KSABdiBZLBZ7SP0y9AE_4ANZ6PQUEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:59094 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941611AbcJYKgj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Oct 2016 06:36:39 -0400
In-Reply-To: <CA+aFP1C4DSn+skaQ_UL3KSABdiBZLBZ7SP0y9AE_4ANZ6PQUEQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Jason,

Ok, will wait for them to be merged before moving forward.

Cheers

On 25/10/2016 05:27, Jason Dillaman wrote:
> Nack for RBD pending the following:
> 
> https://github.com/ceph/ceph/pull/11467
> https://github.com/ceph/ceph/pull/11634
> 
> On Mon, Oct 24, 2016 at 10:46 AM, Abhishek L <abhishek@suse.com> wrote:
>>
>> Loic Dachary writes:
>>
>>> Hi Abhishek,
>>>
>>> If we were to freeze jewel 10.2.4 today it would have 115 backports[0]. Do you think it we should stop merging new backports and prepare for the release ? If so, I'll ask the lead of each component to make sure nothing is missing from their point of view.
>>
>> Yes, lets start getting the ack from the leads
>>>
>>> You can find the progress of the jewel 10.2.4 release in the ttp://tracker.ceph.com/issues/17487.
>>>
>>> Cheers
>>>
>>> [0] issues backported and merged in jewel 10.2.4 http://tracker.ceph.com/versions/524
>>>
>>> --
>>> Loïc Dachary, Artisan Logiciel Libre
>>
>>
>> Best,
>> Abhishek
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
