From: Sage Weil <sweil@redhat.com>
Subject: wip-auth
Date: Thu, 22 Jan 2015 15:55:37 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501221512580.19192@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51471 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbbAVXzl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 22 Jan 2015 18:55:41 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: andreas.bluemle@itxperts.de
Cc: ceph-devel@vger.kernel.org

Hi Andreas,

I took a look at the wip-auth I mentioned in the security call last 
week... and the patch didn't work at all.  Sorry if you wasted any 
time trying it.

Anyway, I fixed it up so that it actually worked and made one other 
optimization.  It would be great to hear what latencies you measure with 
the changes in place.

Also, it might be worth trying --with-cryptopp (or --with-nss if you built 
cryptopp by default) to see if there is a difference.  There is a ton of 
boilerplate setting up encryption contexts and key structures and so on 
that I suspect could be cached (perhaps stashed in the CryptoKey struct?) 
with a bit of effort.  See

	https://github.com/ceph/ceph/blob/master/src/auth/Crypto.cc#L99-L213

sage
