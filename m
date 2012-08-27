From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: ESXi and ideal hardware spec
Date: Mon, 27 Aug 2012 13:23:29 -0700
Message-ID: <503BD741.8000708@inktank.com>
References: <00b501cd8480$2dc46b60$894d4220$@netmass.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40500 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab2H0UXc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 16:23:32 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so8039375pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 13:23:32 -0700 (PDT)
In-Reply-To: <00b501cd8480$2dc46b60$894d4220$@netmass.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Perkins <perkins@netmass.com>
Cc: ceph-devel@vger.kernel.org

On 08/27/2012 11:17 AM, Stephen Perkins wrote:
> Are there any thoughts on placing all Ceph nodes as single virtual machines
> running on top of an ESXi hypervisor?   What I mean by this is that each
> brick runs ESXi and then only runs one virtual machine.

This sounds like it's going to have a bunch of overhead, but if
the performance under ESXi is acceptable to you, it might make sense.
I'm not aware of anyone testing OSDs on ESXi, so you could run into
performance issues that don't appear on real hardware.

> Are there any advantages of running the MON and MDS servers as independent
> virtual machines on the same physical brick as an OSD virtual machine
> (rather than just running the processes)?  Multi-port Ethernet systems can
> segregate traffic between the instances...

If your kernel/glibc doesn't support syncfs(2), running the monitor in
a virtual machine can be beneficial since it won't affect the OSD when
calling sync(2). I don't see many other advantages, since the monitors
are pretty light-weight.

It might be a disadvantage to run the MDS in vm, since it will make a
large chunk of memory unusable by the OSD, even after the MDS stops
using some of it, and vice versa. You may prefer to be able to control
the amount of memory available to each independently, but I don't see
much advantage there. The OSD will require more memory during recovery
than during normal usage, so running the MDS and OSD as processes lets
them use the memory the other doesn't need at the moment. The MDS
effectively serves as a cache, so having lots of memory for it is
important for metadata-heavy workloads.

Josh
