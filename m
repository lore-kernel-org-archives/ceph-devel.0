From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Thu, 15 Aug 2013 07:20:36 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B65815D51@BITCOM1.int.sbss.com.au>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<20130419064524.GQ11427@reaktio.net>
	<6035A0D088A63A46850C3988ED045A4B62D9DA64@BITCOM1.int.sbss.com.au>
	<CAF6-1L7P3490N-Y9NE1BmXfNP19d7E_btrkkV4CFC+ARTgAr4Q@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B62E86BF8@BITCOM1.int.sbss.com.au>
	<CAF6-1L45U3DW4gRYaou1Ua5vvtzz+_XDz5B8WBBedhhM9igong@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B62F433FE@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B62F43442@BITCOM1.int.sbss.com.au>
	<CAF6-1L502OZGbPHp37vWzEU3H-wsK5z904ZtS7SEUmuM-GhLyA@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B63891798@BITCOM1.int.sbss.com.au>
	<CAF6-1L4=rY7AJpHGB33KPMk6LfX7q8CHphPzh9amdqwbYzg3dQ@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B6389552A@BITCOM1.int.sbss.com.au>
	<CAF6-1L6jJvYuHN+BoucU2RNzv2R9dpMhbD1UVF96mBPO25FM5g@mail.gmail.com>
	<520A4945.1030907@gmail.com>
	<CAF6-1L5mcB=Qs3=XpmFC_S2cPWHFaKChYP77ZhLh0+uvWhR3eQ@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B63896A4D@BITCOM1.int.sbss.com.au>
	<CAF6-1L6_GFvOq3nyQ-n20uiZHC4pAQm88_G3RFG2QjujoYGLpA@mail.gmail.com>
	<6035A0D088A63A46850C3988ED045A4B63896AF1@BITCOM1.int.sbss.com.au>
	<6035A0D088A63A46850C3988ED045A4B63896B4E@BITCOM1.int.sbss.com.au>
 <CAF6-1L42Fmuq3Ng_qD1Y99JQmtfCG1zzGQrbA2xBO-8JOyhk+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.bendigoit.com.au ([203.16.207.99]:53732 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab3HOHUu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Aug 2013 03:20:50 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Frederik Thuysbaert <frederik.thuysbaert@gmail.com>, =?iso-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

> >
> > Hi,
> >
> > > I just tested with tap2:aio and that worked (had an old image of the VM
> on
> > lvm still so just tested with that). Switching back to rbd and it crashes every
> > time, just as postgres is starting in the vm. Booting into single user mode,
> > waiting 30 seconds, then letting the boot continue it still crashes at the
> same
> > point so I think it's not a timing thing - maybe postgres has a disk access
> > pattern that is triggering the bug?
> >
> > Mmm, that's really interesting.
> >
> > Could you try to disable request merging ? Just give option
> > max_merge_size=0 in the tap2 disk description. Something like
> > 'tap2:tapdisk:rbd:rbd/test:max_merge_size=0,xvda2,w'
> >
> 
> Just as suddenly the problem went away and I can no longer reproduce the
> crash on startup. Very frustrating. Most likely it still crashed during heavy use
> but that can take days.
> 
> I've just upgraded librbd to dumpling (from cuttlefish) on that one server and
> will see what it's doing by morning. I'll disable merging when I can reproduce
> it next.
> 

I just had a crash since upgrading to dumpling, and will disable merging tonight.

James
