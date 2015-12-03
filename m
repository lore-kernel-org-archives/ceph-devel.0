From: Sage Weil <sage@newdream.net>
Subject: RE: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 03:50:26 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33210 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbbLCLu0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 06:50:26 -0500
In-Reply-To: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

1- I agree we should avoid shared_ptr whenever possible.

2- unique_ptr should not have any more overhead than a raw pointer--the 
compiler is enforcing the single-owner semantics.  See for example

	https://msdn.microsoft.com/en-us/library/hh279676.aspx

"It is exactly is efficient as a raw pointer and can be used in STL 
containers."

Unless the implementation is broken somehow?  That seems unlikely...

sage

