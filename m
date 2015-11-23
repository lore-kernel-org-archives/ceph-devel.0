From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Wiping object content on removal
Date: Mon, 23 Nov 2015 19:44:21 +0300
Message-ID: <56534265.5040302@mirantis.com>
References: <564C8E50.4070503@mirantis.com>
 <CAJ4mKGYBzWfd7DB6cj6o0dv8BTP4jkwSFRZGGfNTisdsxp2vDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33816 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbbKWQoW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 11:44:22 -0500
Received: by lffu14 with SMTP id u14so111630592lff.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 08:44:21 -0800 (PST)
In-Reply-To: <CAJ4mKGYBzWfd7DB6cj6o0dv8BTP4jkwSFRZGGfNTisdsxp2vDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Gregory,

On 23.11.2015 18:52, Gregory Farnum wrote:
> On Wed, Nov 18, 2015 at 8:42 AM, Igor Fedotov <ifedotov@mirantis.com> wrote:
>> Hi Cephers.
>>
>> Does Ceph have an ability to wipe object content during one's removal?
>> Surely one can do that manually from the client but I think that's
>> ineffective and not 100% secure.
>>
>> If no - what's about adding such feature to Ceph?
>>   I can start working on that.
> Wipe object content during removal of what? The OSD? Or are you
> talking about secure erase of object data instead of unlinking files?
I meant secure object removal.

> I'm not sure if any of that is really more interesting than just
> enabling disk encryption...
> -Greg
I agree that encryption is more secure but it consumes much more CPU 
resources.

Thanks,
Igor


