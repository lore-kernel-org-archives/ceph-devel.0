From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 17:02:04 +0000
Message-ID: <CO1PR02MB2087E3AF3553B6269FBC10DF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
 <alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0076.outbound.protection.outlook.com ([207.46.100.76]:34368
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752095AbbLCRCG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 12:02:06 -0500
In-Reply-To: <alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yes, I posted the new result after adding -O2 in the compiler flag and it shows almost no overhead with unique_ptr.
I will add the test of adding to list overhead and start implementing the new interface.
But, regarding my other point of changing all the objecstore interfaces (my first mail on this mail chain in case you have missed) taking Transaction, any thought of that ?
Should we reconsider having two queue_transaction interface ?

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net] 
Sent: Thursday, December 03, 2015 3:50 AM
To: Somnath Roy
Cc: Samuel Just (sam.just@inktank.com); ceph-devel@vger.kernel.org
Subject: RE: queue_transaction interface + unique_ptr + performance

1- I agree we should avoid shared_ptr whenever possible.

2- unique_ptr should not have any more overhead than a raw pointer--the compiler is enforcing the single-owner semantics.  See for example

	https://msdn.microsoft.com/en-us/library/hh279676.aspx

"It is exactly is efficient as a raw pointer and can be used in STL containers."

Unless the implementation is broken somehow?  That seems unlikely...

sage

