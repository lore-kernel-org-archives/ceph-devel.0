From: Alex Elder <elder@inktank.com>
Subject: Re: rbd volume upgrades
Date: Fri, 09 Nov 2012 14:09:15 -0600
Message-ID: <509D62EB.1080508@inktank.com>
References: <CAPYLRziMQAR3tiN7syxBMTiiJ-xRVGYCK1MUYHrii5-UHMCnGA@mail.gmail.com> <509D53BD.6020706@inktank.com> <CAC-hyiEx3DatO+-5GEP7DiiZZEOgyYYFfNKhW1ebSpYmo464Tw@mail.gmail.com> <509D59DC.60706@inktank.com> <CAC-hyiFz2eb1CyJTKAv2YLWmPouABo77tM7ZbitFEKofsA+wsw@mail.gmail.com> <509D617E.1050000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51896 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640Ab2KIUJN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 15:09:13 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6495020iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 12:09:13 -0800 (PST)
In-Reply-To: <509D617E.1050000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/09/2012 02:03 PM, Josh Durgin wrote:
> On 11/09/2012 11:44 AM, Yehuda Sadeh wrote:
>> On Fri, Nov 9, 2012 at 11:30 AM, Josh Durgin <josh.durgin@inktank.com>
>> wrote:
>>> On 11/09/2012 11:08 AM, Yehuda Sadeh wrote:
>>>>
>>>> On Fri, Nov 9, 2012 at 11:04 AM, Josh Durgin <josh.durgin@inktank.com>
>>>> wrote:
>>>>>
>>>>> On 11/09/2012 11:01 AM, Gregory Farnum wrote:
>>>>>>
>>>>>>
>>>>>> I was asked today if there's a way to upgrade RBD volumes from v1 to
>>>>>> v2. I didn't think so, but wanted
>>>>>> 1) to make sure I'm right,
>>>>>> 2) to ask how hard it would be,
>>>>>> 3) to ask if we haven't done it because it didn't occur to us or
>>>>>> because it's too hard.
>>>>>> -Greg
>>>>>>
>>>>>
>>>>> This was addressed in the original discussions about format 2.
>>>>>
>>>>> You need to export and then import the volume as format 2. Format 2
>>>>> uses
>>>>> different names for objects, so providing an 'upgrade' path would
>>>>> still
>>>>> require copying all the data around.
>>>>>
>>>> Couldn't we just set a flag in the header specifying the object naming
>>>> version, which would then only require updating the header?
>>>>
>>>> Yehuda
>>>
>>>
>>> The header was separated from the id object to allow renames to work
>>> while the image was in use or with cloning. The whole header format
>>> changed and moved to a different object as a result. It would be
>>> messy to implement this kind of upgrade, and doesn't provide much
>>> benefit when there's an easy way to convert already. If someone really
>>> wanted it, it could be implemented, but otherwise I don't think it's
>>> worth adding. It would have to be added to the upcoming kernel
>>> layering support too.
>>>
>>
>> The assumption is that when you upgrade you don't go back, so the fact
>> that the header was separated from the id object doesn't change much.
>> An upgrade process would be the same as creating a new v2 image,
>> having object names (prefix?) that set as the original object names,
>> and with a version field that specifies that these are a v1 names.
>>
>> The problem that I see with converting v1 to v2 through copy is that
>> (besides the cumbersome and potentially very long process) we will end
>> up turning sparse data objects into fully written data objects, which
>> will affect the data consumption.
> 
> That's a good point about export. It would be good to make export create
> sparse files as well, but since it doesn't yet, the in-place upgrade
> would be better for space usage.

Plus!  It looks like you don't even need a flag.

I think if you simply recorded the old-format object prefix in the
new format header, all would be fine.  The format of the object
id has not changed between v1 and v2, just the object prefix.

					-Alex
