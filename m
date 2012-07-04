From: Wido den Hollander <wido@widodh.nl>
Subject: Re: RBD support for primary storage in Apache CloudStack
Date: Wed, 04 Jul 2012 14:54:57 +0200
Message-ID: <4FF43D21.80702@widodh.nl>
References: <4FEDD147.2090909@widodh.nl> <9D73B27951A84A4BAE2D131CBE78329C@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:52123 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab2GDMy7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 08:54:59 -0400
In-Reply-To: <9D73B27951A84A4BAE2D131CBE78329C@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ross Turk <ross@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, John Wilkins <john.wilkins@inktank.com>

Hi,

On 03-07-12 20:22, Ross Turk wrote:
>
> Hey Wido! This is really cool.
>
> I think it'd be useful to have a "guide" that people can follow to stand up CloudStack with Ceph.  Even though it's still in active development, I'd like to encourage people to try it out.  Would you be willing to work with the Inktank team to create something like that?  I think we can do most of the writing, but we'll need help if we get stuck.
>

Yes, would be great! I think most users will start to use it via the 
WebGUI, so we should document that first.

A fast and short write-up of the steps:

1. Get a Ceph cluster running
2. Have one or multiple hosts with the proper Qemu and libvirt (>= 
0.9.13) code
3. Set up CloudStack from the RBD branch (compile by hand)
4. Set up your zones with NFS primary storage
5. Add the RBD primary storage and add the tag 'rbd'
6. Create a disk offering with the storage tag 'rbd'

NFS primary storage is still needed for the System VM's inside CloudStack.

There is however still one libvirt patch outstanding for when people are 
not using cephx: 
https://www.redhat.com/archives/libvir-list/2012-June/msg01119.html

I'm also hunting a bug under Ubuntu 12.04 where stored 'secrets' in 
libvirt get corrupted. The root has been found, but it's an external 
library which is causing problems.

The thread: 
https://www.redhat.com/archives/libvir-list/2012-July/msg00135.html

Wido

> Cheers,
> Ross
>
>
>
> On Friday, June 29, 2012 at 9:01 AM, Wido den Hollander wrote:
>> Hi,
>>
>> I'm cross-posting this to the ceph-devel list since there might be
>> people around here running CloudStack and are interested in this.
>>
>> After a couple of months worth of work I'm happy to announce that the
>> RBD support for primary storage in CloudStack seems to be reaching a
>> point where it's good enough to be reviewed.
>>
>> If you are planning to test RBD, please do read this e-mail carefully
>> since there are still some catches.
>>
>> Although the code inside CloudStack doesn't seem like a lot of code, I
>> had to modify code outside CloudStack to get RBD support working:
>>
>> 1. RBD storage pool support in libvirt. [0] [1]
>> 2. Fix a couple of bugs in the libvirt-java bindings. [2]
>>
>> With those issues addressed I could implement RBD inside CloudStack.
>>
>> While doing so I ran into multiple issues inside CloudStack which
>> delayed everything a bit.
>>
>> Now, the RBD support for primary storage knows limitations:
>>
>> - It only works with KVM
>>
>> - You are NOT able to snapshot RBD volumes. This is due to CloudStack
>> wanting to backup snapshots to the secondary storage and uses 'qemu-img
>> convert' for this. That doesn't work with RBD, but it's also very
>> inefficient.
>>
>> RBD supports native snapshots inside the Ceph cluster. RBD disks also
>> have the potential to reach very large sizes. Disks of 1TB won't be the
>> exception. It would stress your network heavily. I'm thinking about
>> implementing "internal snapshots", but that is step #2. For now no
>> snapshots.
>>
>> - You are able create a template from a RBD volume, but creating a new
>> instance with RBD storage from a template is still a hit-and-miss.
>> Working on that one.
>>
>> Other than these limitations, everything works. You can create instances
>> and attach RBD disks. It also supports cephx authorization, so no
>> problem there!
>>
>> What do you need to run this patch?
>> - A Ceph cluster
>> - libvirt with RBD storage pool support (>0.9.12)
>> - Modified libvirt-java bindings (jar is in the patch)
>> - Qemu with RBD support (>0.14)
>> - A extra field "user_info" in the storage pool table, see the SQL
>> change in the patch
>>
>> You can fetch the code on my Github account [3].
>>
>> Warning: I'll be rebasing against the master branch regularly, so be
>> aware of git pull not always working nicely.
>>
>> I'd like to see this code reviewed while I'm working on the latest stuff
>> and getting all the patches upstream in other projects (mainly the
>> libvirt Java bindings).
>>
>> Any suggestions or comments?
>>
>> Thank you!
>>
>> Wido
>>
>>
>> [0]:
>> http://libvirt.org/git/?p=libvirt.git;a=commit;h=74951eadef85e2d100c7dc7bd9ae1093fbda722f
>> [1]:
>> http://libvirt.org/git/?p=libvirt.git;a=commit;h=122fa379de44a2fd0a6d5fbcb634535d647ada17
>> [2]: https://github.com/wido/libvirt-java/commits/cloudstack
>> [3]: https://github.com/wido/CloudStack/commits/rbd
>
>
> --
> Ross Turk
> VP of Community, Inktank
> @rossturk @inktank @ceph
>
>
> "Any sufficiently advanced technology is indistinguishable from magic."
> -- Arthur C. Clarke
>
>
>

