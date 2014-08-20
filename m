From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Deadlock in ceph journal
Date: Wed, 20 Aug 2014 16:58:51 +1200
Message-ID: <53F42B0B.9090908@catalyst.net.nz>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AE7B@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1408192052530.28244@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF1D@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:34461 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbaHTE64 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Aug 2014 00:58:56 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2646AF1D@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sweil@redhat.com>
Cc: "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "jianpeng.ma@intel.com" <jianpeng.ma@intel.com>

Not yet,

If you have to use master either revert commit 
4eb18dd487da4cb621dcbecfc475fc0871b356ac or apply the patch for fixing 
the hang mentioned here https://github.com/ceph/ceph/pull/2185

Otherwise you could use the wip-filejournal branch which Sage has just 
added!

Cheers

Mark


On 20/08/14 16:38, Somnath Roy wrote:
> Thanks Sage !
> So, the latest master should have the fix, right ?
>


