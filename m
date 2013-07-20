From: Wido den Hollander <wido@42on.com>
Subject: Re: Internal Qemu snapshots with RBD and libvirt
Date: Sat, 20 Jul 2013 10:42:41 +0200
Message-ID: <51EA4D81.5050800@42on.com>
References: <51E807DD.5050805@42on.com> <51E9BE0E.7020609@inktank.com> <alpine.DEB.2.00.1307191537260.795@cobra.newdream.net> <CALFpzo61shKeSA60ig9c5Ad+3WbTJgkHJRrmg5eEwEOdvjE-KQ@mail.gmail.com> <51E9DE68.40707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:52028 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727Ab3GTImo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 20 Jul 2013 04:42:44 -0400
In-Reply-To: <51E9DE68.40707@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Marcus Sorensen <shadowsor@gmail.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 07/20/2013 02:48 AM, Josh Durgin wrote:
> On 07/19/2013 03:47 PM, Marcus Sorensen wrote:
>> Does RBD not honor barriers and do proper sync flushes? Or does this
>> have to do with RBD caching? Just wondering why online snapshots
>> aren't safe.
>
> They're safe at the filesystem level, but I think Wido's after
> more application level consistency. If the fs journaled the metadata
> for a file but didn't save the data yet, it'd be nice to be able to
> restore the complete file.
>

Indeed, I'm about application level consistency. I'm now implementing a 
PoC where I simply snapshot the RBD image while the Instance is running.

Since CloudStack uses cache=none and RBD cache isn't enabled either it 
shouldn't hurt that much.

>> Qcow2 can keep snapshots internally, but qemu is also capable of doing
>> external dumps for other backing stores. I was thinking about this,
>> and it seems like you'd put the memory dump on secondary storage, like
>> a rados gateway or nfs share, so it can be read wherever the VM is
>> restored to. It would require some work in tracking that location,
>> however.
>
> This sounds like a good idea to me.
>

I haven't looked into that, but that seems like a libvirt thing other 
then CloudStack since libvirt is the one talking to Qemu.

I however think it should be generic, somebody wanting to snapshot a 
running RBD guest via libvirt shouldn't have to go through all kinds of 
trouble to get the Instance snapshotted.

But the question then indeed, where to store the memory contents? Create 
a new RBD image?

<orig rbd img name>.memory.<snapshot name>

Like that?

Wido

> Josh
>
>> On Fri, Jul 19, 2013 at 4:41 PM, Sage Weil <sage@inktank.com> wrote:
>>> On Fri, 19 Jul 2013, Josh Durgin wrote:
>>>> On 07/18/2013 08:21 AM, Wido den Hollander wrote:
>>>>> Hi,
>>>>>
>>>>> I'm working on the RBD integration for CloudStack 4.2 and now I got to
>>>>> the point snapshotting.
>>>>>
>>>>> The "problem" is that CloudStack uses libvirt for snapshotting
>>>>> Instances, but Qemu/libvirt also tries to store the memory contents of
>>>>> the domain to assure the snapshot is consistent.
>>>>>
>>>>> So the way libvirt tries to do it is not possible with RBD right now,
>>>>> since there is no way to store the internal memory.
>>>
>>> It seems like the way to view this is that to snapshot a VM, we need to
>>> snapshot all N block devices attached to it, plus the internal memory.
>>> It's not that there is something missing from the RBD block device
>>> snapshot function, but that it is not clear where to put the memory at
>>> all.
>>>
>>> Maybe the libvirt or qemu VM metadata should specify a separate image
>>> target for the RAM?  How is this normally done when you're using, say,
>>> qcow2?  It is assumed that it can be somehow stored with the first block
>>> device or something?
>>>
>>> sage
>>>
>>>>>
>>>>> I was thinking about using the Java librbd bindings to create the
>>>>> snapshot, but that will not be consistent thus not 100% safe, so I'd
>>>>> rather avoid that.
>>>>>
>>>>> How is this done in OpenStack? Or are you facing similar issues?
>>>>
>>>> OpenStack doesn't store the memory contents of a domain. For volume
>>>> snapshots, it requires that the volume is detached, so there can be
>>>> no inconsistency, and the actual snapshot handling is done by the
>>>> volume
>>>> driver in cinder, so libvirt is not involved at all. It just uses the
>>>> rbd command (or now the python bindings).
>>>>
>>>>> P.S.: I'm testing with libvirt 1.0.6 from the Ubuntu Cloud Team
>>>>> archive
>>>>> with packages for OpenStack Havana.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
