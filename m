From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Wiping object content on removal
Date: Tue, 24 Nov 2015 19:58:49 +0300
Message-ID: <56549749.9000906@mirantis.com>
References: <564C8E50.4070503@mirantis.com>
 <CAJ4mKGYBzWfd7DB6cj6o0dv8BTP4jkwSFRZGGfNTisdsxp2vDA@mail.gmail.com>
 <56534265.5040302@mirantis.com>
 <CABYiri-aV2t-OkcrAFLwyy-FWz5Vk-3S7PUxUfwa2Fijr7RKmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33912 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbKXQ6z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Nov 2015 11:58:55 -0500
Received: by lffu14 with SMTP id u14so29077551lff.1
        for <ceph-devel@vger.kernel.org>; Tue, 24 Nov 2015 08:58:54 -0800 (PST)
In-Reply-To: <CABYiri-aV2t-OkcrAFLwyy-FWz5Vk-3S7PUxUfwa2Fijr7RKmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Andrey,

thanks for your valuable comment.

Answering to your question - I don't have complete model. That was just 
a quick idea produced by the information that Openstack Cinder performs 
such wipe out when removing volumes (i.e. RBD images). And it does that 
by trivial writing to an image. Doing similar thing at Ceph level can be 
done faster and in background.

Thanks,
Igor

On 11/23/2015 7:53 PM, Andrey Korolyov wrote:
> On Mon, Nov 23, 2015 at 7:44 PM, Igor Fedotov <ifedotov@mirantis.com> wrote:
>> Hi Gregory,
>>
>> On 23.11.2015 18:52, Gregory Farnum wrote:
>>> On Wed, Nov 18, 2015 at 8:42 AM, Igor Fedotov <ifedotov@mirantis.com>
>>> wrote:
>>>> Hi Cephers.
>>>>
>>>> Does Ceph have an ability to wipe object content during one's removal?
>>>> Surely one can do that manually from the client but I think that's
>>>> ineffective and not 100% secure.
>>>>
>>>> If no - what's about adding such feature to Ceph?
>>>>    I can start working on that.
>>> Wipe object content during removal of what? The OSD? Or are you
>>> talking about secure erase of object data instead of unlinking files?
>> I meant secure object removal.
>>
>>> I'm not sure if any of that is really more interesting than just
>>> enabling disk encryption...
>>> -Greg
>> I agree that encryption is more secure but it consumes much more CPU
>> resources.
>>
>> Thanks,
>> Igor
>>
> Hi,
>
> just wondering - do you have a complete security model where secure
> erase is required, but data protection by itself is not important by
> itself? In any way, the immediate object wipeout is not fast - it
> could consume tens of minutes or even hours after actual erase
> command, which is actually negates the requirement of the effective
> data destruction. Commonly the erase procedure is required when a
> media is moved between different security access zones, which could be
> seen as a lifecycle operation and it does not depend on any software
> functionality within those zones.

