From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: RBD performance with many childs and snapshots
Date: Tue, 22 Dec 2015 18:04:20 -0800
Message-ID: <567A0124.5010303@redhat.com>
References: <56784DA9.9060304@42on.com> <56788281.7050200@redhat.com>
 <5679C6E8.9060702@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49588 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756035AbbLWCEU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Dec 2015 21:04:20 -0500
In-Reply-To: <5679C6E8.9060702@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 12/22/2015 01:55 PM, Wido den Hollander wrote:
> On 12/21/2015 11:51 PM, Josh Durgin wrote:
>> On 12/21/2015 11:06 AM, Wido den Hollander wrote:
>>> Hi,
>>>
>>> While implementing the buildvolfrom method in libvirt for RBD I'm stuck
>>> at some point.
>>>
>>> $ virsh vol-clone --pool myrbdpool image1 image2
>>>
>>> This would clone image1 to a new RBD image called 'image2'.
>>>
>>> The code I've written now does:
>>>
>>> 1. Create a snapshot called image1@libvirt-<epochtimestamp>
>>> 2. Protect the snapshot
>>> 3. Clone the snapshot to 'image1'
>>>
>>> wido@wido-desktop:~/repos/libvirt$ ./tools/virsh vol-clone --pool
>>> rbdpool image1 image2
>>> Vol image2 cloned from image1
>>>
>>> wido@wido-desktop:~/repos/libvirt$
>>>
>>> root@alpha:~# rbd -p libvirt info image2
>>> rbd image 'image2':
>>>      size 10240 MB in 2560 objects
>>>      order 22 (4096 kB objects)
>>>      block_name_prefix: rbd_data.1976451ead36b
>>>      format: 2
>>>      features: layering, striping
>>>      flags:
>>>      parent: libvirt/image1@libvirt-1450724650
>>>      overlap: 10240 MB
>>>      stripe unit: 4096 kB
>>>      stripe count: 1
>>> root@alpha:~#
>>>
>>> But this could potentially lead to a lot of snapshots with children on
>>> 'image1'.
>>>
>>> image1 itself will probably never change, but I'm wondering about the
>>> negative performance impact this might have on a OSD.
>>
>> Creating them isn't so bad, more snapshots that don't change don't have
>> much affect on the osds. Deleting them is what's expensive, since the
>> osds need to scan the objects to see which ones are part of the
>> snapshot and can be deleted. If you have too many snapshots created and
>> deleted, it can affect cluster load, so I'd rather avoid always
>> creating a snapshot.
>>
>>> I'd rather not hardcode a snapshot name like 'libvirt-parent-snapshot'
>>> into libvirt. There is however no way to pass something like a snapshot
>>> name in libvirt when cloning.
>>>
>>> Any bright suggestions? Or is it fine to create so many snapshots?
>>
>> You could have canonical names for the libvirt snapshots like you
>> suggest, 'libvirt-<timestamp>', and check via rbd_diff_iterate2()
>> whether the parent image changed since the last snapshot. That's a bit
>> slower than plain cloning, but with object map + fast diff it's fast
>> again, since it doesn't need to scan all the objects anymore.
>>
>> I think libvirt would need to expand its api a bit to be able to really
>> use it effectively to manage rbd. Hiding the snapshots becomes
>> cumbersome if the application wants to use them too. If libvirt's
>> current model of clones lets parents be deleted before children,
>> that may be a hassle to hide too...
>>
>
> I gave it a shot. callback functions are a bit new to me, but I gave it
> a try:
> https://github.com/wido/libvirt/commit/756dca8023027616f53c39fa73c52a6d8f86a223
>
> Could you take a look?

Left some comments on the commits. Looks good in general.

Josh

