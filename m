From: Gregory Farnum <greg@inktank.com>
Subject: Re: KVM/RBD Block device hangs
Date: Mon, 21 May 2012 13:57:15 -0700
Message-ID: <CAPYLRzgpKPU0cu85nUrH96B8=EfM=QPD=jjfWPHRz1N9MdCRVw@mail.gmail.com>
References: <4FBA54E2.3000703@profihost.ag>
	<4FBA559D.7040902@widodh.nl>
	<4FBA5647.40101@profihost.ag>
	<4FBA584F.7070406@widodh.nl>
	<4FBAAAC2.3020600@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57171 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758513Ab2EUU5Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 16:57:16 -0400
Received: by lbbgm6 with SMTP id gm6so3778158lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 13:57:15 -0700 (PDT)
In-Reply-To: <4FBAAAC2.3020600@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, May 21, 2012 at 1:51 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Am 21.05.2012 16:59, schrieb Wido den Hollander:
>
>> Probably after, but both is fine. I just want to know how your cluster
>> is doing and what the PG states are.
>
> will do so.
>
> dmesg says at least:
> [ 4975.850765] ceph-osd[6226]: segfault at 439d34000 ip 00007f0db39bfb23 sp
> 00007f0da8c5e240 error 4 in libtcmalloc.so.0.0.0[7f0db399b000+3d000]

This is not an error we've seen before, and it's a little scary. Can you
1) run gdb and get a backtrace and a printout of each frame in the trace?
2) reproduce with high-level OSD debug logging enabled?
