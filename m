From: Wido den Hollander <wido@42on.com>
Subject: Re: Fwd: Kernel-client crash when adding OSDs
Date: Wed, 30 Apr 2014 20:10:37 +0200
Message-ID: <53613C9D.4090604@42on.com>
References: <CAPZO0-PHskHZD+ToWxC6tuor3wN5=-dDhdv3Q-ZfjzBx1uyGmQ@mail.gmail.com> <CAPZO0-OGSB==YAPejRPYX_PEAWTADKcrvj1j_JbLnnkSPKP8og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:59453 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbaD3SKk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Apr 2014 14:10:40 -0400
In-Reply-To: <CAPZO0-OGSB==YAPejRPYX_PEAWTADKcrvj1j_JbLnnkSPKP8og@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thorwald Lundqvist <thorwald@jumpstarter.io>, ceph-devel@vger.kernel.org

On 04/30/2014 04:16 PM, Thorwald Lundqvist wrote:
> Hi!
>
> A few days ago I added a bunch of new OSDs to hour production servers,
> we have 3 hosts that maps and unmaps hundreds of RBD devices every
> day. with aprox 100 RBD devs mapped at each host at any given time.
>
> Adding OSDs is usually quite smooth if you do it the right way. I
> usually follow the Manual adding/remove of osd as explained in the
> documentation. Except when it comes to the crush add, i prefer
> decompiling and compiling my own crush map.
 >
> So I preceded as usuall, prepared the OSD disks, keyring and so on,
> and then I started up 4 new ceph-osd (osd.{9,10,11,12}) on the new OSD
> host. BAM; a host that had a bunch of RBD devs mapped crashed and
> rebooted with this in the log: http://pastebin.com/YKJSdWLv
>

That procedure seems right, I've done that multiple times and it all 
worked fine. That was with librbd and RGW though, so I'm not sure if 
this was a kernel issue.

> I realise that this is not much to go on since there's no stack trace
> or anything, but if anyone can help me reproduce this, I'd be
> grateful. And if anyone had the same issue would really like to hear
> from them too.
>
> I'm running Linux 3.14.1 and ceph 0.72.2.
>
> Thank you for your time,
> Thorwald Lundqvist.
> Jumpstarter AB
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
