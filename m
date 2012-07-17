From: Australian Jade <sales@australianjade.com>
Subject: Intermittent loss of connectivity with KVM-Ceph-Network (solved)
Date: Tue, 17 Jul 2012 09:51:54 +0930
Message-ID: <5004B022.1070805@australianjade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:46022 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab2GQB04 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 21:26:56 -0400
Received: from x.logics.net.au (gw.logics.net.au [150.101.235.251] (may be forged))
	(authenticated bits=0)
	by mail.logics.net.au (8.14.5/8.14.1) with ESMTP id q6H0Ls8X003501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Tue, 17 Jul 2012 09:51:58 +0930
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

Just want to share my recent experience with KVM backed by RBD. Ceph 
appears to be not at fault but I post it here for others to read as my 
configuration is something other users of Ceph may configure.

Over last three weeks I was battling some elusive issue: KVM backed by 
RBD intermittently lost network under some consistent (but relatively 
low) load. It was driving me nuts as nothing appeared in the logs and 
everything was seemingly OK. With only one exception: pings to nearby 
host sometimes were coming with "No buffer space available" error and 
number of pings could be delayed by 20-30 seconds (obviously such delay 
causes a lot of timeouts). KVM has two network virtio interfaces and on 
host vhost_net module running. One interface is publicly available, 
second one connected to private network. I have tried to change virtio 
to e1000, increase network buffers - all in vain. I also noticed that 
when hold up on interface happened pings come back with second 
difference: ie they piling up on interface and then suddenly sent 
through all at once and remote host returns all of them pretty much 
simultaneously. Another observation which I have made: this behaviour 
was clearly evident when network/disk activity was reasonable - during 
backup. I have stopped backup for one day but it did not help (however 
loss of connectivity did not happen as much).

Being unable to identify the cause I started to pull things apart: I 
have moved image from RBD to qcow and magically everything became 
normal. Back to RBD and issue manifested itself again. But on other hand 
I had number of freshly installed VMs which also backed by RBD and do 
not have such issue. VMs which had this fault were different: they were 
migrated from hardware hosts to VM environment. Fresh VMs and migrated 
VMs are distro-synched FC17 and so I did not expect any difference. The 
only difference I had left was that migrated VMs were 32 bit and freshly 
installed were 64 bit. So in the end I have upgraded kernel in one 
faulty VM to 64 bit (while leaving balance of the system 32 bit) and 
problem disappeared! Next day I have upgraded another VM the same way 
and it also became problem free! So I am now sure that problem lies in 
32 bit kernel which is run on 64 bit host.

So I guess that there some race condition, likely in virtio_net driver 
or in tcp stack, which is apparently triggered by context switching from 
32 bit to 64 bit and io delays introduced by QEMU-RBD driver. Only when 
32 bit VM runs on 64 bit host and it is backed by RBD image this issue 
appears. Being unable to identify exact spot in the kernel were the 
problem is I even not sure where exactly I should report it to so I 
decided to post it here as the place where people with VMs backed by RBD 
most likely will look for solution.

Regards,
Vladimir
