From: Wido den Hollander <wido@widodh.nl>
Subject: Re: How to use ruleset
Date: Tue, 25 Sep 2012 11:56:58 +0200
Message-ID: <50617FEA.9010700@widodh.nl>
References: <CAGfy=6=6P1zA-0gkBqEowuuiP0qqCjnFpGCSM-R0xKBL13W7uQ@mail.gmail.com> <50573BF1.4010001@widodh.nl> <CAGfy=6mGaH_MP+3ROUqhLGYHikPUvFHZwR3H=9za6qmnn=ZZuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:42799 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab2IYJ5A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 05:57:00 -0400
In-Reply-To: <CAGfy=6mGaH_MP+3ROUqhLGYHikPUvFHZwR3H=9za6qmnn=ZZuA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org



On 09/25/2012 11:32 AM, hemant surale wrote:
> I have created to different types "host (osd0,osd1 in it) , ghost
> (osd2 in it ) " and used two separate crushrules to use them.
>
>

Could you sent your crushmap? Attachment or pastebin?

> so can i create two different pools utilizing two different
> crush_ruleset for data placement . Right now I am using Ceph v 0.36
> with it , when i do so it goes unresponsive.
>
>

I still recommend upgrading to at least version 0.48.2

Wido

>
> Regards,
> Hemant Surale.
>
>
>
> On Mon, Sep 17, 2012 at 8:34 PM, Wido den Hollander <wido@widodh.nl> wrote:
>> On 09/17/2012 11:42 AM, hemant surale wrote:
>>>
>>> Hi Community,
>>>
>>>            I have read the documentation to know crush map as well as
>>> inserting new crushmap, But I have qn that even after writing own rule
>>> for data placement how we can apply it for data placement? in short
>>> how to utilize newly specified rule when new data insertion is
>>> executed.
>>>
>>
>> Every rule has a "ruleset" ID which is an integer, like:
>>
>> rule data {
>>          ruleset 0
>>          ...
>>          ...
>> }
>>
>> Every pool has an attribute called "crush_ruleset 0".
>>
>> So if you change the ruleset in the crushmap it will re-distribute all the
>> data according to the new rule. New data will be placed according to this
>> new ruleset.
>>
>> If you created a NEW ruleset you should create a new pool like this:
>>
>> $ rados mkpool mynewpool 0 4
>>
>> See --help for more information.
>>
>> This should however get you going.
>>
>> Wido
>>
>>>           Currently I am using "rados -p <poolname> put/get Objname
>>> filename" cmd to put/get data into ceph.
>>>
>>> Thanks for helping me out till now.
>>>
>>>
>>>
>>> Regards,
>>> Hemant Surale.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
