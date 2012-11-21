From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] use int64_t for return values from rbd
 instead of int
Date: Wed, 21 Nov 2012 09:43:09 +0100
Message-ID: <20121121084309.GA17466@stefanha-thinkpad.redhat.com>
References: <1353415495-30561-1-git-send-email-s.priebe@profihost.ag>
 <20121120162922.GA8665@stefanha-thinkpad.redhat.com>
 <50ABD713.3050300@profihost.ag>
 <CAJSP0QXcjaRdeQ55GSPtSqam+WHUGPAz4+ohajTCMR8f+4oKrQ@mail.gmail.com>
 <50AC8704.2020407@profihost.ag>
 <20121121082616.GB13504@stefanha-thinkpad.redhat.com>
 <50AC91C4.4070900@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:34091 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab2KUInM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 03:43:12 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so2700643eaa.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Nov 2012 00:43:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50AC91C4.4070900@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, ceph-devel@vger.kernel.org, pve-devel@pve.proxmox.com, josh.durgin@inktank.com

On Wed, Nov 21, 2012 at 09:33:08AM +0100, Stefan Priebe - Profihost AG wrote:
> Am 21.11.2012 09:26, schrieb Stefan Hajnoczi:
> >On Wed, Nov 21, 2012 at 08:47:16AM +0100, Stefan Priebe - Profihost AG wrote:
> >>Am 21.11.2012 07:41, schrieb Stefan Hajnoczi:
> >QEMU is currently in hard freeze and only critical patches should go in.
> >Providing steps to reproduce the bug helps me decide that this patch
> >should still be merged for QEMU 1.3-rc1.
> >
> >Anyway, the patch is straightforward, I have applied it to my block tree
> >and it will be in QEMU 1.3-rc1:
> >https://github.com/stefanha/qemu/commits/block
> 
> Thanks!
> 
> The steps to reproduce are:
> mkfs.xfs -f a whole device bigger than int in bytes. mkfs.xfs sends
> a discard. Important is that you use scsi-hd and set
> discard_granularity=512. Otherwise rbd disabled discard support.

Excellent, thanks!  I will add it to the commit description.

> Might you have a look at my other rbd fix too? It fixes a race
> between task cancellation and writes. The same race was fixed in
> iscsi this summer.

Yes.

Stefan
