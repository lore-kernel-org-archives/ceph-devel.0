From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 17:48:29 +0000
Message-ID: <CO1PR02MB208C446A80363743FC5D341F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
 <alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
 <CO1PR02MB2087E3AF3553B6269FBC10DF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
 <20151203172508.GB13420@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bbn0100.outbound.protection.outlook.com ([157.56.111.100]:6939
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751849AbbLCRsc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 12:48:32 -0500
In-Reply-To: <20151203172508.GB13420@ultraspiritum.redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Sage Weil <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yes, that we can do..But, in that case aren't we restricting user if they want to do something with this Transaction object later. I didn't go through each and every part of the code yet (which is huge) that are using these interfaces to understand if it is using Transaction object afterwards.

Thanks & Regards
Somnath
-----Original Message-----
From: Adam C. Emerson [mailto:aemerson@redhat.com] 
Sent: Thursday, December 03, 2015 9:25 AM
To: Somnath Roy
Cc: Sage Weil; Samuel Just (sam.just@inktank.com); ceph-devel@vger.kernel.org
Subject: Re: queue_transaction interface + unique_ptr + performance

On 03/12/2015, Somnath Roy wrote:
> Yes, I posted the new result after adding -O2 in the compiler flag and it shows almost no overhead with unique_ptr.
> I will add the test of adding to list overhead and start implementing the new interface.
> But, regarding my other point of changing all the objecstore interfaces (my first mail on this mail chain in case you have missed) taking Transaction, any thought of that ?
> Should we reconsider having two queue_transaction interface ?

As I understand it, the concern with switching to unique_ptr was that the callee would move from the reference without this being known to the caller.

Would it make sense to pass as an RValue reference (i.e. TransactionRef&&)? That way the compiler should demand that the callers explicitly use std::move on the reference they're holding, documenting at the site of the call that they're willing to give up ownership.


-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
