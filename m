From: Wido den Hollander <wido@42on.com>
Subject: Re: Persistent storage for Mgr Modules
Date: Mon, 29 Jan 2018 11:11:23 +0100
Message-ID: <f2020489-afb0-bbeb-9c57-a225523c2bae@42on.com>
References: <a813a336-1e16-1d34-cf8b-7179cf04dba0@42on.com>
 <CALe9h7fmH4=W6ZzQ3csyk1v9=8frNwcLNNdphQB0-=P0xkXc9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from se02-out.mail.pcextreme.nl ([185.66.251.201]:56449 "EHLO
        se02-out.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751805AbeA2KkE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 29 Jan 2018 05:40:04 -0500
In-Reply-To: <CALe9h7fmH4=W6ZzQ3csyk1v9=8frNwcLNNdphQB0-=P0xkXc9Q@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 01/29/2018 10:55 AM, John Spray wrote:
> On Mon, Jan 29, 2018 at 9:12 AM, Wido den Hollander <wido@42on.com> wrote:
>> Hi,
>>
>> I'm still working on the 'brag' module for the Mgr to send out a report
>> every X interval back to the Ceph project so that we get a feeling of how
>> people use Ceph.
>>
>> I'd like to store a timestamp of the last report send and then wait for it
>> to expire before sending a new one.
>>
>> The interval will be something like a week by default and I'd like to store
>> it somewhere persistent.
>>
>> Obviously I can store it in a local variable, but if the Mgr fails or is
>> restarted so is the module and thus that data is lost.
>>
>> Is it OK to use the config-key for this? It's not really configuration, but
>> is it allowed to store such values in there?
> 
> Yep!
> 

Awesome! I'll use that to store the timestamp persistently so that I can 
access it later.

> The "config" naming is a strong hint to programmers that this is not
> for bulk data, but ultimately it's all just bytes :-)
> 

True :-) Might want to put a limit on there on the MON (configurable?) 
to prevent people from using it as a rather large store.

Wido

> John
> 
>>
>> Thanks,
>>
>> Wido
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
