From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Internal Qemu snapshots with RBD and libvirt
Date: Fri, 19 Jul 2013 17:48:40 -0700
Message-ID: <51E9DE68.40707@inktank.com>
References: <51E807DD.5050805@42on.com> <51E9BE0E.7020609@inktank.com> <alpine.DEB.2.00.1307191537260.795@cobra.newdream.net> <CALFpzo61shKeSA60ig9c5Ad+3WbTJgkHJRrmg5eEwEOdvjE-KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:49387 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab3GTAt6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jul 2013 20:49:58 -0400
Received: by mail-ea0-f180.google.com with SMTP id k10so2740342eaj.11
        for <ceph-devel@vger.kernel.org>; Fri, 19 Jul 2013 17:49:57 -0700 (PDT)
In-Reply-To: <CALFpzo61shKeSA60ig9c5Ad+3WbTJgkHJRrmg5eEwEOdvjE-KQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Sorensen <shadowsor@gmail.com>
Cc: Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 07/19/2013 03:47 PM, Marcus Sorensen wrote:
> Does RBD not honor barriers and do proper sync flushes? Or does this
> have to do with RBD caching? Just wondering why online snapshots
> aren't safe.

They're safe at the filesystem level, but I think Wido's after
more application level consistency. If the fs journaled the metadata
for a file but didn't save the data yet, it'd be nice to be able to
restore the complete file.

> Qcow2 can keep snapshots internally, but qemu is also capable of doing
> external dumps for other backing stores. I was thinking about this,
> and it seems like you'd put the memory dump on secondary storage, like
> a rados gateway or nfs share, so it can be read wherever the VM is
> restored to. It would require some work in tracking that location,
> however.

This sounds like a good idea to me.

Josh

> On Fri, Jul 19, 2013 at 4:41 PM, Sage Weil <sage@inktank.com> wrote:
>> On Fri, 19 Jul 2013, Josh Durgin wrote:
>>> On 07/18/2013 08:21 AM, Wido den Hollander wrote:
>>>> Hi,
>>>>
>>>> I'm working on the RBD integration for CloudStack 4.2 and now I got to
>>>> the point snapshotting.
>>>>
>>>> The "problem" is that CloudStack uses libvirt for snapshotting
>>>> Instances, but Qemu/libvirt also tries to store the memory contents of
>>>> the domain to assure the snapshot is consistent.
>>>>
>>>> So the way libvirt tries to do it is not possible with RBD right now,
>>>> since there is no way to store the internal memory.
>>
>> It seems like the way to view this is that to snapshot a VM, we need to
>> snapshot all N block devices attached to it, plus the internal memory.
>> It's not that there is something missing from the RBD block device
>> snapshot function, but that it is not clear where to put the memory at
>> all.
>>
>> Maybe the libvirt or qemu VM metadata should specify a separate image
>> target for the RAM?  How is this normally done when you're using, say,
>> qcow2?  It is assumed that it can be somehow stored with the first block
>> device or something?
>>
>> sage
>>
>>>>
>>>> I was thinking about using the Java librbd bindings to create the
>>>> snapshot, but that will not be consistent thus not 100% safe, so I'd
>>>> rather avoid that.
>>>>
>>>> How is this done in OpenStack? Or are you facing similar issues?
>>>
>>> OpenStack doesn't store the memory contents of a domain. For volume
>>> snapshots, it requires that the volume is detached, so there can be
>>> no inconsistency, and the actual snapshot handling is done by the volume
>>> driver in cinder, so libvirt is not involved at all. It just uses the
>>> rbd command (or now the python bindings).
>>>
>>>> P.S.: I'm testing with libvirt 1.0.6 from the Ubuntu Cloud Team archive
>>>> with packages for OpenStack Havana.
