From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: poor write performance
Date: Sat, 20 Apr 2013 17:04:44 -0400
Message-ID: <517302EC.5020701@gmail.com>
References: <6035A0D088A63A46850C3988ED045A4B4D7359C9@BITCOM1.int.sbss.com.au>  <516FE3CC.8080303@risc-software.at>  <6035A0D088A63A46850C3988ED045A4B4D736900@BITCOM1.int.sbss.com.au> <1366455175.10716.1.camel@lde-hro-01> <6035A0D088A63A46850C3988ED045A4B4F35E2CA@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:46315 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284Ab3DTVEr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Apr 2013 17:04:47 -0400
Received: by mail-ve0-f175.google.com with SMTP id m1so274293ves.6
        for <ceph-devel@vger.kernel.org>; Sat, 20 Apr 2013 14:04:46 -0700 (PDT)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B4F35E2CA@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: =?UTF-8?B?SGFyYWxkIFLDtsOfbGVy?= <Harald.Roessler@btd.de>, Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

James Harper wrote:
>> Hi James,
>>
>> do you VLAN's interfaces configured on your bonding interfaces? Because
>> I saw a similar situation in my setup.
>>
>
> No VLAN's on my bonding interface, although extensively used elsewhere.

What the OP described is *exactly* like a problem I've been struggling 
with. I thought the blame had lay elsewhere but maybe not.

My setup:

4 Ceph nodes, with 6 OSDs each and dual (bonded) 10GbE, with VLANs, 
running Precise. OSDs are using XFS. Replica count of 3. 3 of these are 
mons.
4 compute nodes, with dual (bonded) 10GbE, with VLANs, running a base of 
Precise along with a 3.6.3 Ceph-provided kernel, running KVM-based VMs. 
2 of these are also mons. VMs are Precise and accessing RBD through the 
kernel client.

(Eventually there will be 12 Ceph nodes. 5 mons seemed an appropriate 
number and when I've run into issues in the past I've actually gotten to 
cases where > 3 mons were knocked out, so 5 is a comfortable number 
unless it's problematic.)

In the VMs, I/O with ext4 is fine -- 10-15MB/s sustained. However, using 
ZFS (via ZFSonLinux, not FUSE), I see write speeds of about 150kb/sec, 
just like the OP.

I had figured that the problem lay with ZFS inside the VM (I've used 
ZFSonLinux on many bare metal machines without a problem for a couple of 
years now). The VMs were using virtio, and I'd heard that it was found 
that pre-1.4 Qemu versions could have some serious problems with virtio 
(which I didn't know at the time); also, I know that the kernel client 
is not the preferred client, and the version I'm using is a rather older 
version of the Ceph-provided builds. As a result, my plan was to try the 
updated Qemu version along with native Qemu librados RBD support once 
Raring was out, as I figured that the problem was either something in 
ZFSonLinux (though I reported the issue and nobody had ever heard of any 
such problem, or had any idea why it would be happening) or something 
specifically about ZFS running inside Qemu, as ext4 in the VMs is fine.

But, this thread has made me wonder if what's actually happening is in 
fact something else -- either something, as someone else saw, to do with 
using VLANs on the bonded interface (although I don't see such a write 
problem with any other traffic going through these VLANs); or, something 
about how ZFS inside the VM is writing to the RBD disk causing some kind 
of giant slowdown in Ceph. The numbers that the OP cited were exactly in 
line with what I was seeing.

I don't know offhand what the block sizes are that the kernel client was 
using, or that the different filesystems inside the VMs might be using 
when trying to write to their virtual disks (I'm guessing that if you 
are using virtio, as I am, it potentially could be anything). But 
perhaps ZFS writes extremely small blocks and ext4 doesn't.

Unfortunately, I don't have access to this testbed for the next few 
weeks, so for the moment I can only recount my experience and not 
actually test out any suggestions (unless I can corral someone with 
access to it to run tests).

Thanks,
Jeff
