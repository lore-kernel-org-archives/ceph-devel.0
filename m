From: Sage Weil <sweil@redhat.com>
Subject: RE: Deadlock in ceph journal
Date: Fri, 22 Aug 2014 15:32:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408221531300.31169@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AE7B@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1408192052530.28244@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF1D@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1408192149330.28244@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF69@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1408200832440.28244@cobra.newdream.net> <6AA21C22F0A5DA478922644AD2EC308C8B7FF7@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1408202051540.28244@cobra.newdream.net> <6AA21C22F0A5DA478922644AD2EC308C8B8342@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1408210822430.31169@cobra.newdream.net> <53F692AE.90007@catalyst.net.nz> <alpine.DEB.2.00.1408211749040.31169@cobra.newdream.net>
 <53F7C1C3.8000303@catalyst.net.nz> <755F6B91B3BE364F9BCA11EA3F9E0C6F264745A2@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55620 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbaHVWcH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Aug 2014 18:32:07 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F264745A2@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>, "Ma, Jianpeng" <jianpeng.ma@intel.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 22 Aug 2014, Somnath Roy wrote:
> I think it is using direct io for non-aio mode as well.

Right.  aio is always direct io (in our case at least).

sage

> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Mark Kirkwood [mailto:mark.kirkwood@catalyst.net.nz]
> Sent: Friday, August 22, 2014 3:19 PM
> To: Sage Weil
> Cc: Ma, Jianpeng; Somnath Roy; Samuel Just (sam.just@inktank.com); ceph-devel@vger.kernel.org
> Subject: Re: Deadlock in ceph journal
> 
> On 22/08/14 12:49, Sage Weil wrote:
> > On Fri, 22 Aug 2014, Mark Kirkwood wrote:
> >> On 22/08/14 03:23, Sage Weil wrote:
> >>> I've pushed the patch to wip-filejournal.  Mark, can you test please?
> >>>
> >>
> >> I've tested wip-filejournal and looks good (25 test runs, good
> >> journal header each time).
> >
> > Thanks!  Merged.
> >
> 
> Excellent.
> 
> One thing that does still concern me - if I understand what is happening here correctly: we write to the journal using aio until we want to stop doing writes (presumably pre closing it), then use normal io to write at that point.
> 
> Given that we appear to be using direct io whenever we use aio, does this mean we end up mixing direct and buffered io to the journal [1] (or is the normal i.e non aio write still using direct io)?
> 
> Cheers
> 
> Mark
> 
> [1] which I understand is bad...
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
