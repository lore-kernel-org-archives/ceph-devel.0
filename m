From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 17:40:16 +0000
Message-ID: <CO1PR02MB2081012549C4D8027F4BF80F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
 <alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
 <1998646860.28019612.1449155791509.JavaMail.zimbra@redhat.com>
 <CO1PR02MB208F00D967903C505E92074F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
 <20151203171704.GA13420@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0078.outbound.protection.outlook.com ([207.46.100.78]:28352
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750894AbbLCRkT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 12:40:19 -0500
In-Reply-To: <20151203171704.GA13420@ultraspiritum.redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Casey Bodley <cbodley@redhat.com>, Sage Weil <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hmm..Thanks Adam, so, one of the cleanups on the Ceph path could be to introduce make_shared..
We will come up with a prototype of optimized io path with removing unnecessary use of shared_ptr and see how much overall gain we are getting..

Thanks & Regards
Somnath

-----Original Message-----
From: Adam C. Emerson [mailto:aemerson@redhat.com] 
Sent: Thursday, December 03, 2015 9:17 AM
To: Somnath Roy
Cc: Casey Bodley; Sage Weil; Samuel Just (sam.just@inktank.com); ceph-devel@vger.kernel.org
Subject: Re: queue_transaction interface + unique_ptr + performance

On 03/12/2015, Somnath Roy wrote:
> I don't think make_shared / make_unique is part of c++11 (and ceph is using that). It is part of c++14 I guess..

std::make_shared is in C++11, std::make_unique is in C++14. In addition to performance, std::make_shared is also more correct, in that:

  std::shared_ptr<T>(new T)

can leak object allocated by 'new T' if the allocation for the shared_ptr fails.

std::make_unique is nice for cleanliness and symmetry, but doesn't add anything for performance or safety. (Also you can write your own make_unique, where make_shared is intimately involved with the details of shared_ptr.)
