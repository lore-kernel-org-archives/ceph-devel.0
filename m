From: Dietmar Maurer <dietmar@proxmox.com>
Subject: RE: RBD trim / unmap support?
Date: Fri, 2 Nov 2012 08:21:51 +0000
Message-ID: <24E144B8C0207547AD09C467A8259F7557708C8B@lisa.maurer-it.com>
References: <509306CC.5080307@profihost.ag> <5093078C.4020404@inktank.com>
 <50938233.9090902@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.maurer-it.com ([213.129.239.114]:37682 "EHLO
	proxmox.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab2KBIWA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 04:22:00 -0400
In-Reply-To: <50938233.9090902@profihost.ag>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hw/ide/qdev.c:        error_report("discard_granularity must be 512 for ide");

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Stefan Priebe - Profihost AG
> Sent: Freitag, 02. November 2012 09:20
> To: Josh Durgin
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: RBD trim / unmap support?
> 
> Am 02.11.2012 00:36, schrieb Josh Durgin:
> > On 11/01/2012 04:33 PM, Stefan Priebe wrote:
> >> Hello list,
> >>
> >> does rbd support trim / unmap? Or is it planned to support it?
> >>
> >> Greets,
> >> Stefan
> >
> > librbd (and thus qemu) support it. The rbd kernel module does not yet.
> > See http://ceph.com/docs/master/rbd/qemu-rbd/#enabling-discard-trim
> 
> Thanks! Is there any recommanded value for discard_granularity? With
> fstrim and iscsi i use 128kb.
> 
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html


