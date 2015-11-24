From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Wiping object content on removal
Date: Tue, 24 Nov 2015 20:04:36 +0300
Message-ID: <565498A4.2070001@mirantis.com>
References: <564C8E50.4070503@mirantis.com>
 <CAJ4mKGYBzWfd7DB6cj6o0dv8BTP4jkwSFRZGGfNTisdsxp2vDA@mail.gmail.com>
 <56534265.5040302@mirantis.com>
 <CAJ4mKGYuQ0mPU+BPXOU=_3Tqf+ySLmiUfozi0hNbybJLkkxVRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36371 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbKXREm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Nov 2015 12:04:42 -0500
Received: by lfs39 with SMTP id 39so27594991lfs.3
        for <ceph-devel@vger.kernel.org>; Tue, 24 Nov 2015 09:04:41 -0800 (PST)
In-Reply-To: <CAJ4mKGYuQ0mPU+BPXOU=_3Tqf+ySLmiUfozi0hNbybJLkkxVRw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Gregory,

the idea is to wipe object content optionally - when user requests for that.
Thus not every delete operation will suffer from that.

Igor.

On 11/23/2015 8:11 PM, Gregory Farnum wrote:
> On Mon, Nov 23, 2015 at 10:44 AM, Igor Fedotov <ifedotov@mirantis.com> wrote:
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
> Yeah, I just don't see this happening. There aren't even exposed
> primitives to do a secure erase on SSDs, are there? Plus turning a
> delete operation into a full data overwrite....yuck.
> -Greg

