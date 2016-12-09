From: =?UTF-8?B?QsOhcmEgQW7EjWluY292w6E=?= <bara@redhat.com>
Subject: Re: [Ceph Doc Conventions] ObjectStore, FileStore, BlueStore x Object
 Store, File Store, Blue Store
Date: Fri, 9 Dec 2016 16:18:22 +0100
Message-ID: <c436096e-8425-aad5-b930-cb6f5532f200@redhat.com>
References: <13e0f1cc-5b25-6b05-65fb-66b961eafe7c@redhat.com>
 <CALe9h7cre-GhZgwzuoNOzK_V=EXaDP6mrau6N=uQxS39r5FZsA@mail.gmail.com>
 <9708b99d-6500-32f8-2974-49652626b209@redhat.com>
 <CAJ4mKGa6P93kXBNo3D0xwjK=scdZn4tYn7D5bVke27XSJVvSbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753088AbcLIPS0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Dec 2016 10:18:26 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5339067BD5
        for <ceph-devel@vger.kernel.org>; Fri,  9 Dec 2016 15:18:26 +0000 (UTC)
In-Reply-To: <CAJ4mKGa6P93kXBNo3D0xwjK=scdZn4tYn7D5bVke27XSJVvSbw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: John Spray <jspray@redhat.com>, Federico Lucifredi <flucifre@redhat.com>, Neil Levine <nlevine@redhat.com>, ceph-docs <ceph-docs@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 12/08/2016 10:23 PM, Gregory Farnum wrote:
> On Thu, Dec 8, 2016 at 4:37 AM, Bára Ančincová <bara@redhat.com> wrote:
>> Hi John,
>>
>>
>> On 12/08/2016 01:23 PM, John Spray wrote:
>>>
>>> On Thu, Dec 8, 2016 at 11:12 AM, Bára Ančincová <bara@redhat.com> wrote:
>>>>
>>>> Dear all,
>>>>
>>>> the Ceph documentation team is currently developing Ceph documentation
>>>> conventions and we ran into the following question:
>>>>
>>>> What is the preferred spelling of various stores?
>>>>
>>>> I saw that the Ceph community mainly uses FileStore and BlueStore [1][2].
>>>> However, we have Object Store in our guidelines[3] and we'd prefer to use
>>>> it
>>>> that way. Based on this logic it should be File Store and Blue Store.
>>>>
>>>> What spelling would you prefer? Is it ok to move from FileStore and
>>>> BlueStore to File Store and Blue Store in the official downstream docs?
>>>
>>>
>>> I would prefer that these not be re-written because:
>>>  * It creates unnecessary diffs between upstream docs and vendor docs
>>> (more work for you!)
>>>  * It decreases googleability (or at least forces the search engine to
>>> work harder to unify the two spellings)
>>>
>>> It's a bit different to Filesystem vs. File System, because that was
>>> an existing term where different people use different forms, whereas
>>> these are our own terms.  To me, writing Blue Store instead of
>>> BlueStore feels a bit like writing Mac Book instead of MacBook.
>>>
>>> Regarding Object Store: it depends on the context and whether you're
>>> talking about a generic Object Store (like RGW/S3) or whether you're
>>> talking about the internal Ceph component (which I would always call
>>> ObjectStore).  I store my S3 objects in an object store, but I
>>> configure my OSD to use ObjectStore.
>>>
>>> John
>>
>>
>> Thank you very much for this explanation. This is exactly what we've been
>> looking for and why we reached out to the wider community.
>>
>> Has anyone else different preference? If not we will use FileStore,
>> BlueStore and ObjectStore and I'll update the Ceph conventions accordingly.
>
> I think maybe you and John are referring to different things by
> "Object Store" and "ObjectStore" in the examples you both gave. There
> is an ObjectStore for backing the OSD the same way we have BlueStore
> and FileStore, but it's not supported and I don't think should ever be
> mentioned in downstream pages. There's also the Red Hat Ceph Storage
> Object Store (or whatever we call RGW in product terms) and that is
> always two words, as John said. :)
> -Greg

Even better, thank you Greg for the explanation.

>>
>> Cheers,
>>
>> Bara
>>
>>
>>
>>>
>>>> Please feel free to include anyone else who might be interested in this
>>>> topic.
>>>>
>>>> Cheers,
>>>>
>>>> Bara
>>>>
>>>> [1]
>>>>
>>>> http://www.sebastien-han.fr/blog/2013/12/02/ceph-performance-interesting-things-going-on/
>>>> [2]
>>>> http://www.sebastien-han.fr/blog/2016/03/21/ceph-a-new-store-is-coming/
>>>> [3]
>>>>
>>>> https://gitlab.cee.redhat.com/ccs-internal-documentation/glossary-of-terms-and-conventions-for-product-documentation/merge_requests/28/diffs
>>>> (disclaimer - still WIP and many things are missing. Please free to
>>>> comment
>>>> if you have any feedback. We will definitely share the final version with
>>>> you to get your ack. I personally believe that Ceph docs conventions is
>>>> something that we really need to achieve consistency in our docs and to
>>>> improve them.)
>>>>
>>>> --
>>>> Bara Ancincova
>>>> Technical Writer
>>>> Customer Content Services
>>>> IRC nick: bara
>>>>
>>>> Red Hat Czech, s.r.o.
>>>> Purkynova 99
>>>> 612 45 Brno, Czech Republic
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>> --
>> Bara Ancincova
>> Technical Writer
>> Customer Content Services
>> IRC nick: bara
>>
>> Red Hat Czech, s.r.o.
>> Purkynova 99
>> 612 45 Brno, Czech Republic
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Bara Ancincova
Technical Writer
Customer Content Services
IRC nick: bara

Red Hat Czech, s.r.o.
Purkynova 99
612 45 Brno, Czech Republic
