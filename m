From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Wiping object content on removal
Date: Mon, 23 Nov 2015 11:11:30 -0600
Message-ID: <CAJ4mKGYuQ0mPU+BPXOU=_3Tqf+ySLmiUfozi0hNbybJLkkxVRw@mail.gmail.com>
References: <564C8E50.4070503@mirantis.com>
	<CAJ4mKGYBzWfd7DB6cj6o0dv8BTP4jkwSFRZGGfNTisdsxp2vDA@mail.gmail.com>
	<56534265.5040302@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34636 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbbKWRLb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 12:11:31 -0500
Received: by wmvv187 with SMTP id v187so171305172wmv.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 09:11:30 -0800 (PST)
In-Reply-To: <56534265.5040302@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 23, 2015 at 10:44 AM, Igor Fedotov <ifedotov@mirantis.com> wrote:
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

Yeah, I just don't see this happening. There aren't even exposed
primitives to do a secure erase on SSDs, are there? Plus turning a
delete operation into a full data overwrite....yuck.
-Greg
