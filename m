From: Ross Turk <ross@inktank.com>
Subject: Re: RBD support for primary storage in Apache CloudStack
Date: Tue, 3 Jul 2012 11:22:04 -0700
Message-ID: <9D73B27951A84A4BAE2D131CBE78329C@inktank.com>
References: <4FEDD147.2090909@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48998 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab2GCSXH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 14:23:07 -0400
Received: by pbbrp8 with SMTP id rp8so9612368pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 11:23:06 -0700 (PDT)
In-Reply-To: <4FEDD147.2090909@widodh.nl>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>, John Wilkins <john.wilkins@inktank.com>


Hey Wido! This is really cool.

I think it'd be useful to have a "guide" that people can follow to stand up CloudStack with Ceph.  Even though it's still in active development, I'd like to encourage people to try it out.  Would you be willing to work with the Inktank team to create something like that?  I think we can do most of the writing, but we'll need help if we get stuck.

Cheers,
Ross



On Friday, June 29, 2012 at 9:01 AM, Wido den Hollander wrote: 
> Hi,
> 
> I'm cross-posting this to the ceph-devel list since there might be 
> people around here running CloudStack and are interested in this.
> 
> After a couple of months worth of work I'm happy to announce that the 
> RBD support for primary storage in CloudStack seems to be reaching a 
> point where it's good enough to be reviewed.
> 
> If you are planning to test RBD, please do read this e-mail carefully 
> since there are still some catches.
> 
> Although the code inside CloudStack doesn't seem like a lot of code, I 
> had to modify code outside CloudStack to get RBD support working:
> 
> 1. RBD storage pool support in libvirt. [0] [1]
> 2. Fix a couple of bugs in the libvirt-java bindings. [2]
> 
> With those issues addressed I could implement RBD inside CloudStack.
> 
> While doing so I ran into multiple issues inside CloudStack which 
> delayed everything a bit.
> 
> Now, the RBD support for primary storage knows limitations:
> 
> - It only works with KVM
> 
> - You are NOT able to snapshot RBD volumes. This is due to CloudStack 
> wanting to backup snapshots to the secondary storage and uses 'qemu-img 
> convert' for this. That doesn't work with RBD, but it's also very 
> inefficient.
> 
> RBD supports native snapshots inside the Ceph cluster. RBD disks also 
> have the potential to reach very large sizes. Disks of 1TB won't be the 
> exception. It would stress your network heavily. I'm thinking about 
> implementing "internal snapshots", but that is step #2. For now no 
> snapshots.
> 
> - You are able create a template from a RBD volume, but creating a new 
> instance with RBD storage from a template is still a hit-and-miss. 
> Working on that one.
> 
> Other than these limitations, everything works. You can create instances 
> and attach RBD disks. It also supports cephx authorization, so no 
> problem there!
> 
> What do you need to run this patch?
> - A Ceph cluster
> - libvirt with RBD storage pool support (>0.9.12)
> - Modified libvirt-java bindings (jar is in the patch)
> - Qemu with RBD support (>0.14)
> - A extra field "user_info" in the storage pool table, see the SQL 
> change in the patch
> 
> You can fetch the code on my Github account [3].
> 
> Warning: I'll be rebasing against the master branch regularly, so be 
> aware of git pull not always working nicely.
> 
> I'd like to see this code reviewed while I'm working on the latest stuff 
> and getting all the patches upstream in other projects (mainly the 
> libvirt Java bindings).
> 
> Any suggestions or comments?
> 
> Thank you!
> 
> Wido
> 
> 
> [0]: 
> http://libvirt.org/git/?p=libvirt.git;a=commit;h=74951eadef85e2d100c7dc7bd9ae1093fbda722f
> [1]: 
> http://libvirt.org/git/?p=libvirt.git;a=commit;h=122fa379de44a2fd0a6d5fbcb634535d647ada17
> [2]: https://github.com/wido/libvirt-java/commits/cloudstack
> [3]: https://github.com/wido/CloudStack/commits/rbd


--
Ross Turk
VP of Community, Inktank
@rossturk @inktank @ceph


"Any sufficiently advanced technology is indistinguishable from magic."
-- Arthur C. Clarke



