From: Leen Besselink <leen@consolejunkie.net>
Subject: Re: QCOW2 to RBD format 2 in one step
Date: Tue, 14 May 2013 14:15:21 +0200
Message-ID: <20130514121521.GA23960@apia.perrit.net>
References: <51920F00.406@42on.com>
 <20130514103453.GD14890@apia.perrit.net>
 <5192257C.5000104@42on.com>
Reply-To: leen@consolejunkie.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta2.perrit.net ([194.213.15.114]:38862 "EHLO mta2.perrit.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840Ab3ENMPX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 May 2013 08:15:23 -0400
Received: from apia.perrit.net (apia.colo.hnglo.perrit.net [194.0.170.50])
	by mail.perrit.nl (Postfix) with ESMTP id EB1D82002F5
	for <ceph-devel@vger.kernel.org>; Tue, 14 May 2013 14:15:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5192257C.5000104@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 14, 2013 at 01:52:28PM +0200, Wido den Hollander wrote:
> On 05/14/2013 12:34 PM, Leen Besselink wrote:
> >On Tue, May 14, 2013 at 12:16:32PM +0200, Wido den Hollander wrote:
> >>Hi,
> >>
> 
> Hi Leen,
> 
> >
> >Hi Wido,
> >
> >>While working on the CloudStack code for 4.2 I'm running into some
> >>problems with QCOW2 and RBD format 2.
> >>
> >>A quick cap of the problem:
> >>
> >>CloudStack stores all the templates on "Secondary Storage" as QCOW2 files.
> >>
> >>When a VM is deployed, this image will be copied (once) from
> >>Secondary Storage to Primary Storage, this is done by qemu-img which
> >>does the conversion.
> >>
> >>When the image is on Primary Storage it will be copied to the
> >>destination volume and the Instance/VM is started.
> >>
> >>In that last step I want to use layering, but the problem is that my
> >>image is RBD format 1 due to the qemu-img copy.
> >>
> >>I can skip the qemu-img copy, but I have to find a way to go from
> >>QCOW2 to RBD format 2 in preferably one step. There is a issue about
> >>this in the tracker [0], but that won't be finished on time.
> >>
> >>Another idea would be to do QCOW2 -> RAW -> RBD format 2, but that
> >>extra step will take a lot of time. It would also require some
> >>temporary storage on the hypervisor.
> >>
> >>I also thought of creating the RBD image prior to converting to it,
> >>but that fails, since qemu-img won't let you convert to a already
> >>existing image.
> >>
> >>Any brights ideas? Maybe even doing the QCOW2 -> RAW format in
> >>memory? In Java?
> >>
> >
> >I'm no expert, but would it be possible to change qemu-img to support writing RAW to standard out ?
> >
> 
> No, qemu-img can't write to stdout. Due to various formats it supports.
> 

I meant extending qemu-img to support that, it would probably be less
work than the work needed for the issue below. But the longer I think
about it. It would only be able to do that for RAW. And RAW isn't very
efficient anyway.

> >So you can run qemu-img convert and pipe that drectly to the rbd import command ?
> >
> 
> If qemu-img would support writing to stdout there is the problem
> that I'm not using the rbd tool, but Java bindings for librbd and
> librados. I'm trying to avoid executing from Java.
> 
> >rbd import already supports standard in I believe.
> >
> >Then you don't need any temporary storage.
> >
> >Maybe something more efficient than RAW is possible as well ?
> >
> >>The goal is to go from QCOW2 to RBD format 2 in one step.
> >>
> >>[0]: http://tracker.ceph.com/issues/4897
> >>
> >>--
> >>Wido den Hollander
> >>42on B.V.
> >>
> >>Phone: +31 (0)20 700 9902
> >>Skype: contact42on
> >>--
> >>To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >--
> >To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> -- 
> Wido den Hollander
> 42on B.V.
> 
> Phone: +31 (0)20 700 9902
> Skype: contact42on
