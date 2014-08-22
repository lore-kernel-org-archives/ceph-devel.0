From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Deadlock in ceph journal
Date: Sat, 23 Aug 2014 10:38:33 +1200
Message-ID: <53F7C669.9010800@catalyst.net.nz>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AE7B@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1408192052530.28244@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF1D@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1408192149330.28244@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF69@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1408200832440.28244@cobra.newdream.net> <6AA21C22F0A5DA478922644AD2EC308C8B7FF7@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1408202051540.28244@cobra.newdream.net> <6AA21C22F0A5DA478922644AD2EC308C8B8342@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1408210822430.31169@cobra.newdream.net> <53F692AE.90007@catalyst.net.nz> <alpine.DEB.2.00.1408211749040.31169@cobra.newdream.net> <53F7C1C3.8000303@catalyst.net.nz
 > <755F6B91B3BE364F9BCA11EA3F9E0C6F264745A2@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:37569 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbaHVWig (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Aug 2014 18:38:36 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F264745A2@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sweil@redhat.com>
Cc: "Ma, Jianpeng" <jianpeng.ma@intel.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 23/08/14 10:22, Somnath Roy wrote:
> I think it is using direct io for non-aio mode as well.
>
> Thanks & Regards
> Somnath
>

> One thing that does still concern me - if I understand what is happening here correctly: we write to the journal using aio until we want to stop doing writes (presumably pre closing it), then use normal io to write at that point.
>
> Given that we appear to be using direct io whenever we use aio, does this mean we end up mixing direct and buffered io to the journal [1] (or is the normal i.e non aio write still using direct io)?
>
>

Thanks Somnath,

I think you are correct (I missed the bit in FileJournal::_open that 
seems to cover this):


   if (forwrite) {
     flags = O_RDWR;
     if (directio)
       flags |= O_DIRECT | O_DSYNC;


i.e the journal is opened with DIRECT, so all writes (async or not) will 
be direct.

Cheers

Mark
