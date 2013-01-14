From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: rbd kernel driver on the osd server
Date: Mon, 14 Jan 2013 11:01:13 +0100
Message-ID: <CAF6-1L45L76mK25+w-z3=Y2PQngadfyGW8J1Y9jdUtYaC2SbMA@mail.gmail.com>
References: <20130113160840.GF27442@hro-mlt-02.local>
	<50F2F632.6060402@widodh.nl>
	<20130113184615.GG27442@hro-mlt-02.local>
	<alpine.DEB.2.00.1301131938100.10804@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:38242 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645Ab3ANKBO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jan 2013 05:01:14 -0500
Received: by mail-ob0-f178.google.com with SMTP id eh20so3669069obb.37
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 02:01:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301131938100.10804@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: =?ISO-8859-1?Q?Harald_R=F6=DFler?= <Harald.Roessler@btd.de>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

> The other problem to consider is the possibility of deadlock under memory
> pressure.  This is a problem with any network file system or block device
> that is backed by a user-level process on the same host.  When the VM
> system is under memory pressure, it will ask the fs to write out some
> dirty pages, which will be sent to a user-level process, that may need to
> allocate memory, which will block until the kernel is able to free more
> memory.  Deadlock.
>
> Machines with lots of memory and very conservative VM settings can
> probably avoid this in practice, but it is technically possible,
> and with default settings isn't terribly hard to trigger.

Am I correct to assume that this problem can't be triggered if :
 - Kernel RBD is running on the physical machine host ( dom0 on Xen )
 - OSD process runs in a VM inside a DomU ( and has it's own dedicated
physical memory which isn't even 'seen' by the Dom0, only the
hypervisor can see it).


Cheers,

      Sylvain
