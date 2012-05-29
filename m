From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Tue, 29 May 2012 10:22:34 +0200
Message-ID: <4FC4874A.8050701@profihost.ag>
References: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:56026 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab2E2IWf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 04:22:35 -0400
In-Reply-To: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

Am 29.05.2012 05:54, schrieb Alexandre DERUMIER:
>>> This happens with ext4 or btrfs too. 
> 
> maybe this is related to io scheduler ?
> did you have compared cfq,deadline,noop scheduler ?

This is something i consider for performance tuning later on, when
everything is running smooth. Right now i'm using CFQ with the tuned IBM
settings (which proxmox uses too).


Here are some outputs of basic fio Tests running on 3.4 and 3.0.

3.4: http://pastebin.com/raw.php?i=6GEKsCYH
3.0: http://pastebin.com/raw.php?i=FU4AtUck

strangely 3.4 is faster but this corresponds to the fact that the normal
Disk I/O is working fine with 3.4 It's just ceph which isn't working fine.

> also what's is your sas/sata controller  ?
Intel onboard SATA controller in this testsetup.

Stefan
