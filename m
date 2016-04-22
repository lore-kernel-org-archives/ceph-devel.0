From: Victor Denisov <vdenisov@mirantis.com>
Subject: Re: blueprint: consistency groups
Date: Fri, 22 Apr 2016 16:49:51 -0700
Message-ID: <CA+hcxJS+-HsTKpbASkWqr-gR8N6zF1k-pyWh8eQZCCC7sHCiLg@mail.gmail.com>
References: <CA+hcxJQqbi_oCMF+0=fgQ6-=W1k-KPw6Y_3pZZnXKe01=Z-dhQ@mail.gmail.com>
	<CAJ4mKGYHno0u4z8PkUz0gL9voeBPQCPP+TSroEQRy2+26H+WHQ@mail.gmail.com>
	<20160325071933.GA14634@gmail.com>
	<CAJ4mKGZHd1Bm558woz=2Agd-x7sDkQmarwQfZUkwSWAcmOb8ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:33278 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbcDVXtw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Apr 2016 19:49:52 -0400
Received: by mail-yw0-f170.google.com with SMTP id t10so138761768ywa.0
        for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2016 16:49:52 -0700 (PDT)
In-Reply-To: <CAJ4mKGZHd1Bm558woz=2Agd-x7sDkQmarwQfZUkwSWAcmOb8ew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>, Jason Dillaman <dillaman@redhat.com>

Hi,

I have a question regarding implementation of the 'add image to
consistency group' operation.
Since it's a multi object operation while I'm adding an image
reference to a consistency group the image itself can be deleted.
By the time I start adding consistency group reference to the image,
the image will be gone.
So, I have to keep track of my current state of the operation in the
consistency group.
However if I the librbd client looses connection to the ceph cluster
it all will end up in this partially updated state.
It's not clear to who is responsible for picking up this state and
cleaning it all up.

Should it be a special operation that allows us to check consistency
of all consistency groups?
Is there any agent that is supposed to verify consistency of all rbd
objects regularly?

Please advise.

Thanks in advance,
Victor.

P.S. Here is a link to the ether pad with the updated blue print:
http://pad.ceph.com/p/consistency_groups

On Tue, Mar 29, 2016 at 10:54 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Fri, Mar 25, 2016 at 12:19 AM, Mykola Golub <mgolub@mirantis.com> wrote:
>> On Thu, Mar 24, 2016 at 03:38:25PM -0700, Gregory Farnum wrote:
>>
>>> Just to be clear, you know that you can use the same snapid for all
>>> the images, right? (...although not if you're trying to allow CGs
>>> across pools. Those will be a little harder.)
>>
>> I think not allowing CGs across pools would be annoying limitation for
>> users. If a VM has several volumes for different purposes (e.g. small
>> but fast volume for applicatin data, and large but slow one for
>> backups) it is logical to have different pools for those.
>
> This isn't impossible either. We do it with cache pools and backing
> pools sharing a set of snapids, for instance. But the default rules
> won't work, since a snapid is just a 64-bit counter and they're
> per-pool rather than cluster-global.
> -Greg
