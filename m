From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Wiping object content on removal
Date: Mon, 23 Nov 2015 19:53:42 +0300
Message-ID: <CABYiri-aV2t-OkcrAFLwyy-FWz5Vk-3S7PUxUfwa2Fijr7RKmQ@mail.gmail.com>
References: <564C8E50.4070503@mirantis.com> <CAJ4mKGYBzWfd7DB6cj6o0dv8BTP4jkwSFRZGGfNTisdsxp2vDA@mail.gmail.com>
 <56534265.5040302@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33165 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbbKWQyE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 11:54:04 -0500
Received: by lbbkw15 with SMTP id kw15so99570484lbb.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 08:54:03 -0800 (PST)
In-Reply-To: <56534265.5040302@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 23, 2015 at 7:44 PM, Igor Fedotov <ifedotov@mirantis.com> wrote:
> Hi Gregory,
>
> On 23.11.2015 18:52, Gregory Farnum wrote:
>>
>> On Wed, Nov 18, 2015 at 8:42 AM, Igor Fedotov <ifedotov@mirantis.com>
>> wrote:
>>>
>>> Hi Cephers.
>>>
>>> Does Ceph have an ability to wipe object content during one's removal?
>>> Surely one can do that manually from the client but I think that's
>>> ineffective and not 100% secure.
>>>
>>> If no - what's about adding such feature to Ceph?
>>>   I can start working on that.
>>
>> Wipe object content during removal of what? The OSD? Or are you
>> talking about secure erase of object data instead of unlinking files?
>
> I meant secure object removal.
>
>> I'm not sure if any of that is really more interesting than just
>> enabling disk encryption...
>> -Greg
>
> I agree that encryption is more secure but it consumes much more CPU
> resources.
>
> Thanks,
> Igor
>

Hi,

just wondering - do you have a complete security model where secure
erase is required, but data protection by itself is not important by
itself? In any way, the immediate object wipeout is not fast - it
could consume tens of minutes or even hours after actual erase
command, which is actually negates the requirement of the effective
data destruction. Commonly the erase procedure is required when a
media is moved between different security access zones, which could be
seen as a lifecycle operation and it does not depend on any software
functionality within those zones.
