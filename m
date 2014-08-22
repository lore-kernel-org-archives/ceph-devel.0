From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Deadlock in ceph journal
Date: Fri, 22 Aug 2014 12:45:34 +1200
Message-ID: <53F692AE.90007@catalyst.net.nz>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AE7B@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1408192052530.28244@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF1D@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1408192149330.28244@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF69@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1408200832440.28244@cobra.newdream.net> <6AA21C22F0A5DA478922644AD2EC308C8B7FF7@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1408202051540.28244@cobra.newdream.net> <6AA21C22F0A5DA478922644AD2EC308C8B8342@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1408210822430.31169@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:38782 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbaHVAph (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 20:45:37 -0400
In-Reply-To: <alpine.DEB.2.00.1408210822430.31169@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 22/08/14 03:23, Sage Weil wrote:
> I've pushed the patch to wip-filejournal.  Mark, can you test please?
>

I've tested wip-filejournal and looks good (25 test runs, good journal 
header each time).

Cheers

Mark
