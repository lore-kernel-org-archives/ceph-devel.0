From: Sage Weil <sweil@redhat.com>
Subject: building boost statically
Date: Thu, 28 Apr 2016 18:47:55 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57456 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbcD1Wrt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Apr 2016 18:47:49 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF889C049D7F
	for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2016 22:47:48 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: kdreyer@redhat.com

Hi all,

We'd really like to use the latest boost, mainly so that we can use 
small_vector in a zillion places and avoid extra memory allocations.  The 
distros, as always, are behind.

The thoguht is to bring it in as yet another submodule, build it 
statically (it's pretty fast), and link statically.  There are a handful 
of places where the distro boost links dynamically.  For example, on 
xenial, it's

libboost-iostreams1.58.0
libboost-program-options1.58.0
libboost-random1.58.0
libboost-system1.58.0
libboost-thread1.58.0

I'm not sure how we should deal with that.  We could simply link it 
statically.  Alternatively, we could ship packages.. but if we do that we 
might as well just conditionally build against the new features and then 
build a full set of backported boost packages for the distros we care 
about.

I'm not sure how to best proceed.  But it would be really great to get 
access to new boost features like small_vector...

sage

