From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: RE: Deadlock in ceph journal
Date: Mon, 25 Aug 2014 01:03:45 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C8B8831@SHSMSX101.ccr.corp.intel.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AE7B@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1408192052530.28244@cobra.newdream.net>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF1D@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1408192149330.28244@cobra.newdream.net>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF69@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1408200832440.28244@cobra.newdream.net>
 <6AA21C22F0A5DA478922644AD2EC308C8B7FF7@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1408202051540.28244@cobra.newdream.net>
 <6AA21C22F0A5DA478922644AD2EC308C8B8342@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1408210822430.31169@cobra.newdream.net>
 <53F692AE.90007@catalyst.net.nz>
 <alpine.DEB.2.00.1408211749040.31169@cobra.newdream.net>
 <53F7C1C3.8000303@catalyst.net.nz>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F264745A2@SACMBXIP01.sdcorp.global.sandisk.com>
 <53F7C669.9010800@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1642 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188AbaHYBDt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 24 Aug 2014 21:03:49 -0400
In-Reply-To: <53F7C669.9010800@catalyst.net.nz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>, Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sweil@redhat.com>
Cc: "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,
   At weekend, I read the kernel code about aio & direction. For close(), it don't wait aio to complete.
But for fsync(), it will wait all aio to complete. 
   Mark used this patch(which using fsync() on write_thread_entry) and the result is looks good.
   I want to revert the patch which don't use aio when closing journal. And using fsync(). It make the code simple.
   How about this?

Thanks!
Jianpeng

> ceph-devel@vger.kernel.org
> Subject: Re: Deadlock in ceph journal
> 
> On 23/08/14 10:22, Somnath Roy wrote:
> > I think it is using direct io for non-aio mode as well.
> >
> > Thanks & Regards
> > Somnath
> >
> 
> > One thing that does still concern me - if I understand what is happening here
> correctly: we write to the journal using aio until we want to stop doing writes
> (presumably pre closing it), then use normal io to write at that point.
> >
> > Given that we appear to be using direct io whenever we use aio, does this
> mean we end up mixing direct and buffered io to the journal [1] (or is the
> normal i.e non aio write still using direct io)?
> >
> >
> 
> Thanks Somnath,
> 
> I think you are correct (I missed the bit in FileJournal::_open that seems to
> cover this):
> 
> 
>    if (forwrite) {
>      flags = O_RDWR;
>      if (directio)
>        flags |= O_DIRECT | O_DSYNC;
> 
> 
> i.e the journal is opened with DIRECT, so all writes (async or not) will
> be direct.
> 
> Cheers
> 
> Mark
