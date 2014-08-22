From: Sage Weil <sweil@redhat.com>
Subject: Re: Deadlock in ceph journal
Date: Thu, 21 Aug 2014 17:49:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408211749040.31169@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AE7B@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1408192052530.28244@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF1D@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1408192149330.28244@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF69@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1408200832440.28244@cobra.newdream.net> <6AA21C22F0A5DA478922644AD2EC308C8B7FF7@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1408202051540.28244@cobra.newdream.net> <6AA21C22F0A5DA478922644AD2EC308C8B8342@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1408210822430.31169@cobra.newdream.net> <53F692AE.90007@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49918 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbaHVAtN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 20:49:13 -0400
In-Reply-To: <53F692AE.90007@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: "Ma, Jianpeng" <jianpeng.ma@intel.com>, Somnath Roy <Somnath.Roy@sandisk.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 22 Aug 2014, Mark Kirkwood wrote:
> On 22/08/14 03:23, Sage Weil wrote:
> > I've pushed the patch to wip-filejournal.  Mark, can you test please?
> > 
> 
> I've tested wip-filejournal and looks good (25 test runs, good journal header
> each time).

Thanks!  Merged.

sage
