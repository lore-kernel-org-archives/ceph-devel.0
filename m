From: Victor Denisov <vdenisov@mirantis.com>
Subject: Re: blueprint: consistency groups
Date: Mon, 25 Apr 2016 14:11:36 -0700
Message-ID: <CA+hcxJSnUg1grhdBgOQPRcPK57VyW2Nyg9Rv6whZ3rj1ZoGU_Q@mail.gmail.com>
References: <CA+hcxJQqbi_oCMF+0=fgQ6-=W1k-KPw6Y_3pZZnXKe01=Z-dhQ@mail.gmail.com>
	<CAJ4mKGYHno0u4z8PkUz0gL9voeBPQCPP+TSroEQRy2+26H+WHQ@mail.gmail.com>
	<20160325071933.GA14634@gmail.com>
	<CAJ4mKGZHd1Bm558woz=2Agd-x7sDkQmarwQfZUkwSWAcmOb8ew@mail.gmail.com>
	<CA+hcxJS+-HsTKpbASkWqr-gR8N6zF1k-pyWh8eQZCCC7sHCiLg@mail.gmail.com>
	<CA+aFP1CnKvVJrWDmKhpziu5otOV73HC5gnUsgZ8+oDW+708Rag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34507 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964811AbcDYVLh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Apr 2016 17:11:37 -0400
Received: by mail-yw0-f180.google.com with SMTP id j74so205208307ywg.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Apr 2016 14:11:36 -0700 (PDT)
In-Reply-To: <CA+aFP1CnKvVJrWDmKhpziu5otOV73HC5gnUsgZ8+oDW+708Rag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

The problem that I see with this approach is: let's say we start
adding an image to a cg and the cg is in adding image state.
It either means that somebody is already adding an image to this cg or
somebody died while adding this image.
And we can't really understand it.

So, my suggestion is: normally the command fails if it finds the cg in
an unexpected state.
If the user adds flag --force then it picks up this unfinished
operation and completes it and then adds the new image.
How does that sound?

On Mon, Apr 25, 2016 at 7:23 AM, Jason Dillaman <jdillama@redhat.com> wrote:
> I would hope any necessary state tracking would be enough to allow the code
> to intelligently decide if an image is attached or not to the consistency
> group without the need for a special "check consistency" function.  In your
> example above, I should be able to remove the orphaned image from the CG
> without error.
>
> As an alternative, if you set an "attaching to CG" state in the image before
> adding the image link to the CG, you could prevent the deletion of the image
> but the CG could be deleted if an error occurred.  In this case, the image
> remove logic could be updated to permit deletion of orphaned CG images.
>
> On Fri, Apr 22, 2016 at 6:49 PM, Victor Denisov <vdenisov@mirantis.com>
> wrote:
>>
>> Hi,
>>
>> I have a question regarding implementation of the 'add image to
>> consistency group' operation.
>> Since it's a multi object operation while I'm adding an image
>> reference to a consistency group the image itself can be deleted.
>> By the time I start adding consistency group reference to the image,
>> the image will be gone.
>> So, I have to keep track of my current state of the operation in the
>> consistency group.
>> However if I the librbd client looses connection to the ceph cluster
>> it all will end up in this partially updated state.
>> It's not clear to who is responsible for picking up this state and
>> cleaning it all up.
>>
>> Should it be a special operation that allows us to check consistency
>> of all consistency groups?
>> Is there any agent that is supposed to verify consistency of all rbd
>> objects regularly?
>>
>> Please advise.
>>
>> Thanks in advance,
>> Victor.
>>
>> P.S. Here is a link to the ether pad with the updated blue print:
>> http://pad.ceph.com/p/consistency_groups
>>
>> On Tue, Mar 29, 2016 at 10:54 AM, Gregory Farnum <gfarnum@redhat.com>
>> wrote:
>> > On Fri, Mar 25, 2016 at 12:19 AM, Mykola Golub <mgolub@mirantis.com>
>> > wrote:
>> >> On Thu, Mar 24, 2016 at 03:38:25PM -0700, Gregory Farnum wrote:
>> >>
>> >>> Just to be clear, you know that you can use the same snapid for all
>> >>> the images, right? (...although not if you're trying to allow CGs
>> >>> across pools. Those will be a little harder.)
>> >>
>> >> I think not allowing CGs across pools would be annoying limitation for
>> >> users. If a VM has several volumes for different purposes (e.g. small
>> >> but fast volume for applicatin data, and large but slow one for
>> >> backups) it is logical to have different pools for those.
>> >
>> > This isn't impossible either. We do it with cache pools and backing
>> > pools sharing a set of snapids, for instance. But the default rules
>> > won't work, since a snapid is just a 64-bit counter and they're
>> > per-pool rather than cluster-global.
>> > -Greg
>
>
>
>
> --
> Jason
